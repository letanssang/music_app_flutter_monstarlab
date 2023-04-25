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
          isFavorite: _ref.read(songPlayingProvider)?.isFavorite ?? false,
        ));
  void skipForward() {
    final songs = _ref.read(songsProvider) as List<Song>;
    final song = _ref.read(songPlayingProvider);
    if (song != null) {
      int index = songs.indexWhere((element) => element.id == song.id);
      if (index == songs.length - 1) {
        _ref.read(songPlayingProvider.notifier).state = songs[0];
        state = state.copyWith(song: songs[0], currentPosition: Duration.zero, isFavorite: songs[0].isFavorite);
      } else {
        _ref.read(songPlayingProvider.notifier).state = songs[index + 1];
        state = state.copyWith(song: songs[index + 1], currentPosition: Duration.zero, isFavorite: songs[index + 1].isFavorite);
      }
      play();
    }
  }

  void skipBack() {
    final songs = _ref.read(songsProvider) as List<Song>;
    final song = _ref.read(songPlayingProvider);
    if (song != null) {
      int index = songs.indexWhere((element) => element.id == song.id);
      if (index == 0) {
        _ref.read(songPlayingProvider.notifier).state = songs[songs.length - 1];
        state = state.copyWith(song: songs[songs.length-1], currentPosition: Duration.zero, isFavorite: songs[songs.length-1].isFavorite);
      } else {
        _ref.read(songPlayingProvider.notifier).state = songs[index - 1];
        state = state.copyWith(song: songs[index - 1], currentPosition: Duration.zero, isFavorite: songs[index - 1].isFavorite);
      }
      play();
    }
  }

  void play() async {
    state.audioPlayer.setSourceUrl(state.song.data);
    state = state.copyWith(isPlaying: true);
    await state.audioPlayer.resume();
  }

  void pause() async {
    state = state.copyWith(isPlaying: false);
    await state.audioPlayer.pause();
  }

  void stop() {
    state = state.copyWith(isPlaying: false);
    state.audioPlayer.stop();
  }

  void updatePosition(Duration event) {
      state = state.copyWith(currentPosition: event);
  }
  void onTapShuffle() {
    state = state.copyWith(isShuffle: !state.isShuffle);
  }
  void onTapRepeat() {
    state = state.copyWith(isRepeat: !state.isRepeat);
  }
  void onTapFavorite(){
    state = state.copyWith(isFavorite: !state.isFavorite);
    final songs = _ref.read(songsProvider) as List<Song>;
    final song = _ref.read(songPlayingProvider);
    if(song != null){
      int index = songs.indexWhere((element) => element.id == song.id);
      songs[index] = songs[index].copyWith(isFavorite: state.isFavorite);
    }
  }
  Future<void> seek(Duration position) async {
    if(position > state.song.duration){
      position = state.song.duration;
    }
    await state.audioPlayer.seek(position);
  }
}
