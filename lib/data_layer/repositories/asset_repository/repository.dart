// import 'package:tarot_again/data_layer/data_layer.dart';
import 'package:tarot_again/util/util.dart';

class AssetRepository extends Singleton with Logging {
  AssetRepository() {
    verbose("AssetRepository.AssetRepository");
  }

  AssetRepository init() => AssetRepository();

  static Future<void> loadAssetsForSlot({required SlotState slot}) async {
    Logging.staticVerbose("AssetRepository.loadAssetsForCard: $slot");
    if (slot.deckCard.value != null) {
      Logging.staticVerbose("  slot.deckCard.value is ${slot.deckCard.value}");
      final assets = await sl<AssetManager>().loadAssetsForCard(
        slot.deckCard.value!,
      );
      Logging.staticVerbose("  assets is $assets");

      slot.assets.value = assets;
      Logging.staticVerbose("  slot changed to $slot");
    }
  }
}
