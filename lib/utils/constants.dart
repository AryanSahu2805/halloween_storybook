import 'package:flutter/material.dart';

// App-wide color scheme
class AppColors {
  static const darkBackground = Color(0xFF0a0a0a);
  static const purple = Color(0xFF9D4EDD);
  static const orange = Color(0xFFFF6700);
  static const green = Color(0xFF00FF00);
  static const red = Color(0xFFFF0000);
}

// Text styles
class AppTextStyles {
  static const title = TextStyle(
    fontSize: 42,
    fontWeight: FontWeight.bold,
    color: AppColors.orange,
    shadows: [
      Shadow(
        blurRadius: 10,
        color: Colors.black,
        offset: Offset(2, 2),
      ),
    ],
  );

  static const body = TextStyle(
    fontSize: 18,
    color: Colors.white,
  );

  static const button = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
}

// Game settings
class GameConfig {
  static const int numberOfObjects = 7; // Total objects on screen
  static const int numberOfTraps = 4;   // How many are traps
  static const double objectSize = 80.0;
  static const Duration animationDuration = Duration(seconds: 3);
}
