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
          song: _ref.read(songPlayingProvider) ?? Song(
            id: 0,
            data: '',
            title: '',
            artist: '',
            duration: Duration.zero,
            path: '',
            image: Container(),
          ),
          audioPlayer: AudioPlayerSingleton().audioPlayer!,
          currentPosition: Duration.zero,
        ));
  void skipForward() {
    final songs = _ref.read(songsProvider) as List<Song>;
    final song = _ref.read(songPlayingProvider);
    if (song != null) {
      int index = songs.indexWhere((element) => element.id == song.id);
      if (index == songs.length - 1) {
        _ref.read(songPlayingProvider.notifier).state = songs[0];
        state = state.copyWith(song: songs[0], currentPosition: Duration.zero);
      } else {
        _ref.read(songPlayingProvider.notifier).state = songs[index + 1];
        state = state.copyWith(song: songs[index + 1], currentPosition: Duration.zero);
      }
      state.audioPlayer.setSourceUrl(state.song.data);
    }
  }

  void skipBack() {
    final songs = _ref.read(songsProvider) as List<Song>;
    final song = _ref.read(songPlayingProvider);
    if (song != null) {
      int index = songs.indexWhere((element) => element.id == song.id);
      if (index == 0) {
        _ref.read(songPlayingProvider.notifier).state = songs[songs.length - 1];
        state = state.copyWith(song: songs[songs.length-1], currentPosition: Duration.zero);
      } else {
        _ref.read(songPlayingProvider.notifier).state = songs[index - 1];
        state = state.copyWith(song: songs[index - 1], currentPosition: Duration.zero);
      }

      state.audioPlayer.setSourceUrl(state.song.data);
    }
  }

  void play() async {
    state.audioPlayer.setSourceUrl(state.song.data);
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

  void updatePosition(Duration event) {
    state = state.copyWith(currentPosition: event);
  }
  Future<void> seek(Duration position) async {
    await state.audioPlayer.seek(position);
  }
}
