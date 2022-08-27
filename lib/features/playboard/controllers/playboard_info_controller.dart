import 'package:flutter/material.dart';
import 'package:game_tetris/features/playboard/repositories/playboard_local.dart';
import 'package:game_tetris/widgets/buttons/buttons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final playboardInfoControllerProvider = ChangeNotifierProvider((ref) => PlayboardInfoController(ref.read));

class PlayboardInfoController extends ChangeNotifier {
  final Reader _read;
  PlayboardInfoController(this._read) {
    _buttonColors = _read(playboardLocalProvider).buttonColor;
    _boardSize = _read(playboardLocalProvider).boardSize;
  }

  ButtonColors _buttonColors = ButtonColors.red;
  ButtonColors get buttonColors => _buttonColors;
  set buttonColors(ButtonColors value) {
    _buttonColors = value;
    _read(playboardLocalProvider).buttonColor = value;
    notifyListeners();
  }

  int _boardSize = 3;
  int get boardSize => _boardSize;
  set boardSize(int value) {
    _boardSize = value;
    _read(playboardLocalProvider).boardSize = value;
    notifyListeners();
  }

}