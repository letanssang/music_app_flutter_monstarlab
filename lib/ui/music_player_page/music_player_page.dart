import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:music_app/services/audio_player_manager.dart';
import 'package:music_app/ui/blur_image_background.dart';

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


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Song song = ref.watch(musicPlayerViewModelProvider).song;
    final viewModel = ref.read(musicPlayerViewModelProvider.notifier);
    AudioPlayerSingleton().audioPlayer!.onPositionChanged.listen((event) {
      ref.watch(currentPostionProvider.notifier).state = event;
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
              Center(
                child: Container(
                  margin: const EdgeInsets.all(18),
                  height: MediaQuery.of(context).size.width * 0.7,
                  width: MediaQuery.of(context).size.width * 0.7,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: ClipOval(child: song.image),
                ),
              ),
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
                          color: state.isFavorite ? Color(0xFFFA00FF): Colors.white,
                          size: 25,
                        )),
                  ),
                  Container(
                    height: 40,
                    width: 40,
                    margin: const EdgeInsets.only(right: 16),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey,
                    ),
                    child: IconButton(
                        onPressed: null,
                        icon: Icon(Icons.more_horiz_rounded,
                            color: Colors.white, size: 25)),
                  ),
                ],
              ),
              Slider(
                value: currentPosition.inSeconds.toDouble(),
                min: 0,
                max: song.duration.inSeconds.toDouble() + 1,
                inactiveColor: Colors.white70,
                activeColor: Color(0xFF64D2FF),
                onChanged: (double value) {
                  viewModel.seek(Duration(seconds: value.toInt()));
                },
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 28),
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
                        fontWeight: FontWeight.bold,
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
                      ):
                      SvgPicture.asset(
                        'assets/images/buttons/shuffle_off.svg',
                        height: 30,
                      )
                      ),
                  IconButton(
                      onPressed: viewModel.skipBackward,
                      icon: Icon(
                        Icons.skip_previous_outlined,
                        color: Colors.white,
                        size: 40,
                      )
                      ),
                  IconButton(
                      onPressed: state.isPlaying
                          ? viewModel.pause
                          : viewModel.play,
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
                      onPressed: viewModel.skipForward,
                      icon: Icon(
                        Icons.skip_next_outlined,
                        color: Colors.white,
                        size: 40,
                      )
                      ),
                  IconButton(
                      onPressed: viewModel.onTapRepeat,
                      icon: state.isRepeat ?
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
