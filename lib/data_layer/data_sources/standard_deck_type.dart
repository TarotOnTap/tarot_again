import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/foundation.dart';

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

  String get imageAsset => "";

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
  String get imageAsset => "${pips.name}_${suit.name}";

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
  String get imageAsset {
  final IList<String> parts = card.name.split(" ").lock;
  String fileName = parts.length > 1 ? parts.skip(1).join("_") : parts[0];

  return "$fileName.jpg";
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

sealed class DeckDataProviderEvent extends MessageEvent {
  const DeckDataProviderEvent({super.sender});
}
class ShuffleDeck extends DeckDataProviderEvent {}
class DeckShuffled extends DeckDataProviderEvent {}
class GetFullDeck extends DeckDataProviderEvent {}

@immutable
class FullDeck extends DeckDataProviderEvent {
  late final IList<TCModel> fullDeck;
  FullDeck({super.sender}) { fullDeck = _fullDeck; }

  @override
  List<Object?> get props => [ sender, fullDeck ];
}

@immutable
class GetNextCard extends MessageEvent {}

@immutable
class NextCard extends MessageEvent {
  final TCModel card;

  const NextCard({super.sender, required this.card});

  @override
  NextCard copyWith({Object? sender, TCModel? card}) =>
      NextCard(
        sender: sender ?? this.sender,
        card: card ?? this.card
      );

  @override
  List<Object?> get props => [ sender, card ];
}


class StandardDeckDataProvider with Logging {
  StandardDeckDataProvider() {
    onEvent<ShuffleDeck>(onData: _handleShuffleDeck);

    onEvent<GetFullDeck>(onData: _getFullDeck);
  }

  void _handleShuffleDeck(ShuffleDeck event) {
    verbose("StandardDeckDataProvider._handleShuffleDeck received ShuffleDeck event.");
    verbose("  sending DeckShuffled message");
    eventSend(DeckShuffled());
  }

  void _getFullDeck(GetFullDeck event) => eventSend(FullDeck());
}