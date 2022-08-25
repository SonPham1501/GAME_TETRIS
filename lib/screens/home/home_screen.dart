


import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:game_tetris/screens/home/controller/home_controller.dart';
import 'package:game_tetris/widgets/buttons/game_button.dart';
import 'package:game_tetris/widgets/buttons/models/buttons_params.dart';
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
          const SizedBox(height: 20),
          GameButton(
            color: ButtonColors.green,
            child: const Text('Increment'),
            onPressed: () {
              ref.read(counterProvider).increment();
            },
          ),
          const SizedBox(height: 20),
          GameButton(
            color: ButtonColors.blue,
            child: const Text('Refesh'),
            onPressed: () {
              ref.refresh(counterProvider);
            },
          ),
          const SizedBox(height: 20),
          GameButton(
            color: ButtonColors.red,
            child: const Text('Phạm Thế Sơn'),
            onPressed: () {log('ss');},
          ),
        ],
      ),
    );
  }
}