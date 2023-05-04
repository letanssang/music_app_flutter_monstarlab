import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../../../services/audio_player_manager.dart';

class RotatingAlbumArt extends StatefulWidget {
  final Widget image;
  const RotatingAlbumArt({required this.image, Key? key}) : super(key: key);
  @override
  State<RotatingAlbumArt> createState() => _RotatingAlbumArtState();
}

class _RotatingAlbumArtState extends State<RotatingAlbumArt> with TickerProviderStateMixin{
  late final AnimationController _controller;
  bool _isDispose = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 20))..forward()..addListener(() {
      if(_controller.isCompleted) {
        _controller.repeat();
      }
    });
    AudioPlayerSingleton().audioPlayer!.onPlayerStateChanged.listen((event) {
      if(!_isDispose){
        setState(() {
          if(AudioPlayerSingleton().audioPlayer!.state != PlayerState.playing){
            _controller.stop();
          }else {
            _controller.forward();
          }
        });
      }
    });
  }
  @override
  void dispose() {
    _controller.dispose();
    _isDispose = true;
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, child) {
          return Transform.rotate(
            angle: _controller.value * 2 * math.pi,
            child: child,
          );
        },
        child: Container(
          margin: const EdgeInsets.all(18),
          height: MediaQuery
              .of(context)
              .size
              .width * 0.7,
          width: MediaQuery
              .of(context)
              .size
              .width * 0.7,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: ClipOval(child: widget.image),
        ),
      ),
    );
  }
}
