import 'package:flutter/material.dart';

// Model for each game object
class GameObject {
  final String id;
  final String emoji;
  final bool isCorrect;  // Is this the winning object?
  final bool isTrap;     // Is this a trap?
  Offset position;
  Offset targetPosition;
  double rotation;

  GameObject({
    required this.id,
    required this.emoji,
    required this.isCorrect,
    required this.isTrap,
    required this.position,
    required this.targetPosition,
    this.rotation = 0.0,
  });

  // Create a copy with updated values
  GameObject copyWith({
    Offset? position,
    Offset? targetPosition,
    double? rotation,
  }) {
    return GameObject(
      id: id,
      emoji: emoji,
      isCorrect: isCorrect,
      isTrap: isTrap,
      position: position ?? this.position,
      targetPosition: targetPosition ?? this.targetPosition,
      rotation: rotation ?? this.rotation,
    );
  }
}