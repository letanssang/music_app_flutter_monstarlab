import 'package:audioplayers/audioplayers.dart';
import 'package:music_app/services/audio_player/audio_player_manager.dart';
import 'package:music_app/services/audio_player/player_view_model/total_player_state.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/song.dart';
final playerProvider = StateNotifierProvider<PlayerViewModel, TotalPlayerState>((ref) => PlayerViewModel(
  AudioPlayerSingleton().audioPlayer!
));
class PlayerViewModel extends StateNotifier<TotalPlayerState> {
  final AudioPlayer audioPlayer;
  PlayerViewModel(this.audioPlayer
      ) : super(
    const TotalPlayerState()
  );
  bool get isPlaying => state.isPlaying;
  Duration? get currentPosition => state.currentPosition;
  void updateCurrentPosition(Duration duration){
    state = state.copyWith(currentPosition: duration);
  }
  void onTapRepeat() {
    state = state.copyWith(isRepeat: !state.isRepeat);
  }
  void onTapShuffle(){
    state = state.copyWith(isShuffle: !state.isShuffle);
  }
  void onTapMute(){
    state = state.copyWith(isMute: !state.isMute);
    if(state.isMute){
      audioPlayer.setVolume(0);
    }else {
      audioPlayer.setVolume(1);
    }
  }
  void onTapFavorite() {
    final currentSong = state.songs[state.playingSongIndex!];
    final updatedSong = currentSong.copyWith(isFavorite: !currentSong.isFavorite);
    final updatedSongs = List<Song>.from(state.songs);
    updatedSongs[state.playingSongIndex!] = updatedSong;
    state = state.copyWith(songs: updatedSongs);
  }
  void play() async {
    state = state.copyWith(isPlaying: true);
    await audioPlayer.play(DeviceFileSource(state.songs[state.playingSongIndex!].data));
    moveToNextSong();
  }


  void moveToNextSong() {
    audioPlayer.onPlayerComplete.listen((event) async {
      if (state.isRepeat) {
        // If repeat mode is enabled, play the same song again
        play();
      } else {
        // Play the next song in the list
        skipNext();
      }
    });
  }
  void jumpToSong(int index) {
    state = state.copyWith(playingSongIndex: index);
    play();
  }
  void skipNext() {
    if (state.playingSongIndex == state.songs.length - 1) {
      state = state.copyWith(playingSongIndex: 0);
    } else {
      state = state.copyWith(playingSongIndex: state.playingSongIndex! + 1);
    }
    play();
  }

  void skipBackward() {
    if (state.playingSongIndex == 0) {
      state = state.copyWith(playingSongIndex: state.songs.length - 1);
    } else {
      state = state.copyWith(playingSongIndex: state.playingSongIndex! - 1);
    }
    play();
  }
  void resume() async {
    state = state.copyWith(isPlaying: true);
    await audioPlayer.resume();
  }

  void pause() async {
    state = state.copyWith(isPlaying: false);
    await audioPlayer.pause();
  }

  void stop() async {
    state = state.copyWith(isPlaying: false);
    await audioPlayer.stop();
  }
  Future<void> seek(Duration position) async {
    state = state.copyWith(currentPosition: position);
    await audioPlayer.seek(position);
  }

  Future<void> loadSongs() async {
    var status = await Permission.storage.status;
    if (status.isDenied) {
      await Permission.storage.request();
    }
    OnAudioQuery onAudioQuery = OnAudioQuery();
    List<SongModel> songsInfo = await onAudioQuery.querySongs();
    final listSong = songsInfo
        .where((song) => song.duration! >= 10000) // Lọc các bài hát có độ dài lớn hơn hoặc bằng 10 giây.
        .map(
          (song) => Song(
        id: song.id,
        data: song.data,
        title: song.title,
        artist: song.artist ?? 'Unknown',
        duration: Duration(milliseconds: song.duration ?? 0),
        path: song.uri,
        image: QueryArtworkWidget(
          id: song.id,
          type: ArtworkType.AUDIO,
        ),
      ),
    )
        .toList();
    state = state.copyWith(songs: listSong);
  }
}
