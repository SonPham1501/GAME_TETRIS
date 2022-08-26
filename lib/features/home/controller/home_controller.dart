import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_tetris/material/audios/button_audio_controller.dart';

final counterProvider = ChangeNotifierProvider.autoDispose<CounterImpl>((ref) => CounterImpl(ref.read));

abstract class Counter {
  void increment();
}

class CounterImpl extends Counter with ChangeNotifier {

  final Reader _read;

  CounterImpl(this._read);

  int _count = 0;
  int get count => _count;

  @override
  void increment() {
    _count++;
    _read(buttonAudioControllerProvider).move();
    notifyListeners();
  }
}