import 'package:tarot_again/util/util.dart';

/// StandardDeck provider is the model of a standard 78-card tarot deck. It provides
/// a means to shuffle the deck, and to retrieve cards from the shuffled deck.
/// it provides an [Iterator] over the current deck, a [Stream], and a [StreamQueue].
/// only one of those should survive the development process, but we'll see.
class StandardDeckProvider {
  ///  [shuffledDeck] holds the current, shuffled deck. Beware, its default
  ///  value is an empty IList.
  ///

  StandardDeckProvider() {
    log("StandardDeckProvider.StandardDeckProvider");
  }

  /// [unShuffleDeck] sets the current deck to a copy of the full, unshuffled
  /// standard tarot deck. For development purposes, mostly, although it could
  /// be useful for producing decks to study, etc. Async to match to signature
  /// of [shuffleDeck]
  static Future<void> unShuffleDeck() async =>
      SignalsManager.shuffledDeck.value = TarotDeckCards.values.toIList();

  /// [shuffleDeck] uses AsyncRandoms to shuffle the full standard tarot deck,
  /// and then sets the current deck to that. It also cancels the [currentShuffleQueue]
  /// to make sure we don't leak memory there.
  static Future<void> shuffleDeck() async => SignalsManager.shuffledDeck.value =
      (await sl<AsyncRandoms>().shuffleIterable(
        TarotDeckCards.values,
      )).toIList();
}
