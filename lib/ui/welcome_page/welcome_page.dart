import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../blur_image_background.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlurImageBackground(
      child: Container(
        padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: MediaQuery.of(context).size.height * 0.09,
            bottom: MediaQuery.of(context).size.height * 0.07),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome',
              style: TextStyle(
                  color: Color(0xFFBCBCBC),
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
              ),
            ),
            const Text(
              'Find the variety of music you want to hear!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Center(
                child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.45,
              child: SvgPicture.asset(
                'assets/images/poster_app.svg',
                fit: BoxFit.fitHeight,
              ),
            )),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/home');
              },
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.height * 0.07,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(255, 255, 255, 0.63),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Center(
                    child: Text(
                      'Let\'s go',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
