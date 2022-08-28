
import 'package:equatable/equatable.dart';

import '../playboard_config.dart';

abstract class PlayboardState extends Equatable {
  const PlayboardState({required this.config});

  final PlayboardConfig config;
}