import 'package:flutter/services.dart';
import 'package:tarot_again/util/util.dart';

import '../randoms_provider/randoms_provider.dart';
import 'types.dart';

Future<void> mapAssets() async {
  Logging.staticVerbose("in the toplevel function mapAssets");
  AssetManifest manifest = await AssetManifest.loadFromAssetBundle(rootBundle);
  Logging.staticVerbose("mapAssets has found the manifest:");
  Logging.staticVerbose("  ${manifest.listAssets()}");
}

// this is the authoritative full tarot deck, nobody gets to change it directly.
// final IList<TarotDeckCards> _fullDeck = TarotDeckCards.values.lock;

/// StandardDeck provider is the model of a standard 78-card tarot deck. It provides
/// a means to shuffle the deck, and to retrieve cards from the shuffled deck.
/// it provides an [Iterator] over the current deck, a [Stream], and a [StreamQueue].
/// only one of those should survive the development process, but we'll see.
class StandardDeckProvider {
  ///  [_shuffledDeck] holds the current, shuffled deck. Beware, its default
  ///  value is an empty IList.
  late Iterable<TarotDeckCards> _shuffledDeck;
  late AsyncRandoms asyncRandoms;

  /// [_shuffledDeckIterator] is the iterator exposed by [_shuffledDeck].
  late Iterator<TarotDeckCards> _shuffledDeckIterator;

  // EXPERIMENTAL
  /// [currentShuffleStream] is a Stream based on [_shuffledDeck]. This may change
  /// in the Future, because [AsyncRandoms] exposes a stream over a shuffled [Iterable]
  /// of items passed in to shuffle.
  late Stream<TarotDeckCards> currentShuffleStream;

  /// [currentShuffleQueue] is a convenient [StreamQueue] for getting cards from
  /// the current shuffle. So far, this is the interface I like best.
  late StreamQueue<TarotDeckCards> currentShuffleQueue;

  // END EXPERIMENTAL

  /// [StandardDeckProvider] constructor, which sets [shuffledDeck] to an empty
  /// [IList] of type [TCModel]
  StandardDeckProvider._() {
    shuffledDeck = const IList<TarotDeckCards>.empty();
  }

  factory StandardDeckProvider() {
    if (!sl.isRegistered<StandardDeckProvider>()) {
      sl.registerSingleton<StandardDeckProvider>(StandardDeckProvider._());
    }

    return sl<StandardDeckProvider>();
  }

  /// setter [shuffleDeck] sets the [_shuffledDeck] member to an [Iterable],
  /// over TCModels, as produced by [AsyncRandoms] and its subclasses.
  /// it then proceeds to set [_shuffledDeckIterator], [currentShuffleStream],
  /// and [currentShuffleQueue] from the same source.
  set shuffledDeck(Iterable<TarotDeckCards> newShuffle) {
    _shuffledDeck = newShuffle;

    _shuffledDeckIterator = _shuffledDeck.iterator;

    // please note - the only correct way to shuffle a deck is to use
    // the shuffleDeck method.  That method cancels currentShuffleQueue and
    // currentShuffleStream before setting the shuffled deck into place, so
    // that we don't try to manage async here in the setter.

    // there is one valid exception to this rule - calling the setter from
    // the constructor, where an empty iterable is used as the base.
    currentShuffleStream = Stream<TarotDeckCards>.fromIterable(_shuffledDeck);
    currentShuffleQueue = StreamQueue(currentShuffleStream);
  }

  /// [unShuffleDeck] sets the current deck to a copy of the full, unshuffled
  /// standard tarot deck. For development purposes, mostly, although it could
  /// be useful for producing decks to study, etc. Async to match to signature
  /// of [shuffleDeck]
  Future<void> unShuffleDeck() async {
    shuffledDeck = TarotDeckCards.values;
  }

  /// [shuffleDeck] uses AsyncRandoms to shuffle the full standard tarot deck,
  /// and then sets the current deck to that. It also cancels the [currentShuffleQueue]
  /// to make sure we don't leak memory there.
  Future<void> shuffleDeck() async {
    await mapAssets();

    final AsyncRandoms ar = sl<AsyncRandoms>();

    await currentShuffleQueue.cancel(immediate: true);

    shuffledDeck = await ar.shuffleIterable(TarotDeckCards.values);
  }

  /// convenience method to get the next card from the [currentShuffleQueue], which
  /// is a more convenient way to get the deck one card at a time.  To get
  /// multiple cards in one fell sweeop, use [currentShuffleQueue.take]
  Future<TarotDeckCards?> getNextCard() => currentShuffleQueue.next;
}
