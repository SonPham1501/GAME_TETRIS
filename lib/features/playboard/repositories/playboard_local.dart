import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_tetris/core/db.dart';
import 'package:game_tetris/widgets/buttons/buttons.dart';

final playboardLocalProvider = Provider<PlayboardLocal>((ref) => PlayboardLocalImpl());

abstract class PlayboardLocal extends DBCore {
  ButtonColors get buttonColor;
  set buttonColor(ButtonColors value);

  int get boardSize;
  set boardSize(int value);
}

class PlayboardLocalImpl extends PlayboardLocal {
  @override
  int get boardSize => box.get('boardSize', defaultValue: 3);

  @override
  set boardSize(int value) => box.put('boardSize', value);

  @override
  ButtonColors get buttonColor => box.get('buttonColor', defaultValue: ButtonColors.red);

  @override
  set buttonColor(ButtonColors value) => box.put('buttonColor', value);
}
