import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_tetris/features/playboard/repositories/playboard_local.dart';
import 'package:game_tetris/material/app_setting/app_setting_local.dart';
import 'package:game_tetris/material/audios/repositories/audio_local.dart';
import 'package:hive_flutter/hive_flutter.dart';

void bootstraps(Widget app) async {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  await Hive.initFlutter();

  PlayboardLocal playboardLocal = PlayboardLocalImpl();
  await playboardLocal.init();

  AppSettingLocal appSettingLocal = AppSettingLocalImpl();
  await appSettingLocal.init();

  AudioLocal audioLocal = AudioLocalImpl();
  await audioLocal.init();

  runApp(
    ProviderScope(
      overrides: [
        audioLocalProvider.overrideWithValue(audioLocal),
        appSettingLocalProvider.overrideWithValue(appSettingLocal),
        playboardProvider.overrideWithValue(playboardLocal),
      ],
      child: Portal(child: app),
    ),
  );
}