import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  CustomAppBar({Key? key}) : super(key: key);
  final dateTimeNow = DateTime.now();
  String _greeting() {
    if (dateTimeNow.hour < 12) {
      return 'Good Morning';
    } else if (dateTimeNow.hour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
          child: const CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage('assets/images/avatar.jpg'),
          ),
        ),
        Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(_greeting(), style: const TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.65),
                fontSize: 16,
              ),),
              const Text('Sang', style: TextStyle(
                color: Colors.white,
                fontSize: 22,
              ),),
            ]
        ),
        const Spacer(),
        const IconButton(onPressed: null, icon: Icon(Icons.search, color: Colors.white, size: 25,)),
        const IconButton(onPressed: null, icon: Icon(Icons.notifications_outlined, color: Colors.white, size: 25,))
      ],
    );
  }
}
