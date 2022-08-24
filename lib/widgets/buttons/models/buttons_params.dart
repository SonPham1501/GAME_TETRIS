import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:game_tetris/configs/styles/game_colors.dart';
import 'package:game_tetris/core/db.dart';
import 'package:hive_flutter/adapters.dart';

part 'buttons_params.g.dart';

@HiveType(typeId: DbIdNumbering.colorColorId)
enum ButtonColors {
  @HiveField(0)
  blue,
  @HiveField(1)
  green,
  @HiveField(2)
  red,
  @HiveField(3)
  yellow,
}

enum ButtonSize { large, square }

extension BackgroundColor on ButtonColors {
  Color backgroundColor(BuildContext context) {
    switch (this) {
      case ButtonColors.blue:
        return Theme.of(context).brightness == Brightness.dark
          ? GameColor.dart.blueBg
          : GameColor.light.blueBg;
      case ButtonColors.red:
        return Theme.of(context).brightness == Brightness.dark
          ? GameColor.dart.redBg
          : GameColor.light.redBg;
      case ButtonColors.yellow:
        return Theme.of(context).brightness == Brightness.dark
          ? GameColor.dart.yellowBg
          : GameColor.light.yellowBg;
      case ButtonColors.green:
        return Theme.of(context).brightness == Brightness.dark
          ? GameColor.dart.greenBg
          : GameColor.light.greenBg;
      default:
        throw Exception('ButtonColor is not found');
    }
  }
}

extension ColorSchemeExt on ButtonColors {
  Color get primaryColor {
    switch (this) {
      case ButtonColors.blue:
        return const Color(0xFF25ADE6);
      case ButtonColors.green:
       return const Color(0xFF75CF4E);
      case ButtonColors.yellow:
      return const Color(0xFFFFCD06);
      case ButtonColors.red:
        return const Color(0xFFED701E);
      default:
        throw Exception('ButtonColors is not found');
    }
  }
}

extension ThemeBaseOnColor on ButtonColors {
  ThemeData adaptiveColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark ? dartTheme : lightTheme;
  }

  ThemeData get lightTheme => FlexColorScheme.light(
    fontFamily: 'kenvector_future',
    primary: primaryColor,
    blendLevel: 20,
    surfaceMode: FlexSurfaceMode.highSurfaceLowScaffold,
    onPrimary: Colors.white,
  ).toTheme;

  ThemeData get dartTheme => FlexColorScheme.dark(
    fontFamily: 'kenvector_future',
    primary: primaryColor,
    blendLevel: 20,
    surfaceMode: FlexSurfaceMode.highSurfaceLowScaffold,
    onPrimary: Colors.white,
  ).toTheme;

}