import 'dart:ui';

import 'package:flutter/material.dart';

class BlurImageBackground extends StatelessWidget {
  Widget child;
  BlurImageBackground({required this.child, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const AssetImage('assets/images/bgr.png'),
          fit: BoxFit.cover,
          colorFilter:
              ColorFilter.mode(Colors.grey.withOpacity(0.5), BlendMode.darken),
        ),
      ),
      child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100), child: child),
    );
  }
}
