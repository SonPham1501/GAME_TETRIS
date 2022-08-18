import 'package:hive/hive.dart';

class DBCore<T> {
  late final Box<T> box;

  Future<void> init() async {
    box = await Hive.openBox(runtimeType.toString());
  }
}