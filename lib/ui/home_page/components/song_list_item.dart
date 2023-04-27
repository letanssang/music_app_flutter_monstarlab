import 'package:flutter/material.dart';

import '../../../data/models/song.dart';

class SongListItem extends StatelessWidget {
  final int index;
  final Song song;
  final void Function(int) onPressed;
  final bool isPlaying;
  const SongListItem(
      {required this.index,
      required this.song,
      required this.onPressed,
      required this.isPlaying,
      Key? key})
      : super(key: key);
  String formatDuration(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');

    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPressed(index);
        Navigator.of(context).pushNamed('/music-player');
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 25,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color.fromRGBO(109, 109, 109, 1),
              Color.fromRGBO(109, 109, 109, 1),
            ],
          ),
        ),
        child: ListTile(
          leading: ClipOval(
            child: song.image,
          ),
          title: Text(
            song.title,
            maxLines: 2,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          subtitle: Text(
            formatDuration(song.duration),
            style: const TextStyle(
              color: Color(0xFF009DE0),
              fontSize: 14,
            ),
          ),
          trailing: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.play_arrow_outlined,
              color: isPlaying ? Color(0xFFFA00FF) :Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
