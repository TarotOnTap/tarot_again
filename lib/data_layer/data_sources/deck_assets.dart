import 'package:flutter/material.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:equatable/equatable.dart';


// TODO: replace this with the real definition
typedef DeckCard = String;

const String rootName = "assets/decks/";
const String imageDir = "images/";
const String meaningsDir = "meanings/";

typedef AssetsMap = IMap<String, String>;

// DeckAssetsMap
@immutable
class CardAssets extends Equatable {
  // because of the way Flutter handles widgets, we don't want an actual
  // widget here, but we do want a constructor function that takes a DeckCard and
  // these CardAssets, to construct a new widget, that can be used in a widget's build
  // function.
  final AssetsMap assetsPaths;
  // like {
  //   "representation": "fool.jpg",
  //   "upright": "upright_explanation.md",
  //   "reversed": "reversed_explanation.md"
  // }
  // where each key's data is relative to preselected paths based on the deck and
  // fixed assets.
  final Widget Function(DeckCard, CardAssets) representation;

  // for which card are we the assets?
  final DeckCard deckCard;

  const CardAssets({
    required this.representation,
    required this.deckCard,
    required this.assetsPaths
  });

  CardAssets copyWith({
    Widget Function(DeckCard, CardAssets)? representation,
    DeckCard? deckCard,
    AssetsMap? assetsPaths}) =>
    CardAssets(
        representation: representation ?? this.representation,
    deckCard: deckCard ?? this.deckCard,
    assetsPaths: assetsPaths ?? this.assetsPaths
    );

  void loadCardAssets() async {
    Future<DisplayDeck> loadAssets() async {
      DisplayDeck retval = this;

      if (deckName != "__empty__") {
        Map<TCModel, ByteData?> temp = {};

        // this section accounts for decks that don't have all of their images
        // available in assets, which is very much a development issue. Once a
        // deck has all its images, this can be much more straightforward.
        for (final TCModel card in fullDeck) {
          if (card.imageAsset != "") {
            String keyName = "$rootName$deckName/$imageDir$card.imageAsset";

            temp[card] = await rootBundle.load(keyName);
          } else {
            temp[card] = null;
          }
        }

        retval = copyWith(deckImages: temp.lock, ready: true);
      }

      return retval;
    }


  }

  @override
  List<Object> get props => [ representation, deckCard ];
}

typedef DeckAssetsMap = IMap<DeckCard, CardAssets>;

class DeckAssetsDataProvider {
  DeckAssetsDataProvider();

  Future<void> loadDeckAssets(String deckName) async {

  }
}