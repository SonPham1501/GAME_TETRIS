// ignore_for_file: constant_identifier_names

import 'package:game_tetris/material/audios/general_audio_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:just_audio/just_audio.dart';

final buttonAudioControllerProvider = Provider<ButtonAudioController>((ref) {
  return ButtonAudioController(ref.read);
});

const _SOUNDS = [
  'clean.mp3',
  'drop.mp3',
  'explosion.mp3',
  'move.mp3',
  'rotate.mp3',
  'start.mp3'
];

class ButtonAudioController {
  final Reader _read;

  ButtonAudioController(this._read) {
    for (var element in _SOUNDS) {
      final data = 'assets/audios/$element';
      _sound[element] = data;
    }
  }

  final _player = AudioPlayer();
  final _sound = <String, String>{};

  void _play(String name) async {
    if (_read(generalAudioControllerProvider).isMuted || _sound[name] == null) return;
    try {
      await _player.setAsset(_sound[name]!);
      _player.play();
    } catch(_) {}
  }

  void start() {
    _play('start.mp3');
  }

  void clear() {
    _play('clean.mp3');
  }

  void fall() {
    _play('drop.mp3');
  }

  void rotate() {
    _play('rotate.mp3');
  }

  void move() {
    _play('move.mp3');
  }

}