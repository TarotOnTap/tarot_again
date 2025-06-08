// import 'package:tarot_again/data_layer/data_layer.dart';
import 'package:tarot_again/util/util.dart';

class AssetRepository {
  AssetRepository() {
    log("AssetRepository.AssetRepository");
  }

  static Future<TCModelAssets?> loadAssetsForCard({
    required TarotDeckCards card,
  }) async {
    log("AssetRepository.loadAssetsForCard: $card");
    if (card != TarotDeckCards.noneCard) {
      log("  card is $card");
      final assets = await sl<AssetManager>().loadAssetsForCard(card);
      log("  assets is $assets");

      return assets;
    }

    return null;
  }
}
