import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:game_tetris/features/playboard/playboard.dart';
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
    final playboardDefaultColor = ref.watch(playboardInfoControllerProvider.select((value) => value.buttonColors));
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
                        child: IgnorePointer(
                          ignoring: isPreCloseColorPicker.value,
                          child: GameButton(
                            key: ValueKey('color-${color.index}'),
                            color: color,
                            onPressed: () {  },
                            child: Text(color.name[0].toUpperCase()),
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
            ],
          ),
        ),
      ),
    );
  }
}