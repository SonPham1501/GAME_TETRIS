// ignore_for_file: constant_identifier_names

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:game_tetris/widgets/buttons/buttons.dart';

import '../../widgets/gamer/gamer.dart';

class GameController extends StatelessWidget {
  const GameController({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Row(
        children: const <Widget>[
          Expanded(child: LeftController()),
          Expanded(child: DirectionController()),
        ],
      ),
    );
  }
}

const Size _DIRECTION_BUTTON_SIZE = Size(48, 48);

const Size _SYSTEM_BUTTON_SIZE = Size(28, 28);

const double _DIRECTION_SPACE = 16;


class DirectionController extends StatelessWidget {
  const DirectionController({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        SizedBox.fromSize(size: _DIRECTION_BUTTON_SIZE * 2.8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            GameButton(
              color: ButtonColors.green,
              size: ButtonSize.square,
              child: const Icon(Icons.arrow_circle_left_outlined),
              onPressed: () => Game.of(context).left(),
            ),
            const SizedBox(width: _DIRECTION_SPACE),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GameButton(
                  color: ButtonColors.blue,
                  size: ButtonSize.square,
                  child: const Icon(Icons.arrow_circle_up_outlined),
                  onPressed: () => Game.of(context).rotate(),
                ),
                const SizedBox(height: _DIRECTION_SPACE),
                GameButton(
                  color: ButtonColors.yellow,
                  size: ButtonSize.square,
                  child: const Icon(Icons.arrow_circle_down_outlined),
                  onPressed: () => Game.of(context).down(),
                ),
              ],
            ),
            const SizedBox(width: _DIRECTION_SPACE),
            GameButton(
              color: ButtonColors.red,
              size: ButtonSize.square,
              child: const Icon(Icons.arrow_circle_right_outlined),
              onPressed: () => Game.of(context).right(),
            ),
          ],
        ),
      ],
    );
  }
}

class SystemButtonGroup extends StatelessWidget {
  static const _systemButtonColor = Color(0xFF2dc421);

  const SystemButtonGroup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _Description(
          text: 'Sounds',
          child: _Button(
              size: _SYSTEM_BUTTON_SIZE,
              color: _systemButtonColor,
              enableLongPress: false,
              onTap: () {
                Game.of(context).soundSwitch();
              }),
        ),
        _Description(
          text: 'Pause/Resume',
          child: _Button(
              size: _SYSTEM_BUTTON_SIZE,
              color: _systemButtonColor,
              enableLongPress: false,
              onTap: () {
                Game.of(context).pauseOrResume();
              }),
        ),
        _Description(
          text: 'Seset',
          child: _Button(
              size: _SYSTEM_BUTTON_SIZE,
              enableLongPress: false,
              color: Colors.red,
              onTap: () {
                Game.of(context).reset();
              }),
        )
      ],
    );
  }
}
class LeftController extends StatelessWidget {
  const LeftController({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const SystemButtonGroup(),
        const SizedBox(height: 20),
        Expanded(
          child: Center(
            child: GameButton(
              color: ButtonColors.red,
              size: ButtonSize.square,
              child: const Text('D'),
              onPressed: () => Game.of(context).drop(),
            ),
          ),
        )
      ],
    );
  }
}

class _Button extends StatefulWidget {
  final Size size;
  final Widget? icon;

  final VoidCallback onTap;

  ///the color of button
  final Color color;

  final bool enableLongPress;

  const _Button({
    Key? key,
    required this.size,
    required this.onTap,
    this.icon,
    this.color = Colors.blue,
    this.enableLongPress = true,
  }) : super(key: key);

  @override
  _ButtonState createState() {
    return _ButtonState();
  }
}

///show a hint text for child widget
class _Description extends StatelessWidget {
  final String text;

  final Widget child;

  final AxisDirection direction;

  const _Description({
    Key? key,
    required this.text,
    this.direction = AxisDirection.down,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget widget;
    switch (direction) {
      case AxisDirection.right:
        widget = Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[child, const SizedBox(width: 8), Text(text)]);
        break;
      case AxisDirection.left:
        widget = Row(
          children: <Widget>[Text(text), const SizedBox(width: 8), child],
          mainAxisSize: MainAxisSize.min,
        );
        break;
      case AxisDirection.up:
        widget = Column(
          children: <Widget>[Text(text), const SizedBox(height: 8), child],
          mainAxisSize: MainAxisSize.min,
        );
        break;
      case AxisDirection.down:
        widget = Column(
          children: <Widget>[child, const SizedBox(height: 8), Text(text)],
          mainAxisSize: MainAxisSize.min,
        );
        break;
    }
    return DefaultTextStyle(
      child: widget,
      style: const TextStyle(fontSize: 12, color: Colors.black),
    );
  }
}

class _ButtonState extends State<_Button> {
  Timer? _timer;

  bool _tapEnded = false;

  late Color _color;

  @override
  void didUpdateWidget(_Button oldWidget) {
    super.didUpdateWidget(oldWidget);
    _color = widget.color;
  }

  @override
  void initState() {
    super.initState();
    _color = widget.color;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: _color,
      elevation: 2,
      shape: const CircleBorder(),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: (_) async {
          setState(() {
            _color = widget.color.withOpacity(0.5);
          });
          if (_timer != null) {
            return;
          }
          _tapEnded = false;
          widget.onTap();
          if (!widget.enableLongPress) {
            return;
          }
          await Future.delayed(const Duration(milliseconds: 300));
          if (_tapEnded) {
            return;
          }
          _timer = Timer.periodic(const Duration(milliseconds: 60), (t) {
            if (!_tapEnded) {
              widget.onTap();
            } else {
              t.cancel();
              _timer = null;
            }
          });
        },
        onTapCancel: () {
          _tapEnded = true;
          _timer?.cancel();
          _timer = null;
          setState(() {
            _color = widget.color;
          });
        },
        onTapUp: (_) {
          _tapEnded = true;
          _timer?.cancel();
          _timer = null;
          setState(() {
            _color = widget.color;
          });
        },
        child: SizedBox.fromSize(
          size: widget.size,
        ),
      ),
    );
  }
}
