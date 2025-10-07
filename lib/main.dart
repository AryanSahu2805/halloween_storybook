import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/game_screen.dart';
import 'screens/win_screen.dart';
import 'utils/constants.dart';

void main() {
  runApp(const HalloweenGameApp());
}

class HalloweenGameApp extends StatelessWidget {
  const HalloweenGameApp({Key? key}) : super(key: key);

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
      // Named routes for navigation
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/game': (context) => const GameScreen(),
        '/win': (context) => const WinScreen(),
      },
    );
  }
}