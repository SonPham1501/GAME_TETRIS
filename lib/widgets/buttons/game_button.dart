
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:game_tetris/widgets/buttons/models/buttons_params.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

enum GameButtonState { hover, idle, pressed }
enum GameButtonStyle { invert, normal }

class GameButton extends HookConsumerWidget {
  const GameButton({
    Key? key,
    required this.color,
    required this.child,
    required this.onPressed,
    this.size = ButtonSize.large,
    this.customSize,
    this.scale = 1,
    this.fontSize = 14,
    this.style = GameButtonStyle.normal,
  }) : super(key: key);

  final ButtonColors color;
  final ButtonSize size;
  final GameButtonStyle style;
  final double fontSize;
  final VoidCallback onPressed;
  final Widget child;
  final double scale;
  final Size? customSize;

  Color? _surfaceColor(ButtonColors color, double value) {
    return Color.lerp(
      Color.lerp(Colors.white, color.primaryColor, 0.02),
      color.primaryColor,
      style == GameButtonStyle.invert ? 1 - value : value,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final buttonState = useState(GameButtonState.idle);

    return MouseRegion(
      cursor: MouseCursor.defer,
      onEnter: (_) => buttonState.value = GameButtonState.hover,
      onExit:  (_) => buttonState.value = GameButtonState.idle,
      child: GestureDetector(
        onTapDown: (_) => buttonState.value = GameButtonState.hover,
        onTapCancel: () => buttonState.value = GameButtonState.idle,
        onTapUp: (_) => buttonState.value = GameButtonState.idle,
        onTap: onPressed,
        child: TweenAnimationBuilder<double>(
          tween: Tween(
            begin: 0,
            end: buttonState.value == GameButtonState.hover ? 1 : 0,
          ),
          duration: const Duration(milliseconds: 300),
          builder: (context, value, child) {
            final _brightness = Theme.of(context).brightness;
            final _color = Color.lerp(
              color.primaryColor,
              Theme.of(context).colorScheme.background,
              style == GameButtonStyle.invert ? 1 - value : value,
            )!;
            final _borderColor = Color.lerp(
              Color.lerp(
                _color,
                _brightness == Brightness.light ? Colors.black : Colors.white,
                0.3,
              ),
              color.primaryColor,
              style == GameButtonStyle.invert ? 1 - value : value,
            )!;

            return CustomPaint(
              painter: BorderGamePainter(
                color: _color,
                borderColor: _borderColor,
                brightness: _brightness,
                edge: 5,
                thinkness: 2 + value * 1,
                elevation: 5 + value * 5
              ),
              child: IconTheme(
                data: IconThemeData(
                  color: _surfaceColor(color, value),
                ),
                child: DefaultTextStyle(
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    fontSize: fontSize * scale,
                    color: _surfaceColor(color, value),
                  ),
                  child: child!,
                ),
              ),
            );
          },
          child: SizedBox(
            height: customSize != null ? customSize!.height : 49 * scale,
            width: customSize != null
              ? customSize!.width
              : size == ButtonSize.square
                ? 49 * scale
                : 190,
            child: Center(child: child),
          ),
        ),
      ),
    );
  }
}

class BorderGamePainter extends CustomPainter {
  const BorderGamePainter({
    required this.color,
    this.borderColor,
    required this.brightness,
    required this.edge,
    required this.thinkness,
    this.elevation = 4,
  });

  final Color color;
  final Color? borderColor;
  final double thinkness;
  final double edge;
  final Brightness brightness;
  final double elevation;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    final path = Path()
      ..moveTo(edge, 0)
      ..lineTo(size.width - edge, 0)
      ..lineTo(size.width, edge)
      ..lineTo(size.width, size.height - edge)
      ..lineTo(size.width - edge, size.height)
      ..lineTo(edge, size.height)
      ..lineTo(0, size.height - edge)
      ..lineTo(0, edge)
      ..close();
    canvas.drawShadow(
      path,
      borderColor ?? Color.lerp(
        color,
        brightness == Brightness.light ? Colors.black : Colors.white,
        0.3,
      )!,
      elevation,
      true,
    );
    canvas.drawPath(path, paint);
    final borderPaint = Paint()
      ..color = borderColor ?? Color.lerp(
        color,
        brightness == Brightness.light ? Colors.black : Colors.white,
        0.3,
      )!
      ..strokeWidth = thinkness
      ..style = PaintingStyle.stroke;
    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;

}