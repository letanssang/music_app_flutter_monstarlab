import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'song.freezed.dart';

@freezed
class Song with _$Song {
  const factory Song({
    required int id,
    required String data,
    required String title,
    required String artist,
    required Widget image,
    required String? path,
    required int duration,
  }) = _Song;
}