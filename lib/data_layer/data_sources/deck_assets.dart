import 'package:flutter/material.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:equatable/equatable.dart';


// TODO: replace this with the real definition
typedef DeckCard = String;

// DeckAssetsMap
@immutable
class CardAssets extends Equatable {
  // because of the way Flutter handles widgets, we don't want an actual
  // widget here, but we do want a constructor function that takes a DeckCard and
  // these CardAssets, to construct a new widget, that can be used in a widget's build
  // function.
  final Widget Function(DeckCard, CardAssets) representation;

  // for which card are we the assets?
  final DeckCard deckCard;

  const CardAssets({required this.representation, required this.deckCard});

  CardAssets copyWith({Widget Function(DeckCard, CardAssets)? representation, DeckCard? deckCard}) =>
    CardAssets(representation: representation ?? this.representation,
    deckCard: deckCard ?? this.deckCard);

  @override
  List<Object> get props => [ representation, deckCard ];
}

typedef DeckAssetsMap = IMap<DeckCard, CardAssets>;

class DeckAssetsDataProvider {
  DeckAssetsDataProvider();

  Future<void> loadDeckAssets(String deckName) async {

  }
}