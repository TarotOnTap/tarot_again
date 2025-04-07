import 'package:tarot_again/data_layer/data_layer.dart';
import 'package:tarot_again/data_layer/repositories/deck_repository/asset_card.dart';
import 'package:tarot_again/util/util.dart';

export 'repository.dart' show DeckRepository;

part 'types.freezed.dart';
part 'types.g.dart';

class DealtModel {
  final String assetName;
  final AssetPathMap paths;
  late final LoadedAssetsMap assets;

  DealtModel({required this.assetName}) : paths = assetPathGenerator(assetName);

  // void loadAssets() async {
  //   assets = await di<AssetProvider>().loadAssetsByFileExtension(paths);
  // }

  Future<DealtCard> transform({
    required TCModel card,
    required bool reversed,
  }) async {
    assets = await sl<AssetProvider>().loadAssetsByFileExtension(paths);

    final DealtCard retVal = DealtCard.deckCard(
      card: card,
      reversed: reversed,
      imageAssetPath: assets["image"] ?? "",
      description: assets["description"] ?? "",
      uprightMeaning: assets["upright"] ?? "",
      reversedMeaning: assets["reversed"] ?? "",
    );

    return retVal;
  }
}

@freezed
// @JsonSerializable()
sealed class DealtCard with _$DealtCard {
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
}
