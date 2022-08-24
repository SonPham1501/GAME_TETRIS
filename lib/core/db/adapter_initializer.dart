
import 'package:game_tetris/widgets/buttons/models/buttons_params.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AdapterInitializer {
  static void initialize() {
    /***
     * 1: Đối tượng "Hive"
     * 2: Adapter của đối tương "Hive"
     */
    // Hive.registerAdapter<1>(2);
    Hive.registerAdapter<ButtonColors>(ButtonColorsAdapter());
  }
}