import 'package:flutter/material.dart';
import 'package:game_tetris/app.dart';
import 'package:game_tetris/bootstraps.dart';
import 'package:game_tetris/screens/home/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  bootstraps(const App());
}
