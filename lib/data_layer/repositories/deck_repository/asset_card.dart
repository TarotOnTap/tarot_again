import 'package:tarot_again/data_layer/data_layer.dart';
import 'package:tarot_again/util/util.dart';

export 'repository.dart' show DeckRepository;

const String rootName = "assets/decks/standard_tarot";
const String imageDir = "images/";
const String descriptionsDir = "descriptions";
const String meaningsDir = "meanings/";

typedef AssetMap = IMap<String, String>;

AssetMap assetPathGenerator(String deck, String assetName) {
  return AssetMap({
    "image": "$rootName/$deck/$imageDir/$assetName",
    "description": "$rootName/$deck/$descriptionsDir/$assetName",
    "reversed": "$rootName/$meaningsDir/reversed/$assetName",
    "upright": "$rootName/$meaningsDir/upright/$assetName",
  });
}

class AssetCard {
  final TCModel card;
  final String deckName;

  late final AssetMap assetMap;

  AssetCard({required this.card, required this.deckName}) : assetMap = assetPathGenerator(deckName, card.assetName);
}