import 'package:game_tetris/core/db/db_core.dart';



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