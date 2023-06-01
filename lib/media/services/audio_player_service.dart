import 'package:just_audio/just_audio.dart';

class AudioPlayerSingleton {
  static final AudioPlayerSingleton _instance =
      AudioPlayerSingleton._internal();
  final AudioPlayer _audioPlayer;

  factory AudioPlayerSingleton() {
    return _instance;
  }

  AudioPlayerSingleton._internal() : _audioPlayer = AudioPlayer();

  AudioPlayer get audioPlayer => _audioPlayer;
}
