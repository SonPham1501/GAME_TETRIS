

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_tetris/material/app_setting/app_setting_local.dart';

final appSettingControllerProvider = ChangeNotifierProvider((ref) => AppSettingController(ref.read));

class AppSettingController extends ChangeNotifier {
  final Reader _read;

  AppSettingController(this._read) {
    _isDarkTheme = _read(appSettingLocalProvider).isDarkTheme;
  }

  bool _isDarkTheme = false;
  bool get isDarkTheme => _isDarkTheme;
  set isDarkTheme(bool value) {
    _isDarkTheme = value;
    _read(appSettingLocalProvider).isDarkTheme = value;
    notifyListeners();
  }

  bool _reduceMotion = false;
  bool get reduceMotion => _reduceMotion;
  set reduceMotion(bool value) {
    _reduceMotion = value;
    _read(appSettingLocalProvider).reduceMotion = value;
    notifyListeners();
  }

}