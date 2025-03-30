import 'package:flutter/material.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:equatable/equatable.dart';

import 'dart:convert';
import 'package:flutter/foundation.dart';

// const String rootName = "assets/decks/standard_tarot";
// const String imageDir = "images/";
// const String descriptionsDir = "descriptions";
// const String meaningsDir = "meanings/";
//
// typedef AssetsMap = IMap<String, String>;
//
// AssetsMap assetPathGenerator(String deck, TCModel card) {
//   return AssetsMap({
//     "image": "$rootName/$deck/$imageDir/${card.assetName}",
//     "description": "$rootName/$deck/$descriptionsDir/${card.assetName}",
//     "reversed": "$rootName/$meaningsDir/reversed/${card.assetName}",
//     "upright": "$rootName/$meaningsDir/upright/${card.assetName}",
//   });
// }
//
// // DeckAssetsMap
// @immutable
// class CardAssets extends Equatable {
//   // because of the way Flutter handles widgets, we don't want an actual
//   // widget here, but we do want a constructor function that takes a DeckCard and
//   // these CardAssets, to construct a new widget, that can be used in a widget's build
//   // function.
//   final AssetsMap assetsPaths;
//   // like {
//   //   "representation": "fool.jpg",
//   //   "upright": "upright_explanation.md",
//   //   "reversed": "reversed_explanation.md"
//   // }
//   // where each key's data is relative to preselected paths based on the deck and
//   // fixed assets.
//   final Widget Function(TCModel, CardAssets) representation;
//
//   // for which card are we the assets?
//   final TCModel deckCard;
//
//   const CardAssets({
//     required this.representation,
//     required this.deckCard,
//     required this.assetsPaths
//   });
//
//   CardAssets copyWith({
//     Widget Function(TCModel, CardAssets)? representation,
//     TCModel? deckCard,
//     AssetsMap? assetsPaths}) =>
//     CardAssets(
//         representation: representation ?? this.representation,
//     deckCard: deckCard ?? this.deckCard,
//     assetsPaths: assetsPaths ?? this.assetsPaths
//     );
//
//   void loadCardAssets() async {
//     Future<DisplayDeck> loadAssets() async {
//       DisplayDeck retval = this;
//
//       if (deckName != "__empty__") {
//         Map<TCModel, ByteData?> temp = {};
//
//         // this section accounts for decks that don't have all of their images
//         // available in assets, which is very much a development issue. Once a
//         // deck has all its images, this can be much more straightforward.
//         for (final TCModel card in fullDeck) {
//           if (card.assetName != "") {
//             String keyName = "$rootName$deckName/$imageDir$card.imageAsset";
//
//             temp[card] = await rootBundle.load(keyName);
//           } else {
//             temp[card] = null;
//           }
//         }
//
//         retval = copyWith(deckImages: temp.lock, ready: true);
//       }
//
//       return retval;
//     }
//
//
//   }
//
//   @override
//   List<Object> get props => [ representation, deckCard ];
// }
//
// typedef DeckAssetsMap = IMap<TCModel, CardAssets>;
//
// class DeckAssetsDataProvider {
//   DeckAssetsDataProvider();
//
//   Future<void> loadDeckAssets(String deckName) async {
//
//   }
// }

class ShuffledDeckAccess {
  // This class only manages access to the shuffled deck.
  // It responds to ShuffleDeck and GetNextCard,
  // and it sends ShuffleDeckReady and NextCard.
  // NextCard is a message that contains a TCModel card, and does not carry
  // information about reversals, etc.
}

class CardAssetsManager {
  // This class loads the assets (image widget, etc.) for a given card.
  // It responds to LoadCardAssets messages, containing the card,
  // and sends a CardAssetsLoaded message containing the card and the
  // loaded assets - widget class, markdown text, etc.

}