// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'music_player_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$MusicPlayerState {
  Song get song => throw _privateConstructorUsedError;
  AudioPlayer get audioPlayer => throw _privateConstructorUsedError;
  Duration get currentPosition => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MusicPlayerStateCopyWith<MusicPlayerState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MusicPlayerStateCopyWith<$Res> {
  factory $MusicPlayerStateCopyWith(
          MusicPlayerState value, $Res Function(MusicPlayerState) then) =
      _$MusicPlayerStateCopyWithImpl<$Res, MusicPlayerState>;
  @useResult
  $Res call({Song song, AudioPlayer audioPlayer, Duration currentPosition});

  $SongCopyWith<$Res> get song;
}

/// @nodoc
class _$MusicPlayerStateCopyWithImpl<$Res, $Val extends MusicPlayerState>
    implements $MusicPlayerStateCopyWith<$Res> {
  _$MusicPlayerStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? song = null,
    Object? audioPlayer = null,
    Object? currentPosition = null,
  }) {
    return _then(_value.copyWith(
      song: null == song
          ? _value.song
          : song // ignore: cast_nullable_to_non_nullable
              as Song,
      audioPlayer: null == audioPlayer
          ? _value.audioPlayer
          : audioPlayer // ignore: cast_nullable_to_non_nullable
              as AudioPlayer,
      currentPosition: null == currentPosition
          ? _value.currentPosition
          : currentPosition // ignore: cast_nullable_to_non_nullable
              as Duration,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $SongCopyWith<$Res> get song {
    return $SongCopyWith<$Res>(_value.song, (value) {
      return _then(_value.copyWith(song: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_MusicPLayerStateCopyWith<$Res>
    implements $MusicPlayerStateCopyWith<$Res> {
  factory _$$_MusicPLayerStateCopyWith(
          _$_MusicPLayerState value, $Res Function(_$_MusicPLayerState) then) =
      __$$_MusicPLayerStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Song song, AudioPlayer audioPlayer, Duration currentPosition});

  @override
  $SongCopyWith<$Res> get song;
}

/// @nodoc
class __$$_MusicPLayerStateCopyWithImpl<$Res>
    extends _$MusicPlayerStateCopyWithImpl<$Res, _$_MusicPLayerState>
    implements _$$_MusicPLayerStateCopyWith<$Res> {
  __$$_MusicPLayerStateCopyWithImpl(
      _$_MusicPLayerState _value, $Res Function(_$_MusicPLayerState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? song = null,
    Object? audioPlayer = null,
    Object? currentPosition = null,
  }) {
    return _then(_$_MusicPLayerState(
      song: null == song
          ? _value.song
          : song // ignore: cast_nullable_to_non_nullable
              as Song,
      audioPlayer: null == audioPlayer
          ? _value.audioPlayer
          : audioPlayer // ignore: cast_nullable_to_non_nullable
              as AudioPlayer,
      currentPosition: null == currentPosition
          ? _value.currentPosition
          : currentPosition // ignore: cast_nullable_to_non_nullable
              as Duration,
    ));
  }
}

/// @nodoc

class _$_MusicPLayerState implements _MusicPLayerState {
  const _$_MusicPLayerState(
      {required this.song,
      required this.audioPlayer,
      required this.currentPosition});

  @override
  final Song song;
  @override
  final AudioPlayer audioPlayer;
  @override
  final Duration currentPosition;

  @override
  String toString() {
    return 'MusicPlayerState(song: $song, audioPlayer: $audioPlayer, currentPosition: $currentPosition)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MusicPLayerState &&
            (identical(other.song, song) || other.song == song) &&
            (identical(other.audioPlayer, audioPlayer) ||
                other.audioPlayer == audioPlayer) &&
            (identical(other.currentPosition, currentPosition) ||
                other.currentPosition == currentPosition));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, song, audioPlayer, currentPosition);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MusicPLayerStateCopyWith<_$_MusicPLayerState> get copyWith =>
      __$$_MusicPLayerStateCopyWithImpl<_$_MusicPLayerState>(this, _$identity);
}

abstract class _MusicPLayerState implements MusicPlayerState {
  const factory _MusicPLayerState(
      {required final Song song,
      required final AudioPlayer audioPlayer,
      required final Duration currentPosition}) = _$_MusicPLayerState;

  @override
  Song get song;
  @override
  AudioPlayer get audioPlayer;
  @override
  Duration get currentPosition;
  @override
  @JsonKey(ignore: true)
  _$$_MusicPLayerStateCopyWith<_$_MusicPLayerState> get copyWith =>
      throw _privateConstructorUsedError;
}
