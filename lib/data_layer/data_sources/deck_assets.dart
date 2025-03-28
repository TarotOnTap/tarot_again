import 'package:flutter/material.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:equatable/equatable.dart';


// TODO: replace this with the real definition
typedef DeckCard = String;

// DeckAssetsMap
@immutable
class CardAssets extends Equatable {
  final Widget Function(DeckCard) representation;

  DeckAssets({required this.representation});
}

typedef DeckAssetsMap = IMap<DeckCard, CardAssets>;

class DeckAssetsDataProvider {
  DeckAssetsDataProvider();

  Future<void> loadDeckAssets(String deckName) async {

  }
}