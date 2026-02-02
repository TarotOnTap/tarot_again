import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:tarot_again/util/util.dart';

class TarotGame extends FlameGame with Logging {
  @override
  Future<void> onLoad() async {
    try {
      await Flame.images.load('klondike-sprites.png');
    } catch (e) {
      debug("image not loaded, no surprise here.");
    }
  }
}
