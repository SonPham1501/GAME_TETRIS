// ignore_for_file: constant_identifier_names, overridden_fields

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_tetris/material/audios/button_audio_controller.dart';
import 'package:game_tetris/widgets/gamer/block.dart';

///the height of game pad
const GAME_PAD_MATRIX_H = 20;

///the width of game pad
const GAME_PAD_MATRIX_W = 10;

///state of [GameControl]
enum GameStates {
  none,
  paused,
  running,
  reset,
  mixing,
  clear,
  drop,
}

class Game extends StatefulWidget {
  final Widget child;
  final WidgetRef ref;

  const Game({Key? key, required this.child, required this.ref}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return GameControl();
  }

  static GameControl of(BuildContext context) {
    final state = context.findAncestorStateOfType<GameControl>();
    assert(state != null, "must wrap this context with [Game]");
    return state!;
  }
}

///duration for show a line when reset
const _REST_LINE_DURATION = Duration(milliseconds: 50);

const _LEVEL_MAX = 6;

const _LEVEL_MIN = 1;

const _SPEED = [
  Duration(milliseconds: 800),
  Duration(milliseconds: 650),
  Duration(milliseconds: 500),
  Duration(milliseconds: 370),
  Duration(milliseconds: 250),
  Duration(milliseconds: 160),
];

class GameControl extends State<Game> with RouteAware {
  late final buttonAudioController = widget.ref.read(buttonAudioControllerProvider);

  GameControl() {
    //inflate game pad data
    for (int i = 0; i < GAME_PAD_MATRIX_H; i++) {
      _data.add(List.filled(GAME_PAD_MATRIX_W, 0));
      _mask.add(List.filled(GAME_PAD_MATRIX_W, 0));
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    // routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPushNext() {
    //pause when screen is at background
    pause();
  }

  ///the gamer data
  final List<List<int>> _data = [];
  final List<List<int>> _mask = [];

  ///from 1-6
  int _level = 1;

  int _points = 0;

  int _cleared = 0;

  Block? _current;

  Block _next = Block.getRandom();

  GameStates _states = GameStates.none;

  Block _getNext() {
    final next = _next;
    _next = Block.getRandom();
    return next;
  }

  // SoundState get _sound => Sound.of(context);

  void rotate() {
    if (_states == GameStates.running) {
      final next = _current?.rotate();
      if (next != null && next.isValidInMatrix(_data)) {
        _current = next;
        // _sound.rotate();
        buttonAudioController.rotate();
      }
    }
    setState(() {});
  }

  void right() {
    if (_states == GameStates.none && _level < _LEVEL_MAX) {
      _level++;
    } else if (_states == GameStates.running) {
      final next = _current?.right();
      if (next != null && next.isValidInMatrix(_data)) {
        _current = next;
        // _sound.move();
        buttonAudioController.move();
      }
    }
    setState(() {});
  }

  void left() {
    if (_states == GameStates.none && _level > _LEVEL_MIN) {
      _level--;
    } else if (_states == GameStates.running) {
      final next = _current?.left();
      if (next != null && next.isValidInMatrix(_data)) {
        _current = next;
        // _sound.move();
        buttonAudioController.move();
      }
    }
    setState(() {});
  }

  void drop() async {
    if (_states == GameStates.running) {
      for (int i = 0; i < GAME_PAD_MATRIX_H; i++) {
        final fall = _current?.fall(step: i + 1);
        if (fall != null && !fall.isValidInMatrix(_data)) {
          _current = _current?.fall(step: i);
          _states = GameStates.drop;
          setState(() {});
          await Future.delayed(const Duration(milliseconds: 100));
          _mixCurrentIntoData(mixSound: () {});
          _mixCurrentIntoData(mixSound: buttonAudioController.fall);
          break;
        }
      }
      setState(() {});
    } else if (_states == GameStates.paused || _states == GameStates.none) {
      _startGame();
    }
  }

  void down({bool enableSounds = true}) {
    if (_states == GameStates.running) {
      final next = _current?.fall();
      if (next != null && next.isValidInMatrix(_data)) {
        _current = next;
        if (enableSounds) {
          // _sound.move();
          buttonAudioController.move();
        }
      } else {
        _mixCurrentIntoData();
      }
    }
    setState(() {});
  }

  Timer? _autoFallTimer;

  ///mix current into [_data]
  Future<void> _mixCurrentIntoData({VoidCallback? mixSound}) async {
    if (_current == null) {
      return;
    }
    //cancel the auto falling task
    _autoFall(false);

    _forTable((i, j) => _data[i][j] = _current?.get(j, i) ?? _data[i][j]);

    final clearLines = [];
    for (int i = 0; i < GAME_PAD_MATRIX_H; i++) {
      if (_data[i].every((d) => d == 1)) {
        clearLines.add(i);
      }
    }

    if (clearLines.isNotEmpty) {
      setState(() => _states = GameStates.clear);

      buttonAudioController.clear();

      for (int count = 0; count < 5; count++) {
        for (var line in clearLines) {
          _mask[line].fillRange(0, GAME_PAD_MATRIX_W, count % 2 == 0 ? -1 : 1);
        }
        setState(() {});
        await Future.delayed(const Duration(milliseconds: 100));
      }
      for (var line in clearLines) {
        _mask[line].fillRange(0, GAME_PAD_MATRIX_W, 0);
      }

      for (var line in clearLines) {
        _data.setRange(1, line + 1, _data);
        _data[0] = List.filled(GAME_PAD_MATRIX_W, 0);
      }
      debugPrint("clear lines : $clearLines");

      _cleared += clearLines.length;
      _points += clearLines.length * _level * 5;

      //up level possible when cleared
      int level = (_cleared ~/ 50) + _LEVEL_MIN;
      _level = level <= _LEVEL_MAX && level > _level ? level : _level;
    } else {
      _states = GameStates.mixing;
      mixSound?.call();
      _forTable((i, j) => _mask[i][j] = _current?.get(j, i) ?? _mask[i][j]);
      setState(() {});
      await Future.delayed(const Duration(milliseconds: 200));
      _forTable((i, j) => _mask[i][j] = 0);
      setState(() {});
    }

    _current = null;

    if (_data[0].contains(1)) {
      reset();
      return;
    } else {
      _startGame();
    }
  }

  ///遍历表格
  ///i 为 row
  ///j 为 column
  static void _forTable(dynamic Function(int row, int column) function) {
    for (int i = 0; i < GAME_PAD_MATRIX_H; i++) {
      for (int j = 0; j < GAME_PAD_MATRIX_W; j++) {
        final b = function(i, j);
        if (b is bool && b) {
          break;
        }
      }
    }
  }

  void _autoFall(bool enable) {
    if (!enable) {
      _autoFallTimer?.cancel();
      _autoFallTimer = null;
    } else if (enable) {
      _autoFallTimer?.cancel();
      _current = _current ?? _getNext();
      _autoFallTimer = Timer.periodic(_SPEED[_level - 1], (t) {
        down(enableSounds: false);
      });
    }
  }

  void pause() {
    if (_states == GameStates.running) {
      _states = GameStates.paused;
    }
    setState(() {});
  }

  void pauseOrResume() {
    if (_states == GameStates.running) {
      pause();
    } else if (_states == GameStates.paused || _states == GameStates.none) {
      _startGame();
    }
  }

  void reset() {
    if (_states == GameStates.none) {
      //可以开始游戏
      _startGame();
      return;
    }
    if (_states == GameStates.reset) {
      return;
    }
    // _sound.start();
    buttonAudioController.start();
    _states = GameStates.reset;
    () async {
      int line = GAME_PAD_MATRIX_H;
      await Future.doWhile(() async {
        line--;
        for (int i = 0; i < GAME_PAD_MATRIX_W; i++) {
          _data[line][i] = 1;
        }
        setState(() {});
        await Future.delayed(_REST_LINE_DURATION);
        return line != 0;
      });
      _current = null;
      _getNext();
      _points = 0;
      _cleared = 0;
      await Future.doWhile(() async {
        for (int i = 0; i < GAME_PAD_MATRIX_W; i++) {
          _data[line][i] = 0;
        }
        setState(() {});
        line++;
        await Future.delayed(_REST_LINE_DURATION);
        return line != GAME_PAD_MATRIX_H;
      });
      setState(() {
        _states = GameStates.none;
      });
    }();
  }

  void _startGame() {
    if (_states == GameStates.running && _autoFallTimer?.isActive == false) {
      return;
    }
    _states = GameStates.running;
    _autoFall(true);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List<List<int>> mixed = [];
    for (var i = 0; i < GAME_PAD_MATRIX_H; i++) {
      mixed.add(List.filled(GAME_PAD_MATRIX_W, 0));
      for (var j = 0; j < GAME_PAD_MATRIX_W; j++) {
        int value = _current?.get(j, i) ?? _data[i][j];
        if (_mask[i][j] == -1) {
          value = 0;
        } else if (_mask[i][j] == 1) {
          value = 2;
        }
        mixed[i][j] = value;
      }
    }
    debugPrint("game states : $_states");
    return GameState(
      mixed, _states, _level,
      false,
      // _sound.mute,
      _points, _cleared, _next,
      child: widget.child,
    );
  }

  void soundSwitch() {
    setState(() {
      // _sound.mute = !_sound.mute;
    });
  }
}

class GameState extends InheritedWidget {
  const GameState(
    this.data,
    this.states,
    this.level,
    this.muted,
    this.points,
    this.cleared,
    this.next, {
    Key? key,
    required this.child,
  }) : super(key: key, child: child);

  @override
  final Widget child;

  ///0: gạch trống
  ///1: gạch bình thường
  ///2: đánh dấu gạch
  final List<List<int>> data;

  final GameStates states;

  final int level;

  final bool muted;

  final int points;

  final int cleared;

  final Block next;

  static GameState of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<GameState>()!;
  }

  @override
  bool updateShouldNotify(GameState oldWidget) {
    return true;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Widget>('child', child));
  }
}
