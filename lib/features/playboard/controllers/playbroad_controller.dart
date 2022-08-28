

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_tetris/features/playboard/models/playboard_state/playboard_state.dart';

typedef PlayboardController<T extends PlayboardState > = StateNotifier<T>;

final playboardControllerProvider =
  StateNotifierProvider.autoDispose<PlayboardController, PlayboardState>(
    (_) => throw UnimplementedError('Need implement controller this before access in playboard.')
  );