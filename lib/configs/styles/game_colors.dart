
import 'package:flutter/material.dart';


class GameColor {
  static const dart = GameColorPack(
    blueBg: Color(0xFF12181A),
    greenBg: Color(0xFF151914),
    yellowBg: Color(0xFF1B1911),
    redBg: Color(0xFF1A1512),
  );

  static const light = GameColorPack(
    blueBg: Color(0xFFF6FBFE),
    yellowBg: Color(0xFFFFFDF5),
    greenBg: Color(0xFFF9FDF8),
    redBg: Color(0xFFFEF9F6),
  );
}

class GameColorPack {
  const GameColorPack({
    required this.blueBg,
    required this.redBg,
    required this.yellowBg,
    required this.greenBg,
  });

  final Color redBg, yellowBg, greenBg, blueBg;
}