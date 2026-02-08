import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:tarot_again/util/util.dart';

import 'tarot_position.dart';

class TarotGame extends FlameGame with Logging {
  static const double cardWidth = 1000.0;
  static const double cardHeight = 1932.0;
  static double cardGap =
      175.0; // will change based on the layout, specifically
  // the number of cards in the layout and their positioning.
  static const double cardRadius = 100.0;
  static final Vector2 cardSize = Vector2(cardWidth, cardHeight);

  @override
  Future<void> onLoad() async {
    debug("TarotGame.onLoad()");
    final oneCard = TarotPosition()
      ..size = cardSize
      ..position = Vector2(cardGap, cardGap);

    world.add(oneCard);

    final gameWidth = 2 * cardGap + cardWidth;
    final gameHeight = 2 * cardGap + cardHeight;

    camera.viewfinder.visibleGameSize = Vector2(gameWidth, gameHeight);

    camera.viewfinder.position = Vector2(gameWidth / 2.0, gameHeight / 2.0);

    camera.viewfinder.anchor = Anchor.center;
  }
}
