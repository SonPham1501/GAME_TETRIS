import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:game_tetris/features/playboard/playboard.dart';
import 'package:game_tetris/material/app_setting/app_setting_controller.dart';
import 'package:game_tetris/material/audios/general_audio_controller.dart';
import 'package:game_tetris/widgets/buttons/buttons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ThemeSettingBar extends HookConsumerWidget {
  const ThemeSettingBar({ Key? key }) : super(key: key);

  double delayedProgress(int lenght, double animationValue, int i) {
    return ((animationValue * lenght.toDouble()) - (i / lenght))
      .clamp(0, 1)
      .toDouble();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playboardInfoController = ref.watch(playboardInfoControllerProvider.notifier);
    final playboardDefaultColor = ref.watch(playboardInfoControllerProvider.select((value) => value.buttonColors));
    final appSettingController = ref.watch(appSettingControllerProvider.notifier);
    final isDark = ref.watch(appSettingControllerProvider.select((value) => value.isDarkTheme));
    final audioController = ref.watch(generalAudioControllerProvider.notifier);
    final isMute = ref.watch(generalAudioControllerProvider.select((value) => value.isMuted));
    final isColorPickerExpand = useState(false);
    final isPreCloseColorPicker = useState(false);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Center(
        child: SizedBox(
          width: 190,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PortalEntry(
                visible: isColorPickerExpand.value,
                childAnchor: Alignment.bottomRight,
                portalAnchor: Alignment.bottomLeft,
                portal: Column(
                  key: const ValueKey('color-picker'),
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ...ButtonColors.values.map((color) {
                      return TweenAnimationBuilder<double>(
                        tween: Tween<double> (
                          begin: 0,
                          end: isPreCloseColorPicker.value ? 0 : 1,
                        ),
                        duration: Duration(
                          milliseconds: 200 + 200 * (isPreCloseColorPicker.value == false
                            ? ButtonColors.values.length - color.index - 1
                            : color.index)
                        ),
                        curve: Curves.decelerate,
                        builder: (context, value, child) {
                          return Opacity(
                            opacity: delayedProgress(
                              ButtonColors.values.length,
                              value,
                              ButtonColors.values.length - color.index,
                            ),
                            child: child!,
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.only(
                            bottom: color.index == ButtonColors.values.length -1
                              ? 0
                              : 8,
                            left: (190 - 49 * 3) / 2,
                          ),
                          child: IgnorePointer(
                            ignoring: isPreCloseColorPicker.value,
                            child: GameButton(
                              key: ValueKey('color-${color.index}'),
                              color: color,
                              size: ButtonSize.square,
                              onPressed: () => playboardInfoController.buttonColors = color,
                              child: Text(color.name[0].toUpperCase()),
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
                child: GameButton(
                  color: playboardDefaultColor,
                  size: ButtonSize.square,
                  onPressed: () {
                    if (isPreCloseColorPicker.value == true) return;
                    if (isColorPickerExpand.value == false) {
                      isColorPickerExpand.value = true;
                    } else {
                      isPreCloseColorPicker.value = true;
                      Future.delayed(
                        Duration(milliseconds: 200 * ButtonColors.values.length),
                        () {
                          isPreCloseColorPicker.value = false;
                          isColorPickerExpand.value = false;
                        },
                      );
                    }
                  },
                  child: isColorPickerExpand.value == false
                    ? const Icon(Icons.arrow_circle_up_outlined)
                    : const Icon(Icons.arrow_circle_down_outlined),
                ),
              ),
              SizedBox(
                width: 49,
                height: 49,
                child: IconButton(
                  onPressed: () => appSettingController.isDarkTheme = !isDark,
                  icon: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 3000),
                    transitionBuilder: (child, animation) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                    child: isDark
                      ? const Icon(Icons.light_mode)
                      : const Icon(Icons.dark_mode),
                  ),
                ),
              ),
              GameButton(
                color: playboardDefaultColor,
                size: ButtonSize.square,
                child: isMute
                  ? const Icon(Icons.music_off)
                  : const Icon(Icons.music_note),
                onPressed: () => audioController.isMuted = !isMute,
              ),
            ],
          ),
        ),
      ),
    );
  }
}