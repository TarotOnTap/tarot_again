import 'package:tarot_again/util/util.dart';

/// Effects manager - a class that registers effects to run when a signal or
/// a computed changes. The effects are saved so that they can be cancelled as
/// needed.
/// The dispose functions are saved on the class instance and not as statics,
/// so if you want to dispose one of these functions, be sure to use
/// if (sl<EffectsManager>().disposeLoadCardImages case != null)(), for instance
@singleton
class EffectsManager {
  // void Function()? disposeLoadCardImages;

  /// EffectsManager pays attention to signals and computeds, so we inject them
  /// here
  EffectsManager({
    required this.signalsManager,
    required this.computedsManager,
  }) {
    // disposeLoadCardImages = effect(() async {
    //   // When deckString changes, this effect will run; it loads images for all
    //   // of the cards in the new deck into the image cache.
    //   final String imageStr = "${ComputedsManager.deckString}/images/";
    //
    //   final waitList = TarotDeckCards.values.map(
    //     (value) => Flame.images.load("$imageStr${value.name}.png"),
    //   );
    //
    //   await Future.wait(waitList);
    // });
  }

  final SignalsManager signalsManager;
  final ComputedsManager computedsManager;

  // factory EffectsManager() = EffectsManager._;
}
