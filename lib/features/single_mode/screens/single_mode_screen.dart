import 'package:flutter/material.dart';
import 'package:game_tetris/features/panel/controller.dart';
import 'package:game_tetris/features/panel/screen.dart';
import 'package:game_tetris/widgets/gamer/gamer.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SingleModeScreen extends ConsumerWidget {
  const SingleModeScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final screenW = size.width;
    return WillPopScope(
      onWillPop: () async {
        context.go('/');
        return false;
      },
      child: Game(
        ref: ref,
        child: Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Screen(width: screenW),
                  const Expanded(child: GameController()),
                  SizedBox(height: MediaQuery.of(context).size.height * .07),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}