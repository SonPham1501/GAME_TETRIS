import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final counterProvider = ChangeNotifierProvider.autoDispose((ref) => CounterImpl());

abstract class Counter {
  int get count;

  void increment();
}

class CounterImpl extends Counter with ChangeNotifier {

  int _count = 0;
  @override
  int get count => _count;

  @override
  void increment() {
    _count++;
    notifyListeners();
  }

}