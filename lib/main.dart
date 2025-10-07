import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'screens/home_screen.dart';
import 'screens/game_screen.dart';
import 'screens/win_screen.dart';
import 'utils/constants.dart';

void main() {
  runApp(const HalloweenGameApp());
}

class HalloweenGameApp extends StatefulWidget {
  const HalloweenGameApp({Key? key}) : super(key: key);

  @override
  State<HalloweenGameApp> createState() => _HalloweenGameAppState();
}

class _HalloweenGameAppState extends State<HalloweenGameApp> {
  late final AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _initMusic();
  }

  Future<void> _initMusic() async {
    _audioPlayer = AudioPlayer();
    // Set looping and volume
    await _audioPlayer.setReleaseMode(ReleaseMode.loop);
    await _audioPlayer.setVolume(0.3);

    // Play the spooky music from assets
    await _audioPlayer.play(AssetSource('sounds/spookymusic.mp3'));
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spooky Halloween Game',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.orange,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.darkBackground,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/game': (context) => const GameScreen(),
        '/win': (context) => const WinScreen(),
      },
    );
  }
}
