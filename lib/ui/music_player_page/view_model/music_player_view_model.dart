import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_app/services/songs_provider.dart';
import '../../../data/models/song.dart';
import '../../../services/audio_player_singleton.dart';
import 'music_player_state.dart';

final musicPlayerViewModelProvider =
    StateNotifierProvider.autoDispose<MusicPlayerViewModel, MusicPlayerState>(
  (ref) => MusicPlayerViewModel(ref),
);

class MusicPlayerViewModel extends StateNotifier<MusicPlayerState> {
  final Ref _ref;
  MusicPlayerViewModel(this._ref)
      : super(MusicPlayerState(
          song: const Song(
            id: 0,
            data: '',
            title: 'Unknown',
            artist: 'Unknown',
            duration: 0,
            path: '',
            image: SizedBox(),
          ),
          audioPlayer: AudioPlayerSingleton().audioPlayer!,
        ));

  void init() async {
    final song = _ref.read(songPlayingProvider);
    if (song != null) {
      state = state.copyWith(song: song);
      state.audioPlayer.setSourceUrl(song.data);
    }
  }

  void play() async {
    await state.audioPlayer.resume();
  }

  void pause() async {
    await state.audioPlayer.pause();
  }

  void stop() {
    state.audioPlayer.stop();
  }

  bool isPlaying() {
    return state.audioPlayer.state == PlayerState.playing;
  }

  Future<Duration?> getCurrentPosition() async {
    return await state.audioPlayer.getCurrentPosition();
  }
}
