import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_app/ui/blur_image_background.dart';
import 'package:music_app/ui/home_page/components/custom_appbar.dart';
import 'package:music_app/ui/home_page/components/song_page_view_item.dart';

import '../../data/models/song.dart';
import '../../services/songs_provider.dart';
import 'components/song_list_item.dart';


class HomePage extends ConsumerWidget {
  static const routeName = '/home';
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final songs = ref.watch(songsProvider) as List<Song>;
    final pageController = PageController(
      viewportFraction: 0.5,
      initialPage: 1,
    );
    void clickOnItem(Song song){
      ref.read(songPlayingProvider.notifier).state = song;
    }
    return Scaffold(
      body: BlurImageBackground(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(),
              Flexible(
                flex: 1,
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
                flex: 2,
                child: Container(
                  margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.02),
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: songs.length,
                    itemBuilder: (context, index) => SongListItem(index: index, song: songs[index],onPressed: clickOnItem,),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}