import 'dart:async';

import 'package:flutter/material.dart';

import '../../material/bricks/briks.dart';
import '../../widgets/gamer/block.dart';
import '../../widgets/gamer/gamer.dart';

class StatusPanel extends StatelessWidget {
  const StatusPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('Points',style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          // Number(number: GameState.of(context).points),
          const SizedBox(height: 10),
          const Text('Cleans', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          // Number(number: GameState.of(context).cleared),
          const SizedBox(height: 10),
          const Text('Level', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          // Number(number: GameState.of(context).level),
          const SizedBox(height: 10),
          const Text('Next', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          _NextBlock(),
          const Spacer(),
          _GameStatus(),
        ],
      ),
    );
  }
}

class _NextBlock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<List<int>> data = [List.filled(4, 0), List.filled(4, 0)];
    final next = BLOCK_SHAPES[GameState.of(context).next.type]!;
    for (int i = 0; i < next.length; i++) {
      for (int j = 0; j < next[i].length; j++) {
        data[i][j] = next[i][j];
      }
    }
    return Row(
      children: data.map((list) {
        return Column(
          children: list.map((b) {
            return b == 1 ? const Brik.normal() : const Brik.empty();
          }).toList(),
        );
      }).toList(),
    );
  }
}

class _GameStatus extends StatefulWidget {
  @override
  _GameStatusState createState() {
    return _GameStatusState();
  }
}

class _GameStatusState extends State<_GameStatus> {
  Timer? _timer;

  bool _colonEnable = true;

  int _minute = 0;

  int _hour = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final now = DateTime.now();
      setState(() {
        _colonEnable = !_colonEnable;
        _minute = now.minute;
        _hour = now.hour;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const <Widget>[
        Expanded(child: Text('Cần thêm'))
        // IconSound(enable: GameState.of(context).muted),
        // const SizedBox(width: 4),
        // IconPause(enable: GameState.of(context).states == GameStates.paused),
        // const Spacer(),
        // Number(number: _hour, length: 2, padWithZero: true),
        // IconColon(enable: _colonEnable),
        // Number(number: _minute, length: 2, padWithZero: true),
      ],
    );
  }
}
