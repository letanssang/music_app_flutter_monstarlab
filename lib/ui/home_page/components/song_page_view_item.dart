import 'package:flutter/material.dart';
import 'package:music_app/services/songs_provider.dart';

import '../../../data/models/song.dart';
class SongPageViewItem extends StatelessWidget {
  final PageController pageController;
  final int index;
  final Song song;
  final void Function(int) onPressed;
  SongPageViewItem({required this.pageController,required this.index,required this.song,required this.onPressed, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        onPressed(index);
        Navigator.of(context).pushNamed('/music-player');
      },
      onPanUpdate: (details) {
        if (details.delta.dx > 0) {
          pageController.previousPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        } else if (details.delta.dx < 0) {
          pageController.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      },
      child: AnimatedBuilder(
        animation: pageController,
        builder: (context, child) {
          double value = pageController.position.haveDimensions ? pageController.page! - index : 0;
          value = (1 - (value.abs() * 0.2)).clamp(0.0, 1.0);
          return Transform.scale(
            scale: value,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.width * 0.5,
                child: song.image,
              ),
            ),
          );
        },
      ),
    );
  }
}