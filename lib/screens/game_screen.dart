import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../models/game_item.dart';
import '../utils/constants.dart';
import '../widgets/game_object.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> with TickerProviderStateMixin {
  List<GameObject> gameObjects = [];
  Timer? movementTimer;
  late AnimationController _shakeController;
  bool _isShaking = false;
  bool _isInitialized = false;
  final Random random = Random();

  @override
  void initState() {
    super.initState();
    
    _shakeController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      _initializeGame();
      _startMovement();
      _isInitialized = true;
    }
  }

  void _initializeGame() {
    // Create game objects
    List<String> emojis = ['👻', '🦇', '💀', '🕷️', '🕸️', '🧙'];
    
    for (int i = 0; i < GameConfig.numberOfObjects; i++) {
      bool isCorrect = (i == 0); // First object is the correct one
      bool isTrap = !isCorrect && i <= GameConfig.numberOfTraps;
      
      gameObjects.add(GameObject(
        id: 'object_$i',
        emoji: isCorrect ? '🎃' : emojis[i % emojis.length],
        isCorrect: isCorrect,
        isTrap: isTrap,
        position: _randomPosition(),
        targetPosition: _randomPosition(),
      ));
    }
    
    // Shuffle so correct one isn't always first visually
    gameObjects.shuffle();
  }

  Offset _randomPosition() {
    // Get screen size safely
    final size = MediaQuery.of(context).size;
    final safeWidth = size.width - 100;
    final safeHeight = size.height - 200;
    
    return Offset(
      50 + random.nextDouble() * safeWidth,
      100 + random.nextDouble() * safeHeight,
    );
  }

  void _startMovement() {
    movementTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (mounted) {
        setState(() {
          for (var obj in gameObjects) {
            obj.position = obj.targetPosition;
            obj.targetPosition = _randomPosition();
            obj.rotation = random.nextDouble() * 0.5 - 0.25;
          }
        });
      }
    });
  }

  void _handleObjectTap(GameObject obj) {
    if (obj.isCorrect) {
      // Player wins!
      movementTimer?.cancel();
      Navigator.pushReplacementNamed(context, '/win');
    } else if (obj.isTrap) {
      // Jump scare!
      setState(() {
        _isShaking = true;
      });
      _shakeController.forward().then((_) {
        _shakeController.reverse();
        setState(() {
          _isShaking = false;
        });
      });
      
      // Show scary message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '😱 BOO! That was a trap!',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 1),
        ),
      );
    }
  }

  @override
  void dispose() {
    movementTimer?.cancel();
    _shakeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _shakeController,
        builder: (context, child) {
          final offset = _isShaking 
              ? Offset(sin(_shakeController.value * pi * 4) * 10, 0)
              : Offset.zero;
          
          return Transform.translate(
            offset: offset,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.darkBackground,
                    Colors.black,
                    AppColors.purple.withOpacity(0.2),
                  ],
                ),
              ),
              child: SafeArea(
                child: Stack(
                  children: [
                    // Header
                    Positioned(
                      top: 10,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
                            onPressed: () => Navigator.pop(context),
                          ),
                          Text(
                            'Find the Golden Pumpkin!',
                            style: AppTextStyles.body.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 50),
                        ],
                      ),
                    ),
                    
                    // Game objects
                    ...gameObjects.map((obj) {
                      return GameObjectWidget(
                        gameObject: obj,
                        onTap: () => _handleObjectTap(obj),
                      );
                    }).toList(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}