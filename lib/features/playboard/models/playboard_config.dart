import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:game_tetris/widgets/buttons/buttons.dart';
part 'playboard_config.freezed.dart';

@freezed
class PlayboardConfig with _$PlayboardConfig {
  const factory PlayboardConfig.none() = NonePlayboardConfig;
  const factory PlayboardConfig.blind(ButtonColors colors) = BlindPlayboardConfig;
}
