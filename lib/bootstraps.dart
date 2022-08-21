import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_tetris/material/audios/repositories/audio_local.dart';
import 'package:hive_flutter/hive_flutter.dart';

void bootstraps(Widget app) async {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  await Hive.initFlutter();

  AudioLocal audioLocal = AudioLocalImpl();
  await audioLocal.init();

  runApp(
    ProviderScope(
      overrides: const [
        // audioLocalProvider.overrideWithValue(audioLocal),
      ],
      child: Portal(child: app),
    ),
  );
}