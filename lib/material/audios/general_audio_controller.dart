import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_tetris/material/audios/repositories/audio_local.dart';

final generalAudioControllerProvider = ChangeNotifierProvider<GeneralAudioController>((ref) {
  return GeneralAudioController(ref.read);
});

class GeneralAudioController extends ChangeNotifier {
  final Reader _read;

  GeneralAudioController(this._read) {
    _isMuted = _read(audioLocalProvider).isMuted;
  }

  bool _isMuted = false;
  bool get isMuted => _isMuted;
  set isMuted(bool value) {
    _isMuted = value;
    _read(audioLocalProvider).isMuted = value;
    notifyListeners();
  }
}