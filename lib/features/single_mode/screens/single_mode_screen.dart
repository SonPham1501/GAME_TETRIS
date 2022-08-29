import 'package:flutter/material.dart';
import 'package:game_tetris/features/panel/controller.dart';
import 'package:game_tetris/features/panel/screen.dart';
import 'package:game_tetris/widgets/gamer/gamer.dart';
import 'package:go_router/go_router.dart';

class SingleModeScreen extends StatelessWidget {
  const SingleModeScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenW = size.width;
    return WillPopScope(
      onWillPop: () async {
        context.go('/');
        return false;
      },
      child: Game(
        child: Scaffold(
          body: Column(
            children: [
              Screen(width: screenW),
              const GameController(),
            ],
          ),
        ),
      ),
    );
  }
}