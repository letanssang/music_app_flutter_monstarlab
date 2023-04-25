import 'package:audioplayers/audioplayers.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/models/song.dart';
part 'music_player_state.freezed.dart';

@freezed
class MusicPlayerState with _$MusicPlayerState {
  const factory MusicPlayerState({
    required Song song,
    required AudioPlayer audioPlayer,
    required Duration currentPosition,
  }) = _MusicPLayerState;
}
