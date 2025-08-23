// import 'package:tarot_again/data_layer/data_layer.dart';
import 'package:fpdart/fpdart.dart';
import 'package:tarot_again/util/util.dart';

class AssetRepository {
  AssetRepository() {
    log("AssetRepository.AssetRepository");
  }

  static Task<TCModelAssets> loadAssetsForCard({
    required TarotDeckCards card,
  }) => Task<TCModelAssets>(
    () async => switch (card) {
      TarotDeckCards.noneCard => emptyTCModelAssets,
      _ => sl<AssetManager>().loadAssetsForCard(card),
    },
  );
}
