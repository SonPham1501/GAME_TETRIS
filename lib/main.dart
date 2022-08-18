import 'package:flutter/material.dart';
import 'package:game_tetris/app.dart';
import 'package:game_tetris/bootstraps.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  bootstraps(const App());
}
