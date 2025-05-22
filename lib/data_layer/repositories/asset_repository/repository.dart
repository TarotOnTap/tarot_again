// import 'package:tarot_again/data_layer/data_layer.dart';
import 'package:tarot_again/util/util.dart';

class AssetRepository {
  AssetRepository();

  Future<void> loadAssetsForCard({
    required int index,
    required TarotDeckCards card,
  }) async {
    await sl<AssetProvider>().loadAssetsForCard(card);
  }
}
