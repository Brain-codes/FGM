import 'package:just_audio/just_audio.dart';

class AudioPlayerSingletonE {
  static AudioPlayer? _instance;

  static AudioPlayer get instance {
    if (_instance == null) {
      _instance = AudioPlayer();
    }
    return _instance!;
  }
}
