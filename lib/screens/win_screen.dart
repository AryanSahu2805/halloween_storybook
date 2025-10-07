import 'package:flutter/material.dart';
import '../utils/constants.dart';

class WinScreen extends StatefulWidget {
  const WinScreen({Key? key}) : super(key: key);

  @override
  State<WinScreen> createState() => _WinScreenState();
}

class _WinScreenState extends State<WinScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );

    _rotationAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
              AppColors.purple.withOpacity(0.4),
              AppColors.orange.withOpacity(0.2),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              
              // Animated pumpkin
              ScaleTransition(
                scale: _scaleAnimation,
                child: RotationTransition(
                  turns: _rotationAnimation,
                  child: Text('🎃', style: TextStyle(fontSize: 120)),
                ),
              ),
              
              const SizedBox(height: 30),
              
              // Victory message
              ScaleTransition(
                scale: _scaleAnimation,
                child: Column(
                  children: [
                    Text(
                      'YOU FOUND IT!',
                      style: AppTextStyles.title.copyWith(fontSize: 48),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '🎉 Victory! 🎉',
                      style: AppTextStyles.body.copyWith(
                        fontSize: 24,
                        color: AppColors.orange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 40),
              
              // Stats
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 40),
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.orange, width: 3),
                ),
                child: Column(
                  children: [
                    Text(
                      '🏆 Congratulations! 🏆',
                      style: AppTextStyles.body.copyWith(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppColors.orange,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      'You successfully found the Golden Pumpkin '
                      'and avoided all the spooky traps!\n\n'
                      'You\'re a Halloween champion!',
                      style: AppTextStyles.body.copyWith(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 15),
                    Text('👻 💀 🦇 🕷️ 🕸️', style: TextStyle(fontSize: 30)),
                  ],
                ),
              ),
              
              const Spacer(),
              
              // Buttons
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/game');
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
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.replay),
                        const SizedBox(width: 10),
                        Text('PLAY AGAIN', style: AppTextStyles.button),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/',
                        (route) => false,
                      );
                    },
                    child: Text(
                      'Back to Home',
                      style: AppTextStyles.body.copyWith(
                        color: AppColors.purple,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}