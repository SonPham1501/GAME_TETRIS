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
          const Text('Points',style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF25ADE6))),
          const SizedBox(height: 4),
          Number(number: GameState.of(context).points),
          const SizedBox(height: 20),
          const Text('Cleans', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF75CF4E))),
          const SizedBox(height: 4),
          Number(number: GameState.of(context).cleared),
          const SizedBox(height: 20),
          const Text('Level', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFFFCD06))),
          const SizedBox(height: 4),
          Number(number: GameState.of(context).level),
          const SizedBox(height: 20),
          const Text('Next', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFED701E))),
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
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Number(number: _hour, length: 2, padWithZero: true),
        Text(
          ':',
          style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 16),
        ),
        Number(number: _minute, length: 2, padWithZero: true),
      ],
    );
  }
}

class Number extends StatelessWidget {
  final int length;

  ///the number to show
  ///could be null
  final int number;

  final bool padWithZero;

  const Number({
    Key? key,
    this.length = 5,
    required this.number,
    this.padWithZero = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String digitalStr = number.toString();
    if (digitalStr.length > length) {
      digitalStr = digitalStr.substring(digitalStr.length - length);
    }
    digitalStr = digitalStr.padLeft(length, padWithZero ? "0" : " ");
    List<Widget> children = [];
    for (int i = 0; i < length; i++) {
      children.add(Digital(int.tryParse(digitalStr[i]) ?? 0));
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }
}

/// a single digital
class Digital extends StatelessWidget {
  ///number 0 - 9
  ///or null indicate it is invalid
  final int digital;

  final Size size;

  const Digital(this.digital, {Key? key, this.size = const Size(10, 17)})
      : assert((digital <= 9 && digital >= 0)),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      digital.toString(),
      style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 16),
    );
  }

}
