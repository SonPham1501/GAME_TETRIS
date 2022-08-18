import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final counterProvider = ChangeNotifierProvider.autoDispose<CounterImpl>((ref) => CounterImpl());

abstract class Counter {
  void increment();
}

class CounterImpl extends Counter with ChangeNotifier {

  int _count = 0;
  int get count => _count;

  @override
  void increment() {
    _count++;
    notifyListeners();
  }
}