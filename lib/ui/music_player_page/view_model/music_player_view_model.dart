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
            duration: Duration.zero,
            path: '',
            image: SizedBox(),
          ),
          audioPlayer: AudioPlayerSingleton().audioPlayer!,
          currentPosition: Duration.zero,
        ));

  void init() async {
    final song = _ref.read(songPlayingProvider);
    if (song != null) {
      state = state.copyWith(song: song);
      state.audioPlayer.setSourceUrl(song.data);
    }
  }

  void next() {
    final songs = _ref.read(songsProvider) as List<Song>;
    final song = _ref.read(songPlayingProvider);
    if (song != null) {
      int index = songs.indexWhere((element) => element.id == song.id);
      if (index == songs.length - 1) {
        _ref.read(songPlayingProvider.notifier).state = songs[0];
      } else {
        _ref.read(songPlayingProvider.notifier).state = songs[index + 1];
      }
      state = state.copyWith(song: songs[index + 1], currentPosition: Duration.zero);
    }
  }

  void previous() {
    final songs = _ref.read(songsProvider) as List<Song>;
    final song = _ref.read(songPlayingProvider);
    if (song != null) {
      int index = songs.indexWhere((element) => element.id == song.id);
      if (index == 0) {
        _ref.read(songPlayingProvider.notifier).state = songs[songs.length - 1];
      } else {
        _ref.read(songPlayingProvider.notifier).state = songs[index - 1];
      }
      state = state.copyWith(song: songs[index + 1], currentPosition: Duration.zero);
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

  void updatePosition(Duration event) {
    state = state.copyWith(currentPosition: event);
  }
  Future<void> seek(Duration position) async {
    await state.audioPlayer.seek(position);
  }
}
