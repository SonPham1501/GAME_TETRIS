

import 'package:flutter/material.dart';
import 'package:game_tetris/screens/home/controller/home_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(counterProvider.select((value) => value.count));
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text(count.toString())),
          TextButton(onPressed: () async {
            ref.read(counterProvider).increment();
          }, child: const Text('Click')),
          TextButton(onPressed: () {
            ref.refresh(counterProvider);
          }, child: const Text('Refresh')),
        ],
      ),
    );
  }
}