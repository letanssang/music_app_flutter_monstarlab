import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_app/services/audio_player_manager.dart';
import 'package:music_app/ui/music_player_page/music_player_page.dart';

import 'services/songs_provider.dart';
import 'ui/home_page/home_page.dart';
import 'ui/welcome_page/welcome_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(songsProvider.notifier).loadSongs();
    AudioPlayerSingleton();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Poppins',
        primarySwatch: Colors.blue,
      ),
      home: const WelcomePage(),
      routes: {
        HomePage.routeName: (context) => const HomePage(),
        MusicPlayerPage.routeName: (context) => MusicPlayerPage(),
      },
    );
  }
}
