import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:music_app/services/audio_player/audio_player_manager.dart';
import 'package:music_app/services/audio_player/player_view_model/player_view_model.dart';
import 'package:music_app/ui/blur_image_background.dart';
import 'package:music_app/ui/music_player_page/components/rotating_album_art.dart';

import '../../data/models/song.dart';

class MusicPlayerPage extends ConsumerWidget {
  static const routeName = '/music-player';

  const MusicPlayerPage({Key? key}) : super(key: key);

  String formatDuration(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');

    return '$minutes:$seconds';
  }

  void showSnackBar(BuildContext context, WidgetRef ref) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                onPressed: ref.read(playerProvider.notifier).onTapMute,
                icon: SvgPicture.asset(
                  'assets/images/buttons/mute.svg',
                  height: 30,
                  )),
            IconButton(
                onPressed: null,
                icon: SvgPicture.asset(
                  'assets/images/buttons/share.svg',
                  height: 30,
                ))
          ],
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(playerProvider);
    final viewModel = ref.watch(playerProvider.notifier);
    final songs = state.songs;
    Song song = songs[state.playingSongIndex ?? 0];
    AudioPlayerSingleton().audioPlayer!.onPositionChanged.listen((event) {
      viewModel.updateCurrentPosition(event);
    });
    final currentPosition = state.currentPosition ?? Duration.zero;
    return Scaffold(
      body: BlurImageBackground(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 28, bottom: 16),
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text(
                  song.title,
                  style: const TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Nunito',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 28),
                child: Text(
                  song.artist,
                  style: const TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Nunito',
                  ),
                ),
              ),
              RotatingAlbumArt(image: song.image),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    margin: const EdgeInsets.only(right: 16),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey,
                    ),
                    child: IconButton(
                        onPressed: viewModel.onTapFavorite,
                        icon: Icon(
                          Icons.favorite_rounded,
                          color: song.isFavorite
                              ? const Color(0xFFFA00FF)
                              : Colors.white,
                          size: 25,
                        )),
                  ),
                  Container(
                    height: 40,
                    width: 40,
                    margin: const EdgeInsets.only(right: 16),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey,
                    ),
                    child: IconButton(
                        onPressed: () {
                          showSnackBar(context, ref);
                        },
                        icon: const Icon(Icons.more_horiz_rounded,
                            color: Colors.white, size: 25)),
                  ),
                ],
              ),
              Slider(
                value: currentPosition.inSeconds.toDouble(),
                min: 0,
                max: song.duration.inSeconds.toDouble() + 1,
                inactiveColor: Colors.white70,
                activeColor: const Color(0xFF64D2FF),
                thumbColor: Colors.white,
                onChanged: (double value) {
                  viewModel.seek(Duration(seconds: value.toInt()));
                },
              ),
              Container(
                margin: const EdgeInsets.only(left: 28, right: 28, bottom: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      formatDuration(currentPosition),
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 15,
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      formatDuration(song.duration),
                      style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 15,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      onPressed: viewModel.onTapShuffle,
                      icon: state.isShuffle
                          ? SvgPicture.asset(
                              'assets/images/buttons/shuffle.svg',
                              height: 30,
                            )
                          : SvgPicture.asset(
                              'assets/images/buttons/shuffle_off.svg',
                              height: 30,
                            )),
                  IconButton(
                      onPressed: viewModel.skipBackward,
                      icon: const Icon(
                        Icons.skip_previous_outlined,
                        color: Colors.white,
                        size: 40,
                      )),
                  IconButton(
                      onPressed:
                          state.isPlaying ? viewModel.pause : viewModel.resume,
                      icon: state.isPlaying
                          ? SvgPicture.asset(
                              'assets/images/buttons/pause.svg',
                              height: 50,
                            )
                          : SvgPicture.asset(
                              'assets/images/buttons/play.svg',
                              height: 50,
                            )),
                  IconButton(
                      onPressed: viewModel.skipNext,
                      icon: const Icon(
                        Icons.skip_next_outlined,
                        color: Colors.white,
                        size: 40,
                      )),
                  IconButton(
                      onPressed: viewModel.onTapRepeat,
                      icon: state.isRepeat
                          ? SvgPicture.asset(
                              'assets/images/buttons/repeat.svg',
                              height: 30,
                            )
                          : SvgPicture.asset(
                              'assets/images/buttons/repeat_off.svg',
                              height: 30,
                            )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
