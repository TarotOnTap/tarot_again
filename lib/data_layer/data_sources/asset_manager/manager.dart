import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:tarot_again/util/util.dart';

export 'types.dart';

class AssetManager implements PostInit {
  AssetManager() {
    log("AssetManager.AssetManager");
  }

  @override
  postInit() async {
    final assetPaths = await getAllAssetPaths();
    final layoutsByName = await fetchLayouts(assetPaths);

    // initialize all of our fixed assets, here, in one go
    batch(() {
      SignalsManager.allAssetPaths.value = assetPaths;
      SignalsManager.tarotLayoutsByName.value = layoutsByName;
    });
  }

  static Future<Iterable<String>> getAllAssetPaths() async {
    log("AssetManager.getAllAssetPaths");
    AssetManifest? assetManifest;
    var assetPaths = <String>[];

    try {
      log("  loading asset manifest from asset bundle");
      assetManifest = await AssetManifest.loadFromAssetBundle(rootBundle);
      log("  asset manifest loaded from asset bundle");
      log("  assetManifest is $assetManifest");
      log("  assetManifest.listAssets() is ${assetManifest.listAssets()}");
      assetPaths = assetManifest.listAssets();
    } catch (e, s) {
      log("  loadFromAssetBundle raised error $e");
      assetPaths = [e.toString(), s.toString()];
    }

    log("  assetManifest.listAssets() is '${assetManifest?.listAssets()}'");

    return assetPaths;
  }

  static String _layoutName(String assetPath) {
    final partsList = assetPath.split("/");
    final nameParts = partsList.last.split(".");

    return nameParts[0];
  }

  static Future<TarotLayout> loadLayout(String layoutAsset) async {
    log("LayoutProvider.loadLayout\n  layoutAsset is $layoutAsset");

    TarotLayout retVal = TarotLayout.nullLayout();

    String assetData = "";

    try {
      log("trying rootBundle.loadString on layoutAsset");
      assetData = await rootBundle.loadString(layoutAsset);
      log("  assetData is $assetData");

      if (assetData.isNotEmpty) {
        log("  assetData is not empty");
        final resultMap = jsonDecode(assetData);
        log("  resultMap is $resultMap");

        retVal = TarotLayout.fromJson(resultMap);
        log("  retVal is $retVal");
      }
    } catch (e) {
      log("loadLayout raised error $e on asset string $layoutAsset");
    }

    return retVal;
    // }
  }

  Future<IMap<String, TarotLayout>> fetchLayouts(
    Iterable<String> assetPaths,
  ) async {
    log("LayoutProvider.fetchLayouts");

    final layoutPaths = assetPaths.where(
      (path) => path.contains("assets/layouts"),
    );

    IMap<String, TarotLayout> retVal = const IMap<String, TarotLayout>.empty();

    if (layoutPaths.isNotEmpty) {
      final Iterable<String> names = layoutPaths.map(
        (name) => _layoutName(name),
      );

      final sPaths = await Stream<String>.fromIterable(
        layoutPaths,
      ).asyncMap((event) => loadLayout(event)).toList();

      retVal = IMap<String, TarotLayout>.fromIterables(names, sPaths);
    }

    return retVal;
  }

  Future<String> loadMarkdownAsset(String assetPath) async {
    log("AssetProvider.loadMarkdownAsset");
    String? result;

    try {
      result = await rootBundle.loadString(assetPath);
    } catch (e, s) {
      log("AssetProvider.loadMarkdownAsset raised error $e\n\n$s");
    }

    return result ?? "";
  }

  Future<TCModelAssets?> loadAssetsForCard(TarotDeckCards card) async {
    log("AssetProvider.loadAssetsForCard");
    TCModelAssets? retVal;

    // first, find all of the assets associated with the given card in the deck in the deckType
    Iterable<String> cardAssets = ComputedsManager.deckAssetPaths.value.where(
      (String assetName) => assetName.contains(card.name),
    );

    log("  cardAssets is $cardAssets");

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
