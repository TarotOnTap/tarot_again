import 'package:tarot_again/data_layer/data_layer.dart';
import 'package:tarot_again/data_layer/repositories/deck_repository/asset_card.dart';
import 'package:tarot_again/util/util.dart';

// export 'asset_card.dart' show AssetPathsCard;
export 'repository.dart' show DeckRepository;

part 'types.freezed.dart';
part 'types.g.dart';
// export 'asset_card.dart' show AssetCard, LoadedAssetMap;

// @immutable
// class DealtCard extends Equatable {

class DealtModel {
  String assetName;
  AssetPathMap paths;
  LoadedAssetsMap? assets;

  DealtModel({required this.assetName}) {
    paths = assetPathGenerator(assetName);
  }

  // void loadAssets() async {
  //   assets = await di<AssetProvider>().loadAssetsByFileExtension(paths);
  // }

  Future<DealtCard> transform({
    required TCModel card,
    required bool reversed,
  }) async {
    assets = await sl<AssetProvider>().loadAssetsByFileExtension(paths);

    final DealtCard retVal = DealtCard.deckCard(
      //   required AssetPathMap assetPaths,
      card: card,
      reversed: reversed,
      imageAssetPath: assets?["image"] ?? "",
      description: assets?["description"] ?? "",
      uprightMeaning: assets?["upright"] ?? "",
      reversedMeaning: assets?["reversed"] ?? "",
    );

    return retVal;
  }
}

@freezed
@JsonSerializable()
abstract class DealtCard
    with _$DealtCard {
  // DealtCard();

  factory DealtCard.deckCard({
    required TCModel card,
    required bool reversed,
    @Default("") String imageAssetPath,
    @Default("") String description,
    @Default("") String uprightMeaning,
    @Default("") String reversedMeaning,
  }) = DeckCard;

  factory DealtCard.deckEmpty() = DeckEmpty;

  factory DealtCard.fromJson(Map<String, Object?> json) =>
      _$DealtCardFromJson(json);

  Map<String, Object?> toJson() => _$DealtCardToJson(this);
}

//
// @freezed
// @JsonSerializable()
// final class DeckCard extends DealtCard with _$DeckCard {
//   final TCModel card;
//   final bool reversed;
//
//   late final String imageAssetPath;
//   late final String description;
//   late final String uprightMeaning;
//   late final String reversedMeaning;
//
//   DeckCard({
//     required AssetPathMap paths,
//     required this.card,
//     required this.reversed,
//   }) {
//     imageAssetPath = paths["image"] ?? "";
//     description = paths["description"] ?? "";
//     uprightMeaning = paths["upright"] ?? "";
//     reversedMeaning = paths["reversed"] ?? "";
//   }
//
//   factory DeckCard.fromJson(Map<String, Object?> json) =>
//       _$DeckCardFromJson(json);
//
//   Map<String, Object?> toJson() => _$DeckCardToJson(this);
//
//   //
//   // DeckCard({
//   //   required AssetPathMap assetPaths,
//   //   required TCModel card,
//   //   required bool reversed,
//   //   @Default("") String imageAssetPath,
//   //   @Default("") String description,
//   //   @Default("") String uprightMeaning,
//   //   @Default("") String reversedMeaning,
//   // }) = _DeckCard;
// }
//
// @freezed
// @JsonSerializable()
// final class DeckEmpty extends DealtCard with _$DeckEmpty {
//   DeckEmpty();
//
//   factory DeckEmpty.fromJson(Map<String, Object?> json) =>
//       _$DeckEmptyFromJson(json);
//
//   @override
//   Map<String, Object?> toJson() => _$DeckEmptyToJson(this);
// }
//
// // @freezed
// // abstract class DealtCard with _$DealtCard {
// //   // final AssetPathMap assetPaths;
// //   //
// //   // final TCModel card;
// //   //
// //   // final bool reversed;
// //   //
// //   // final Image? image;
// //   // final String? imageAssetPath;
// //   //
// //   // final String? description, uprightMeaning, reversedMeaning;
// //
// //   const DealtCard._();
// //
// //   factory DealtCard.deckCard({
// //     required AssetPathMap assetPaths,
// //     required TCModel card,
// //     required bool reversed,
// //     @Default("") String imageAssetPath,
// //     @Default("") String description,
// //     @Default("") String uprightMeaning,
// //     @Default("") String reversedMeaning,
// //   }) = _DeckCard;
// //
// //   factory DealtCard.deckEmpty() = _DeckEmpty;
// //
// //   factory DealtCard.fromJson(Map<String, Object?> json) =>
// //       _$DealtCardFromJson(json);
// // }