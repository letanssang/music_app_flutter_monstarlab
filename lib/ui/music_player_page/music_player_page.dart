import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    Future.delayed(Duration.zero, () {
      ref.read(musicPlayerViewModelProvider.notifier).init();
    });
    Song song = ref.watch(musicPlayerViewModelProvider).song;
    final viewModel = ref.read(musicPlayerViewModelProvider.notifier);
    ref.watch(musicPlayerViewModelProvider).audioPlayer.onPositionChanged.listen((event) {
      viewModel.updatePosition(event);
    });
    Duration currentPosition = ref.watch(musicPlayerViewModelProvider).currentPosition;
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
                children: const [
                  IconButton(
                      onPressed: null,
                      icon: Icon(
                        Icons.favorite_rounded,
                        color: Colors.white,
                        size: 40,
                      )),
                  IconButton(
                      onPressed: null,
                      icon: Icon(Icons.more_horiz_rounded,
                          color: Colors.white, size: 40)),
                ],
              ),
              Slider(
                value: currentPosition.inSeconds.toDouble(),
                min: 0,
                max: song.duration.inSeconds.toDouble(),
                inactiveColor: Colors.white70,
                activeColor: Colors.white,
                onChanged: (double value) {
                  viewModel.seek(Duration(seconds: value.toInt()));
                },
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      formatDuration(currentPosition),
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      formatDuration(song.duration),
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const IconButton(
                      onPressed: null,
                      icon: Icon(
                        Icons.shuffle_rounded,
                        size: 30,
                        color: Colors.white,
                      )),
                  IconButton(
                      onPressed: viewModel.previous,
                      icon: const Icon(
                        Icons.skip_previous_outlined,
                        size: 40,
                        color: Colors.white,
                      )),
                  IconButton(
                      onPressed: viewModel.isPlaying()
                          ? viewModel.pause
                          : viewModel.play,
                      icon: viewModel.isPlaying()
                          ? const Icon(
                              Icons.pause_outlined,
                              size: 50,
                              color: Colors.white,
                            )
                          : const Icon(
                              Icons.play_arrow_outlined,
                              size: 50,
                              color: Colors.white,
                            )),
                  IconButton(
                      onPressed: viewModel.next,
                      icon: const Icon(
                        Icons.skip_next_outlined,
                        size: 40,
                        color: Colors.white,
                      )),
                  const IconButton(
                      onPressed: null,
                      icon: Icon(
                        Icons.repeat_rounded,
                        size: 30,
                        color: Colors.white,
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
