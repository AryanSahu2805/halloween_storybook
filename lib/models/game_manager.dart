import 'dart:math';
import 'package:flutter/material.dart';
import 'game_item.dart';

class GameManager extends ChangeNotifier {
  final Random _r = Random();
  final List<GameObject> _objects = [];
  List<GameObject> get objects => List.unmodifiable(_objects);
  bool _hasWon = false;
  bool get hasWon => _hasWon;

  void generateLevel(Size s) {
    _objects.clear();
    _hasWon = false;
    List<Offset> pos = List.generate(
      5,
      (i) => Offset(
        _r.nextDouble() * (s.width - 100),
        100 + _r.nextDouble() * (s.height - 200),
      ),
    );
    _objects.add(GameObject(
      id: 'pumpkin',
      emoji: '🎃',
      isCorrect: true,
      isTrap: false,
      position: pos[0],
      targetPosition: Offset.zero,
    ));
    for (int i = 1; i < pos.length; i++) {
      _objects.add(GameObject(
        id: 'trap_$i',
        emoji: _trapEmoji(),
        isCorrect: false,
        isTrap: true,
        position: pos[i],
        targetPosition: Offset.zero,
        rotation: _rot(),
      ));
    }
    notifyListeners();
  }

  void move(String id, Offset p) {
    final i = _objects.indexWhere((o) => o.id == id);
    if (i == -1) return;
    _objects[i] = _objects[i].copyWith(position: p);
    notifyListeners();
  }

  void drop(GameObject o, Rect c) {
    final r = Rect.fromLTWH(o.position.dx, o.position.dy, 80, 80);
    if (r.overlaps(c)) {
      if (o.isCorrect) _hasWon = true;
      if (o.isTrap) _objects.remove(o);
      notifyListeners();
    }
  }

  void reset(Size s) => generateLevel(s);
  String _trapEmoji() {
    const t = ['💀', '🕷️', '👻', '🧟', '🧛‍♂️', '🕸️'];
    return t[_r.nextInt(t.length)];
  }

  double _rot() => _r.nextDouble() * 2 * pi - pi;
}
