import 'package:flutter/material.dart';

import '../../../data/models/song.dart';

class SongListItem extends StatelessWidget {
  final int index;
  final Song song;
  final void Function(Song) onPressed;
  const SongListItem(
      {required this.index,
      required this.song,
      required this.onPressed,
      Key? key})
      : super(key: key);
  String formatDuration(int duration) {
    return "${(duration ~/ 60000).toString().padLeft(2, '0')}:${(duration ~/ 1000 % 60).toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPressed(song);
        Navigator.of(context).pushNamed('/music-player', arguments: song);
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
              color: Color.fromRGBO(255, 255, 255, 0.65),
              fontSize: 14,
            ),
          ),
          trailing: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.play_arrow_outlined,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
