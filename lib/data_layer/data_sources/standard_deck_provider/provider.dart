import 'package:tarot_again/util/util.dart';

import '../randoms_provider/randoms_provider.dart';
import 'enums.dart';
import 'tc_model.dart';

String majorAssetName(MajorArcana item) =>
    item.name.split(" ").map((String n) => n.toLowerCase()).join("_");

String minorAssetName(Suits suit, Pips pips) => "${pips.name}_${suit.name}";

final IList<TCModel> majorArcana = IList<TCModel>(
  MajorArcana.values.map(
    (item) => TCModel.tcMajorArcanaModel(
      sortOrder: item.index,
      card: item,
      assetName: majorAssetName(item),
    ),
  ),
);

final IList<TCModel> minorArcana =
    [
      for (var suit in Suits.values)
        for (var pips in Pips.values)
          TCModel.tcMinorArcanaModel(
            sortOrder: (suit.index * Pips.values.length + pips.index + 22),
            suit: suit,
            pips: pips,
            assetName: minorAssetName(suit, pips),
            // imageAsset: "${pips.name}_${suit.name}"
          ),
    ].lock;

// this is the authoritative full tarot deck, nobody gets to change it directly.
final IList<TCModel> _fullDeck = [...majorArcana, ...minorArcana].lock;

/// StandardDeck provider is the model of a standard 78-card tarot deck. It provides
/// a means to shuffle the deck, and to retrieve cards from the shuffled deck.
/// it provides an [Iterator] over the current deck, a [Stream], and a [StreamQueue].
/// only one of those should survive the development process, but we'll see.
class StandardDeckProvider with Logging {
  ///  [_shuffledDeck] holds the current, shuffled deck. Beware, its default
  ///  value is an empty IList.
  late Iterable<TCModel> _shuffledDeck;
  late AsyncRandoms asyncRandoms;

  /// [_shuffledDeckIterator] is the iterator exposed by [_shuffledDeck].
  late Iterator<TCModel> _shuffledDeckIterator;

  // EXPERIMENTAL
  /// [currentShuffleStream] is a Stream based on [_shuffledDeck]. This may change
  /// in the Future, because [AsyncRandoms] exposes a stream over a shuffled [Iterable]
  /// of items passed in to shuffle.
  late Stream<TCModel> currentShuffleStream;

  /// [currentShuffleQueue] is a convenient [StreamQueue] for getting cards from
  /// the current shuffle. So far, this is the interface I like best.
  late StreamQueue<TCModel> currentShuffleQueue;

  // END EXPERIMENTAL

  /// [StandardDeckProvider] constructor, which sets [shuffledDeck] to an empty
  /// [IList] of type [TCModel]
  StandardDeckProvider._() {
    shuffledDeck = const IList<TCModel>.empty();
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
  set shuffledDeck(Iterable<TCModel> newShuffle) {
    _shuffledDeck = newShuffle;

    _shuffledDeckIterator = _shuffledDeck.iterator;

    // please note - the only correct way to shuffle a deck is to use
    // the shuffleDeck method.  That method cancels currentShuffleQueue and
    // currentShuffleStream before setting the shuffled deck into place, so
    // that we don't try to manage async here in the setter.

    // there is one valid exception to this rule - calling the setter from
    // the constructor, where an empty iterable is used as the base.
    currentShuffleStream = Stream<TCModel>.fromIterable(_shuffledDeck);
    currentShuffleQueue = StreamQueue(currentShuffleStream);
  }

  /// [unShuffleDeck] sets the current deck to a copy of the full, unshuffled
  /// standard tarot deck. For development purposes, mostly, although it could
  /// be useful for producing decks to study, etc. Async to match to signature
  /// of [shuffleDeck]
  Future<void> unShuffleDeck() async {
    shuffledDeck = _fullDeck;
  }

  /// [shuffleDeck] uses AsyncRandoms to shuffle the full standard tarot deck,
  /// and then sets the current deck to that. It also cancels the [currentShuffleQueue]
  /// to make sure we don't leak memory there.
  Future<void> shuffleDeck() async {
    final AsyncRandoms ar = sl<AsyncRandoms>();

    await currentShuffleQueue.cancel(immediate: true);

    shuffledDeck = await ar.shuffleIterable(_fullDeck);
  }

  /// convenience method to get the next card from the [currentShuffleQueue], which
  /// is a more convenient way to get the deck one card at a time.  To get
  /// multiple cards in one fell sweeop, use [currentShuffleQueue.take]
  Future<TCModel?> getNextCard() => currentShuffleQueue.next;
}
