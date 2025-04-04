import 'package:tarot_again/blocs/blocs.dart';
import 'package:tarot_again/data_layer/data_layer.dart';
import 'package:tarot_again/util/util.dart';

export 'repository.dart' show DeckRepository;

const String rootName = "assets/decks/standard_tarot";
const String imageDir = "images/";
const String descriptionsDir = "descriptions";
const String meaningsDir = "meanings/";

// typedef AssetPathMap = IMap<String, String?>;

AssetPathMap assetPathGenerator(String assetName) {
  String deck = di<BulkCardControlBloc>().state.deckName;

  return AssetPathMap({
    "image": "$rootName/$deck/$imageDir/$assetName",
    "description": "$rootName/$deck/$descriptionsDir/$assetName",
    "reversed": "$rootName/$meaningsDir/reversed/$assetName",
    "upright": "$rootName/$meaningsDir/upright/$assetName",
  });
}

//
// class AssetPathsCard {
//   final TCModel card;
//   final String deckName;
//
//   late final AssetPathMap assetMap;
//
//   AssetPathsCard({required this.card, required this.deckName})
//     : assetMap = assetPathGenerator(deckName, card.assetName);
//
//   static AssetPathMap assetPathGenerator(String deck, String assetName) {
//     return AssetPathMap({
//       "image": "$rootName/$deck/$imageDir/$assetName",
//       "description": "$rootName/$deck/$descriptionsDir/$assetName",
//       "reversed": "$rootName/$meaningsDir/reversed/$assetName",
//       "upright": "$rootName/$meaningsDir/upright/$assetName",
//     });
//   }
// }