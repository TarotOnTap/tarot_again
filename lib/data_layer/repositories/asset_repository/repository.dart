// import 'package:tarot_again/data_layer/data_layer.dart';
import 'package:tarot_again/util/util.dart';

class AssetRepository {
  AssetRepository() {
    log("AssetRepository.AssetRepository");
  }

  static Future<void> loadAssetsForSlot({required SlotState slot}) async {
    log("AssetRepository.loadAssetsForCard: $slot");
    if (slot.deckCard.value != null) {
      log("  slot.deckCard.value is ${slot.deckCard.value}");
      final assets = await sl<AssetManager>().loadAssetsForCard(
        slot.deckCard.value!,
      );
      log("  assets is $assets");

      slot.assets.value = assets;
      log("  slot changed to $slot");
    }
  }
}
