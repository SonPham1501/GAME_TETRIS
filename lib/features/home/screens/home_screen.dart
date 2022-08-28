



import 'package:flutter/material.dart';
import 'package:game_tetris/widgets/buttons/game_button.dart';
import 'package:game_tetris/widgets/buttons/models/buttons_params.dart';
import 'package:game_tetris/widgets/theme_setting_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text.rich(
            TextSpan(
              text: 'Game ',
              children: [
                TextSpan(
                  text: 'Tetris',
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          const SizedBox(height: 32),
          GameButton(
            color: ButtonColors.green,
            child: const Text('Single Mode'),
            onPressed: () => context.go('/s_mode'),
          ),
          const SizedBox(height: 20),
          GameButton(
            color: ButtonColors.red,
            child: const Text('Online Mode'),
            onPressed: () => context.go('/o_mode'),
          ),
          const ThemeSettingBar(),
        ],
      ),
    );
  }
}