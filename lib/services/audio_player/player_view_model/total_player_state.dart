import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/models/song.dart';
part 'total_player_state.freezed.dart';

@freezed
class TotalPlayerState with _$TotalPlayerState {
  const factory TotalPlayerState({
    @Default([])List<Song> songs,
    @Default(null) Duration? currentPosition,
    @Default(false) bool isPlaying,
    @Default(false) bool isRepeat,
    @Default(false) bool isShuffle,
    @Default(false) bool isMute,
    int? playingSongIndex,
  }) = _TotalPlayerState;
}
