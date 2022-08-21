import 'package:game_tetris/core/db/db_core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final audioLocalProvider = Provider<AudioLocal>(((ref) => AudioLocalImpl()));

abstract class AudioLocal extends DBCore {
  bool get isMuted;
  set isMuted(bool value);
}

class AudioLocalImpl extends AudioLocal {
  @override
  bool get isMuted => box.get('isMute', defaultValue: false) ;

  @override
  set isMuted(bool value) => box.put('isMute', value);
}