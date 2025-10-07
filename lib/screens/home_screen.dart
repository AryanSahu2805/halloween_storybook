import 'package:flutter/material.dart';
import '../utils/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    // Fade in animation
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() {
          _opacity = 1.0;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.darkBackground,
              AppColors.purple.withOpacity(0.3),
            ],
          ),
        ),
        child: SafeArea(
          child: AnimatedOpacity(
            opacity: _opacity,
            duration: const Duration(seconds: 1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                
                // Title
                Text('🎃', style: TextStyle(fontSize: 100)),
                const SizedBox(height: 20),
                
                Text(
                  'Spooky',
                  style: AppTextStyles.title,
                ),
                Text(
                  'Halloween Game',
                  style: AppTextStyles.title.copyWith(
                    fontSize: 36,
                    color: AppColors.purple,
                  ),
                ),
                
                const SizedBox(height: 40),
                
                // Instructions
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: AppColors.orange, width: 2),
                  ),
                  child: Column(
                    children: [
                      Text(
                        '👻 How to Play 👻',
                        style: AppTextStyles.body.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.orange,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        'Find the GOLDEN PUMPKIN 🎃 among the spooky objects!\n\n'
                        '⚠️ Watch out for TRAPS!\n'
                        'Some objects will try to scare you!\n\n'
                        'Tap the correct pumpkin to WIN!',
                        style: AppTextStyles.body.copyWith(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                
                const Spacer(),
                
                // Start button
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/game');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.orange,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 18,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text('START GAME', style: AppTextStyles.button),
                ),
                
                const SizedBox(height: 60),
              ],
            ),
          ),
        ),
      ),
    );
  }
}