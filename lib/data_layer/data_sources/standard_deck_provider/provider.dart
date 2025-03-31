import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:watch_it/watch_it.dart';

import '../randoms_provider/provider.dart';
import 'package:tarot_again/util/util.dart';

final IList<String> minorArcanaSuits =
    <String>["Wands", "Cups", "Swords", "Pentacles"].lock;

enum Suits { wands, cups, swords, pentacles }

enum Pips {
  ace,
  two,
  three,
  four,
  five,
  six,
  seven,
  eight,
  nine,
  ten,
  page,
  knight,
  queen,
  king,
}

final IList<String> minorArcanaNames = IList([
  "Ace",
  "Two",
  "Three",
  "Four",
  "Five",
  "Six",
  "Seven",
  "Eight",
  "Nine",
  "Ten",
  "Page",
  "Knight",
  "Queen",
  "King",
]);

enum MajorArcana {
  fool(name: "The Fool", romanNumber: "0"),
  magician(name: "The Magician", romanNumber: "I"),
  highPriestess(name: "The High Priestess", romanNumber: "II"),
  empress(name: "The Empress", romanNumber: "III"),
  emperor(name: "The Emperor", romanNumber: "IV"),
  hierophant(name: "The Hierophant", romanNumber: "V"),
  lovers(name: "The Lovers", romanNumber: "VI"),
  chariot(name: "The Chariot", romanNumber: "VII"),
  strength(name: "Strength", romanNumber: "VIII"),
  hermit(
    name: "The Hermit",
    romanNumber: "IX",
  ),
  wheelOfFortune(name: "The Wheel of Fortune", romanNumber: "X"),
  justice(name: "Justice", romanNumber: "XI"),
  hangedMan(name: "The Hanged Man", romanNumber: "XII"),
  death(name: "Death", romanNumber: "XIII"),
  temperance(name: "Temperance", romanNumber: "XIV"),
  devil(name: "The Devil", romanNumber: "XV"),
  tower(name: "The Tower", romanNumber: "XVI"),
  star(name: "The Star", romanNumber: "XVII"),
  moon(name: "The Moon", romanNumber: "XVIII"),
  sun(name: "The Sun", romanNumber: "XIX"),
  judgment(name: "Judgment", romanNumber: "XX"),
  theWorld(name: "The World", romanNumber: "XXI");

  final String name;
  final String romanNumber;

  const MajorArcana({
    required this.name,
    required this.romanNumber,
  });
}

sealed class TCModel {
  final int sortOrder;

  String get assetName => "";

  TCModel({
    required this.sortOrder,
  });
}

String toUpperInitial(String str) =>
    str.substring(0, 1).toUpperCase() + str.substring(1);

@immutable
class TCMinorArcanaModel extends TCModel {
  final Pips pips;
  final Suits suit;

  @override
  String get assetName => "${pips.name}_${suit.name}";

  TCMinorArcanaModel({
    required super.sortOrder,
    required this.suit,
    required this.pips,
  });
}


@immutable
class TCMajorArcanaModel extends TCModel {
  final MajorArcana card;

  @override
  String get assetName {
    final IList<String> parts = card.name.split(" ").lock;
    return parts.length > 1 ? parts.skip(1).join("_") : parts[0];
  }

  TCMajorArcanaModel({required this.card})
      : super(sortOrder: card.index);
}

final IList<TCModel> majorArcana = IList<TCModel>(
  MajorArcana.values.map((item) => TCMajorArcanaModel(card: item)),
);

final IList<TCModel> minorArcana =
    [
      for (var suit in Suits.values)
        for (var pips in Pips.values)
          TCMinorArcanaModel(
            sortOrder: (suit.index * Pips.values.length + pips.index + 22),
            suit: suit,
            pips: pips,
            // imageAsset: "${pips.name}_${suit.name}"
          ),
    ].lock;

// this is the authoritative full tarot deck, nobody gets to change it directly.
final IList<TCModel> _fullDeck = [...majorArcana, ...minorArcana].lock;

class StandardDeckProvider with Logging {
  Iterable<TCModel>? _shuffledDeck;
  Iterator<TCModel>? _shuffledDeckIterator;

  StandardDeckProvider();

  set shuffledDeck(Iterable<TCModel>? newShuffle) {
    _shuffledDeck = newShuffle;

    if (newShuffle != null) {
      _shuffledDeckIterator = newShuffle.iterator;
    }
  }

  Future<void> shuffleDeck() async {
    shuffledDeck = await di<RandomsProvider>().shuffleIterable(_fullDeck);
  }

  TCModel? getNextCard() {
    TCModel? result;

    final Iterator<TCModel>? sdi = _shuffledDeckIterator;

    if (sdi != null) {
        if (sdi.moveNext()) {
          result = sdi.current;
        }
    }

    return result;
  }
}