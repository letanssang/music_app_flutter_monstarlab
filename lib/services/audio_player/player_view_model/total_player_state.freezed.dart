// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'total_player_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TotalPlayerState {
  List<Song> get songs => throw _privateConstructorUsedError;
  Duration? get currentPosition => throw _privateConstructorUsedError;
  bool get isPlaying => throw _privateConstructorUsedError;
  bool get isRepeat => throw _privateConstructorUsedError;
  bool get isShuffle => throw _privateConstructorUsedError;
  bool get isMute => throw _privateConstructorUsedError;
  int? get playingSongIndex => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TotalPlayerStateCopyWith<TotalPlayerState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TotalPlayerStateCopyWith<$Res> {
  factory $TotalPlayerStateCopyWith(
          TotalPlayerState value, $Res Function(TotalPlayerState) then) =
      _$TotalPlayerStateCopyWithImpl<$Res, TotalPlayerState>;
  @useResult
  $Res call(
      {List<Song> songs,
      Duration? currentPosition,
      bool isPlaying,
      bool isRepeat,
      bool isShuffle,
      bool isMute,
      int? playingSongIndex});
}

/// @nodoc
class _$TotalPlayerStateCopyWithImpl<$Res, $Val extends TotalPlayerState>
    implements $TotalPlayerStateCopyWith<$Res> {
  _$TotalPlayerStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? songs = null,
    Object? currentPosition = freezed,
    Object? isPlaying = null,
    Object? isRepeat = null,
    Object? isShuffle = null,
    Object? isMute = null,
    Object? playingSongIndex = freezed,
  }) {
    return _then(_value.copyWith(
      songs: null == songs
          ? _value.songs
          : songs // ignore: cast_nullable_to_non_nullable
              as List<Song>,
      currentPosition: freezed == currentPosition
          ? _value.currentPosition
          : currentPosition // ignore: cast_nullable_to_non_nullable
              as Duration?,
      isPlaying: null == isPlaying
          ? _value.isPlaying
          : isPlaying // ignore: cast_nullable_to_non_nullable
              as bool,
      isRepeat: null == isRepeat
          ? _value.isRepeat
          : isRepeat // ignore: cast_nullable_to_non_nullable
              as bool,
      isShuffle: null == isShuffle
          ? _value.isShuffle
          : isShuffle // ignore: cast_nullable_to_non_nullable
              as bool,
      isMute: null == isMute
          ? _value.isMute
          : isMute // ignore: cast_nullable_to_non_nullable
              as bool,
      playingSongIndex: freezed == playingSongIndex
          ? _value.playingSongIndex
          : playingSongIndex // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TotalPlayerStateCopyWith<$Res>
    implements $TotalPlayerStateCopyWith<$Res> {
  factory _$$_TotalPlayerStateCopyWith(
          _$_TotalPlayerState value, $Res Function(_$_TotalPlayerState) then) =
      __$$_TotalPlayerStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Song> songs,
      Duration? currentPosition,
      bool isPlaying,
      bool isRepeat,
      bool isShuffle,
      bool isMute,
      int? playingSongIndex});
}

/// @nodoc
class __$$_TotalPlayerStateCopyWithImpl<$Res>
    extends _$TotalPlayerStateCopyWithImpl<$Res, _$_TotalPlayerState>
    implements _$$_TotalPlayerStateCopyWith<$Res> {
  __$$_TotalPlayerStateCopyWithImpl(
      _$_TotalPlayerState _value, $Res Function(_$_TotalPlayerState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? songs = null,
    Object? currentPosition = freezed,
    Object? isPlaying = null,
    Object? isRepeat = null,
    Object? isShuffle = null,
    Object? isMute = null,
    Object? playingSongIndex = freezed,
  }) {
    return _then(_$_TotalPlayerState(
      songs: null == songs
          ? _value._songs
          : songs // ignore: cast_nullable_to_non_nullable
              as List<Song>,
      currentPosition: freezed == currentPosition
          ? _value.currentPosition
          : currentPosition // ignore: cast_nullable_to_non_nullable
              as Duration?,
      isPlaying: null == isPlaying
          ? _value.isPlaying
          : isPlaying // ignore: cast_nullable_to_non_nullable
              as bool,
      isRepeat: null == isRepeat
          ? _value.isRepeat
          : isRepeat // ignore: cast_nullable_to_non_nullable
              as bool,
      isShuffle: null == isShuffle
          ? _value.isShuffle
          : isShuffle // ignore: cast_nullable_to_non_nullable
              as bool,
      isMute: null == isMute
          ? _value.isMute
          : isMute // ignore: cast_nullable_to_non_nullable
              as bool,
      playingSongIndex: freezed == playingSongIndex
          ? _value.playingSongIndex
          : playingSongIndex // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$_TotalPlayerState implements _TotalPlayerState {
  const _$_TotalPlayerState(
      {final List<Song> songs = const [],
      this.currentPosition = null,
      this.isPlaying = false,
      this.isRepeat = false,
      this.isShuffle = false,
      this.isMute = false,
      this.playingSongIndex})
      : _songs = songs;

  final List<Song> _songs;
  @override
  @JsonKey()
  List<Song> get songs {
    if (_songs is EqualUnmodifiableListView) return _songs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_songs);
  }

  @override
  @JsonKey()
  final Duration? currentPosition;
  @override
  @JsonKey()
  final bool isPlaying;
  @override
  @JsonKey()
  final bool isRepeat;
  @override
  @JsonKey()
  final bool isShuffle;
  @override
  @JsonKey()
  final bool isMute;
  @override
  final int? playingSongIndex;

  @override
  String toString() {
    return 'TotalPlayerState(songs: $songs, currentPosition: $currentPosition, isPlaying: $isPlaying, isRepeat: $isRepeat, isShuffle: $isShuffle, isMute: $isMute, playingSongIndex: $playingSongIndex)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TotalPlayerState &&
            const DeepCollectionEquality().equals(other._songs, _songs) &&
            (identical(other.currentPosition, currentPosition) ||
                other.currentPosition == currentPosition) &&
            (identical(other.isPlaying, isPlaying) ||
                other.isPlaying == isPlaying) &&
            (identical(other.isRepeat, isRepeat) ||
                other.isRepeat == isRepeat) &&
            (identical(other.isShuffle, isShuffle) ||
                other.isShuffle == isShuffle) &&
            (identical(other.isMute, isMute) || other.isMute == isMute) &&
            (identical(other.playingSongIndex, playingSongIndex) ||
                other.playingSongIndex == playingSongIndex));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_songs),
      currentPosition,
      isPlaying,
      isRepeat,
      isShuffle,
      isMute,
      playingSongIndex);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TotalPlayerStateCopyWith<_$_TotalPlayerState> get copyWith =>
      __$$_TotalPlayerStateCopyWithImpl<_$_TotalPlayerState>(this, _$identity);
}

abstract class _TotalPlayerState implements TotalPlayerState {
  const factory _TotalPlayerState(
      {final List<Song> songs,
      final Duration? currentPosition,
      final bool isPlaying,
      final bool isRepeat,
      final bool isShuffle,
      final bool isMute,
      final int? playingSongIndex}) = _$_TotalPlayerState;

  @override
  List<Song> get songs;
  @override
  Duration? get currentPosition;
  @override
  bool get isPlaying;
  @override
  bool get isRepeat;
  @override
  bool get isShuffle;
  @override
  bool get isMute;
  @override
  int? get playingSongIndex;
  @override
  @JsonKey(ignore: true)
  _$$_TotalPlayerStateCopyWith<_$_TotalPlayerState> get copyWith =>
      throw _privateConstructorUsedError;
}
