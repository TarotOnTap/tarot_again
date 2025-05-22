import 'package:signals/signals_flutter.dart';
import 'package:tarot_again/util/util.dart';

// import '../randoms_provider/randoms_provider.dart';
// import 'types.dart';

// this is the authoritative full tarot deck, nobody gets to change it directly.
// final IList<TarotDeckCards> _fullDeck = TarotDeckCards.values.lock;

/// StandardDeck provider is the model of a standard 78-card tarot deck. It provides
/// a means to shuffle the deck, and to retrieve cards from the shuffled deck.
/// it provides an [Iterator] over the current deck, a [Stream], and a [StreamQueue].
/// only one of those should survive the development process, but we'll see.
class StandardDeckProvider {
  ///  [shuffledDeck] holds the current, shuffled deck. Beware, its default
  ///  value is an empty IList.
  ///
  AsyncSignal<IList<TarotDeckCards>> shuffledDeck = asyncSignal(
    AsyncState.loading(),
  );

  StandardDeckProvider();

  /// [unShuffleDeck] sets the current deck to a copy of the full, unshuffled
  /// standard tarot deck. For development purposes, mostly, although it could
  /// be useful for producing decks to study, etc. Async to match to signature
  /// of [shuffleDeck]
  Future<void> unShuffleDeck() async {
    shuffledDeck.value = AsyncState<IList<TarotDeckCards>>.data(
      TarotDeckCards.values.toIList(),
    );
  }

  /// [shuffleDeck] uses AsyncRandoms to shuffle the full standard tarot deck,
  /// and then sets the current deck to that. It also cancels the [currentShuffleQueue]
  /// to make sure we don't leak memory there.
  Future<void> shuffleDeck() async {
    shuffledDeck.value = AsyncState<IList<TarotDeckCards>>.loading();

    final value = await sl<AsyncRandoms>().shuffleIterable(
      TarotDeckCards.values,
    );

    shuffledDeck.value = AsyncState<IList<TarotDeckCards>>.data(value);
  }
}
