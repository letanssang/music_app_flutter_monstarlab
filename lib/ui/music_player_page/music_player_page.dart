import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:music_app/services/audio_player_manager.dart';
import 'package:music_app/ui/blur_image_background.dart';
import 'package:music_app/ui/music_player_page/components/rotating_album_art.dart';

import '../../data/models/song.dart';
import 'view_model/music_player_view_model.dart';

class MusicPlayerPage extends ConsumerWidget {
  static const routeName = '/music-player';

  const MusicPlayerPage({Key? key}) : super(key: key);

  String formatDuration(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');

    return '$minutes:$seconds';
  }
  void showSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(onPressed: (){
              AudioPlayerSingleton().audioPlayer!.setVolume(0);
            }, icon: SvgPicture.asset(
              'assets/images/buttons/mute.svg',
              height: 30,
            )),
            IconButton(onPressed: null, icon: SvgPicture.asset(
              'assets/images/buttons/share.svg',
              height: 30,
            ))
          ],
        ),
        duration: const Duration(seconds: 5),
      ),
    );
  }
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Song song = ref
        .watch(musicPlayerViewModelProvider)
        .song;
    final viewModel = ref.read(musicPlayerViewModelProvider.notifier);
    AudioPlayerSingleton().audioPlayer!.onPositionChanged.listen((event) {
      ref
          .watch(currentPostionProvider.notifier)
          .state = event;
    });
    final currentPosition = ref.watch(currentPostionProvider) ?? Duration.zero;
    final state = ref.watch(musicPlayerViewModelProvider);
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
                          color: state.isFavorite ? const Color(0xFFFA00FF) : Colors
                              .white,
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
                        onPressed: (){
                          showSnackBar(context);
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
                margin: const EdgeInsets.only(left: 28,right: 28, bottom: 16),
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
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      onPressed: viewModel.onTapShuffle,
                      icon: state.isShuffle ?
                      SvgPicture.asset(
                        'assets/images/buttons/shuffle.svg',
                        height: 30,
                      ) :
                      SvgPicture.asset(
                        'assets/images/buttons/shuffle_off.svg',
                        height: 30,
                      )
                  ),
                  IconButton(
                      onPressed: viewModel.skipBackward,
                      icon: const Icon(
                        Icons.skip_previous_outlined,
                        color: Colors.white,
                        size: 40,
                      )
                  ),
                  IconButton(
                      onPressed: state.isPlaying
                          ? viewModel.pause
                          : viewModel.resume,
                      icon: state.isPlaying
                          ? SvgPicture.asset(
                        'assets/images/buttons/pause.svg',
                        height: 50,
                      )
                          : SvgPicture.asset(
                        'assets/images/buttons/play.svg',
                        height: 50,
                      )
                  ),
                  IconButton(
                      onPressed: viewModel.skipNext,
                      icon: const Icon(
                        Icons.skip_next_outlined,
                        color: Colors.white,
                        size: 40,
                      )
                  ),
                  IconButton(
                      onPressed: viewModel.onTapRepeat,
                      icon: ref.watch(isRepeatProvider) ?
                      SvgPicture.asset(
                        'assets/images/buttons/repeat.svg',
                        height: 30,
                      )
                          : SvgPicture.asset(
                        'assets/images/buttons/repeat_off.svg',
                        height: 30,
                      )
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
