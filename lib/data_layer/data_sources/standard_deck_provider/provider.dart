import 'package:tarot_again/util/util.dart';

import '../randoms_provider/provider.dart';
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

class StandardDeckProvider with Logging {
  Iterable<TCModel>? _shuffledDeck;
  Iterator<TCModel>? _shuffledDeckIterator;

  // EXPERIMENTAL
  Stream<TCModel>? _currentShuffledCards;
  StreamQueue<TCModel>? currentShuffle;

  // END EXPERIMENTAL

  StandardDeckProvider();

  set shuffledDeck(Iterable<TCModel>? newShuffle) {
    _shuffledDeck = newShuffle;

    if (newShuffle != null) {
      _shuffledDeckIterator = newShuffle.iterator;
      currentShuffle = StreamQueue(Stream<TCModel>.fromIterable(newShuffle));
    }
  }

  Future<void> shuffleDeck() async {
    shuffledDeck = await di<RandomsProvider>().shuffleIterable(_fullDeck);
  }

  Future<TCModel?> getNextCard() {
    // right now, this function does not need to be async, but I can envision a
    // time where it might want to be.
    TCModel? result;

    final Iterator<TCModel>? sdi = _shuffledDeckIterator;

    if (sdi != null) {
      if (sdi.moveNext()) {
        result = sdi.current;
      }
    }

    return Future<TCModel?>.value(result);
  }
}