import 'package:flutter/services.dart';
import 'package:tarot_again/data_layer/data_layer.dart'; // show AssetPathMap, BaseProvider;
import 'package:tarot_again/util/util.dart';

class AssetProvider extends BaseProvider with Logging {
  final _allAssets = AsyncMemoizer<IList<String>>();

  AssetProvider._() {
    // unawaited(mapAssets());
  }

  factory AssetProvider() {
    if (!sl.isRegistered<AssetProvider>()) {
      return sl.registerSingleton<AssetProvider>(AssetProvider._());
    }

    return sl<AssetProvider>();
  }

  Future<IList<String>> get allAssets async => _allAssets.runOnce(() async {
    verbose('mapAssets');
    AssetManifest assetManifest = await AssetManifest.loadFromAssetBundle(
      rootBundle,
    );

    return assetManifest.listAssets().toIList();
  });

  // MappableNode addAssetPath(
  //   String assetPath,
  //   Iterable<String> nodeList,
  //   MappableNode currentMap,
  // ) {
  //   String key = nodeList.first;
  //
  //   // skip the assets directory, as we'll get it from assetPath anyway when we go to
  //   // get the actual asset.
  //   if (key == "assets") {
  //     nodeList = nodeList.tail;
  //   }
  //
  //   if (!currentMap.containsKey(key)) {
  //     currentMap = currentMap.add(key, MappableNode(parent: currentMap));
  //   }
  //
  //   if (nodeList.length == 2) {
  //     LeafNode leaf = LeafNode(assetPath: assetPath, parent: currentMap[key]);
  //     leavesMap = leavesMap.add(assetPath, leaf);
  //
  //     currentMap[key]?.add(nodeList.last, leaf);
  //
  //     return currentMap;
  //   } else {
  //     return addAssetPath(
  //       assetPath,
  //       nodeList.tail,
  //       currentMap[key] ?? MappableNode(parent: currentMap),
  //     );
  //   }
  // }

  // Future<void> mapAssets() async {
  //   verbose('mapAssets');
  //   AssetManifest assetManifest = await AssetManifest.loadFromAssetBundle(
  //     rootBundle,
  //   );
  //
  //   for (var asset in assetManifest.listAssets()) {
  //     assetMap = addAssetPath(asset, asset.split("/"), assetMap);
  //   }
  // }

  // Future<void> loadAssets() async {
  //   for (var item in leavesMap.entries) {
  //     Object? asset = switch (item.value.assetType) {
  //       LeafAssetTypes.json => loadJsonAsset(item.key),
  //       LeafAssetTypes.markdown => loadMarkdownAsset(item.key),
  //       LeafAssetTypes.image => item.value.imageAsset,
  //       LeafAssetTypes.unknown => null,
  //     };
  //
  //     if (asset is Future) {
  //       asset = await asset;
  //     }
  //   }
  // }

  // Future<Map<String, dynamic>?> loadJsonAsset(String assetPath) async {
  //   Map<String, dynamic>? result;
  //   JsonDecoder decoder = JsonDecoder();
  //
  //   try {
  //     final String temp = await rootBundle.loadString(assetPath);
  //
  //     result = decoder.convert(temp);
  //   } catch (e, s) {
  //     verbose("AssetProvider.loadJsonAsset raised error $e\n\n$s");
  //   }
  //
  //   return Future<Map<String, dynamic>?>.value(result);
  // }

  Future<String> loadMarkdownAsset(String assetPath) async {
    String? result;

    try {
      result = await rootBundle.loadString(assetPath);
    } catch (e, s) {
      verbose("AssetProvider.loadMarkdownAsset raised error $e\n\n$s");
    }

    return result ?? "";
  }

  Future<TCModelAssets?> loadAssetsForCard(
    String deckType,
    String deckName,
    TarotDeckCards card,
  ) async {
    verbose("AssetProvider.loadAssetsForCard");
    verbose("  deckType: $deckType; deckName: $deckName; card: $card");
    TCModelAssets? retVal;

    // first, find all of the assets associated with the given card in the deck in the deckType
    IList<String> cardAssets =
        (await allAssets)
            .where(
              (String assetName) =>
                  assetName.contains("decks/$deckType/$deckName/${card.name}"),
            )
            .toIList();

    verbose("  cardAssets is $cardAssets");

    if (cardAssets.isNotEmpty) {
      retVal = TCModelAssets();

      for (var asset in cardAssets) {
        final String assetName = asset.split("/").last;

        final IList<String> info = assetName.split(".").toIList();
        final String fileType = info[1];

        switch (assetName) {
          case "description":
            String description = await loadMarkdownAsset(asset);
            retVal = retVal?.copyWith(description: description);

          case "reversed":
            String reversed = await loadMarkdownAsset(asset);
            retVal = retVal?.copyWith(reversed: reversed);

          case "upright":
            String upright = await loadMarkdownAsset(asset);
            retVal = retVal?.copyWith(upright: upright);

          case _:
            if (["jpg", "jpeg", "png", "gif"].contains(fileType)) {
              AssetGenImage image = AssetGenImage(asset);
              retVal = retVal?.copyWith(image: image);
            }
        }
      }
    }

    return retVal;
  }

  Future<IList<String>> findTarotLayouts() async {
    verbose("AssetProvider.findTarotLayouts()");
    verbose("  allAssets is ${await allAssets}");

    final tempAssets = await allAssets;
    final tempLayouts =
        tempAssets
            .where(
              (String assetName) => assetName.contains("layouts/tarot_layouts"),
            )
            .toIList();
    verbose("  tempLayouts is $tempLayouts");

    return tempLayouts;
  }
}
