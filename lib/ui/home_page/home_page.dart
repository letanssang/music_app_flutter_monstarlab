import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_app/services/audio_player_manager.dart';
import 'package:music_app/ui/blur_image_background.dart';
import 'package:music_app/ui/home_page/components/custom_appbar.dart';
import 'package:music_app/ui/home_page/components/song_page_view_item.dart';

import '../../data/models/song.dart';
import '../../services/songs_provider.dart';
import 'components/song_list_item.dart';


class HomePage extends ConsumerWidget {
  static const routeName = '/home';
  const HomePage({super.key});

  String formatDuration(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');

    return '$minutes:$seconds';
  }
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final songs = ref.watch(songsProvider) as List<Song>;
    final songPlayingIndex = ref.watch(songPlayingIndexProvider);
    final currentPosition = ref.watch(currentPostionProvider) ?? Duration.zero;
    final pageController = PageController(
      viewportFraction: 0.5,
      initialPage: 1,
    );
    void clickOnItem(int index){
      if(ref.read(songPlayingIndexProvider.notifier).state == index){
        return;
      }
      ref.watch(songPlayingIndexProvider.notifier).state = index;
      ref.read(currentPostionProvider.notifier).state = null;
      AudioPlayerSingleton().audioPlayer!.stop();
    }
    return Scaffold(
      body: BlurImageBackground(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(),
              Flexible(
                flex: 3,
                child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: PageView.builder(
                      controller: pageController,
                      itemCount: songs.length,
                      itemBuilder: (context, index) {
                        return SongPageViewItem(pageController: pageController, index: index, song: songs[index],onPressed: clickOnItem);
                      },
                    )
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text('Your Music', style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),),
              ),
              Flexible(
                flex: 6,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: songs.length,
                    itemBuilder: (context, index) => SongListItem(index: index, song: songs[index],onPressed: clickOnItem, isPlaying: songPlayingIndex == index,),
                  ),
                ),
              ),
              if(songPlayingIndex != null) Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.075,
                  color: Color(0xFF5985C7),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 8.0, right: 30.0),
                        child: ClipOval(
                          child: songs[songPlayingIndex].image,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(songs[songPlayingIndex].title, maxLines: 1, style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),),
                            Text(songs[songPlayingIndex].artist, maxLines: 1, style: TextStyle(
                              color: Colors.white,
                            ),),
                            Text(
                              formatDuration(currentPosition),
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: null,
                        icon: Icon(Icons.skip_previous, color: Colors.white,),
                      ),
                      IconButton(
                        onPressed: null,
                        icon: Icon(Icons.pause, color: Colors.white,),
                      ),
                      IconButton(
                        onPressed: null,
                        icon: Icon(Icons.skip_next, color: Colors.white,),
                      ),
                    ],
                  )
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}