import 'package:flutter/material.dart';
import '../models/game_item.dart';
import '../utils/constants.dart';

class GameObjectWidget extends StatefulWidget {
  final GameObject gameObject;
  final VoidCallback onTap;

  const GameObjectWidget({
    Key? key,
    required this.gameObject,
    required this.onTap,
  }) : super(key: key);

  @override
  State<GameObjectWidget> createState() => _GameObjectWidgetState();
}

class _GameObjectWidgetState extends State<GameObjectWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _floatController;
  late Animation<double> _floatAnimation;

  @override
  void initState() {
    super.initState();
    
    // Create floating animation
    _floatController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _floatAnimation = Tween<double>(
      begin: -8.0,
      end: 8.0,
    ).animate(CurvedAnimation(
      parent: _floatController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _floatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: GameConfig.animationDuration,
      curve: Curves.easeInOut,
      left: widget.gameObject.targetPosition.dx,
      top: widget.gameObject.targetPosition.dy,
      child: AnimatedBuilder(
        animation: _floatAnimation,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, _floatAnimation.value),
            child: Transform.rotate(
              angle: widget.gameObject.rotation,
              child: GestureDetector(
                onTap: widget.onTap,
                child: Container(
                  width: GameConfig.objectSize,
                  height: GameConfig.objectSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: widget.gameObject.isCorrect
                            ? AppColors.orange.withOpacity(0.6)
                            : widget.gameObject.isTrap
                                ? AppColors.red.withOpacity(0.4)
                                : AppColors.purple.withOpacity(0.3),
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      widget.gameObject.emoji,
                      style: TextStyle(
                        fontSize: widget.gameObject.isCorrect ? 50 : 45,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}