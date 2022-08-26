import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_tetris/features/playboard/playboard.dart';
import 'package:game_tetris/material/app_setting/app_setting_controller.dart';
import 'package:game_tetris/widgets/buttons/buttons.dart';

import 'features/home/home_screen.dart';

class App extends ConsumerStatefulWidget {
  const App({ Key? key }) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends ConsumerState<App> {

  @override
  Widget build(BuildContext context) {
    final playboardDefaultColor = ref.watch(playboardInfoControllerProvider.select((value) => value.buttonColors));
    final isDarkTheme = ref.watch(appSettingControllerProvider.select((value) => value.isDarkTheme));
    return MaterialApp(
      title: 'Game Tetris',
      debugShowCheckedModeBanner: false,
      theme: playboardDefaultColor.lightTheme,
      darkTheme: playboardDefaultColor.dartTheme,
      themeMode: isDarkTheme ? ThemeMode.dark : ThemeMode.light,
      home: const HomeScreen(),
    );
  }
}