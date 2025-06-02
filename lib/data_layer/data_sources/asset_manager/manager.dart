import 'package:flutter/services.dart';
import 'package:tarot_again/util/util.dart';

export 'types.dart';

class AssetManager with Logging {
  AssetManager() {
    verbose("AssetProvider.AssetProvider");

    // getAllAssetPaths().then((paths) {
    //   allAssetPaths.value = paths.toIList();
    // });
  }

  Future<Iterable<String>> getAllAssetPaths() async {
    verbose("AssetProvider._getAllAssetPaths");
    final AssetManifest assetManifest = await AssetManifest.loadFromAssetBundle(
      rootBundle,
    );

    return assetManifest.listAssets();
  }

  Future<String> loadMarkdownAsset(String assetPath) async {
    verbose("AssetProvider.loadMarkdownAsset");
    String? result;

    try {
      result = await rootBundle.loadString(assetPath);
    } catch (e, s) {
      verbose("AssetProvider.loadMarkdownAsset raised error $e\n\n$s");
    }

    return result ?? "";
  }

  Future<TCModelAssets?> loadAssetsForCard(TarotDeckCards card) async {
    verbose("AssetProvider.loadAssetsForCard");
    TCModelAssets? retVal;

    // first, find all of the assets associated with the given card in the deck in the deckType
    Iterable<String> cardAssets = deckAssetPaths.value.where(
      (String assetName) => assetName.contains(card.name),
    );

    verbose("  cardAssets is $cardAssets");

    if (cardAssets.isNotEmpty) {
      retVal = TCModelAssets();

      for (var asset in cardAssets) {
        final assetPathParts = asset.split("/");

        final String assetName = assetPathParts.last;
        final String assetKind = assetPathParts[assetPathParts.length - 1];

        final IList<String> info = assetName.split(".").toIList();
        final String fileType = info[1];

        switch (assetKind) {
          case "descriptions":
            String description = await loadMarkdownAsset(asset);
            retVal = retVal?.copyWith(description: description);

          case "reversedMeanings":
            String reversed = await loadMarkdownAsset(asset);
            retVal = retVal?.copyWith(reversedMeaning: reversed);

          case "uprightMeanings":
            String upright = await loadMarkdownAsset(asset);
            retVal = retVal?.copyWith(uprightMeaning: upright);

          case "images":
            if (["jpg", "jpeg", "png", "gif"].contains(fileType)) {
              // AssetGenImage image = AssetGenImage(asset);
              retVal = retVal?.copyWith(image: AssetGenImage(asset));
            }
        }
      }
    }

    return retVal;
  }
}
