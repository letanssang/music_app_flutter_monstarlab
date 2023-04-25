import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AudioPlayerSingleton {
  static AudioPlayerSingleton? _instance;
  AudioPlayer? audioPlayer;

  factory AudioPlayerSingleton() {
    _instance ??= AudioPlayerSingleton._internal();
    return _instance!;
  }

  AudioPlayerSingleton._internal() {
    audioPlayer = AudioPlayer();
  }
}
