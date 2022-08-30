
// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:game_tetris/widgets/buttons/game_button.dart';

import '../../../../widgets/gamer/gamer.dart';

const _COLOR_NORMAL = Colors.black87;

const _COLOR_NULL = Colors.transparent;

const _COLOR_HIGHLIGHT = Color(0xFF560000);

const _PLAYER_PANEL_PADDING = 6;

Size getBrikSizeForScreenWidth(double width) {
  return Size.square((width - _PLAYER_PANEL_PADDING) / GAME_PAD_MATRIX_W);
}

class BrikSize extends InheritedWidget {
  const BrikSize({
    Key? key,
    required this.size,
    required Widget child,
  }) : super(key: key, child: child);

  final Size size;

  static BrikSize of(BuildContext context) {
    final brikSize = context.dependOnInheritedWidgetOfExactType<BrikSize>();
    assert(brikSize != null, "....");
    return brikSize!;
  }

  @override
  bool updateShouldNotify(BrikSize old) {
    return old.size != size;
  }
}

///the basic brik for game panel
class Brik extends StatelessWidget {
  final Color color;

  const Brik._({Key? key, required this.color}) : super(key: key);

  const Brik.normal() : this._(color: _COLOR_NORMAL);

  const Brik.empty() : this._(color: _COLOR_NULL);

  const Brik.highlight() : this._(color: _COLOR_HIGHLIGHT);

  @override
  Widget build(BuildContext context) {
    final width = BrikSize.of(context).size.width;
    return SizedBox.fromSize(
      size: BrikSize.of(context).size,
      child: Padding(
        padding: EdgeInsets.all(0.05 * width),
        child: CustomPaint(
          painter: BorderGamePainter(
            color: color,
            brightness: Theme.of(context).brightness,
            edge: 5,
            thinkness: 2,
            elevation: 5,
          ),
          child: Container(
            decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ),
    );
  }
}
