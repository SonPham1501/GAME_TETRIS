
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_tetris/features/online_mode/screens/online_mode_screen.dart';
import 'package:game_tetris/features/playboard/playboard.dart';
import 'package:game_tetris/material/app_setting/app_setting_controller.dart';
import 'package:game_tetris/utils/app_infos/app_infos.dart';
import 'package:game_tetris/widgets/buttons/buttons.dart';
import 'package:go_router/go_router.dart';

import 'features/home/screens/home_screen.dart';
import 'features/single_mode/screens/single_mode_screen.dart';

class App extends ConsumerStatefulWidget {
  const App({ Key? key }) : super(key: key);

  static final routers = GoRouter(
    initialLocation: '/',
    urlPathStrategy: UrlPathStrategy.hash,
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) {
          AppInfos.setAppTitle('Game Tetris - Home');
          return const HomeScreen();
        }
      ),
      GoRoute(
        path: '/s_mode',
        builder: (context, state) {
          AppInfos.setAppTitle('Game Tetris - Single Mode');
          return const SingleModeScreen();
        }
      ),
      GoRoute(
        path: '/o_mode',
        builder: (context, state) {
          AppInfos.setAppTitle('Game Tetris - Online Mode');
          return const OnlineModeScreen();
        }
      )
    ],
  );

  @override
  _AppState createState() => _AppState();
}

class _AppState extends ConsumerState<App> {

  @override
  Widget build(BuildContext context) {
    final playboardDefaultColor = ref.watch(playboardInfoControllerProvider.select((value) => value.buttonColors));
    final isDarkTheme = ref.watch(appSettingControllerProvider.select((value) => value.isDarkTheme));
    return MaterialApp.router(
      title: 'Game Tetris',
      routeInformationParser: App.routers.routeInformationParser,
      routerDelegate: App.routers.routerDelegate,
      debugShowCheckedModeBanner: false,
      theme: playboardDefaultColor.lightTheme,
      darkTheme: playboardDefaultColor.dartTheme,
      themeMode: isDarkTheme ? ThemeMode.dark : ThemeMode.light,
      onGenerateTitle: (context) => 'Game Tetris',
    );
  }
}