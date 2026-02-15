import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'tarot_game.dart';

class FlameSystemWidget extends StatelessWidget {
  FlameSystemWidget({super.key});

  final game = TarotGame();

  @override
  Widget build(BuildContext context) {
    return GameWidget(game: TarotGame());
  }
}
