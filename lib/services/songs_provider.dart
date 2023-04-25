import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../data/models/song.dart';
import 'package:permission_handler/permission_handler.dart';

final songsProvider = StateNotifierProvider((ref) => SongStateNotifier());
final songPlayingProvider = StateProvider<Song?>((ref) => null);

class SongStateNotifier extends StateNotifier<List<Song>> {
  Song? songPlaying;
  SongStateNotifier() : super([]);
  void setSongPlaying(Song song) {
    songPlaying = song;
  }
  Future<void> loadSongs() async {
    var status = await Permission.storage.status;
    if (status.isDenied) {
      await Permission.storage.request();
    }
    OnAudioQuery onAudioQuery = OnAudioQuery();
    List<SongModel> songsInfo = await onAudioQuery.querySongs();
    state = songsInfo
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
  }

}