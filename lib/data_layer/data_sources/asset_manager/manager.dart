import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:fpdart/fpdart.dart';
import 'package:json_repair_flutter/json_repair_flutter.dart';
import 'package:tarot_again/util/util.dart';

export 'types.dart';

typedef JsonMap = IMap<String, dynamic>;

class AssetManager with Logging implements PostInit {
  AssetManager() {
    log("AssetManager.AssetManager");
  }

  @override
  Future<void> postInit() async {
    final assetPaths = await getAllAssetPaths();
    final layoutsByName = await fetchLayouts();

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
      assetManifest = await AssetManifest.loadFromAssetBundle(rootBundle);
      log("  assetManifest is $assetManifest");
      assetPaths = assetManifest.listAssets();
    } catch (e, s) {
      log("  loadFromAssetBundle raised error $e");
      assetPaths = [e.toString(), s.toString()];
    }

    return assetPaths;
  }

  TaskEither<FlutterError, String> _loadTarotLayoutsJson() =>
      TaskEither<FlutterError, String>.tryCatch(() async {
        return await rootBundle.loadString("assets/tarotLayouts.json");
      }, (e, s) => e as FlutterError);

  Either<FormatException, JsonMap> _parseTarotLayoutsJson(String json) =>
      Either<FormatException, JsonMap>.tryCatch(
        () => IMap<String, dynamic>(jsonDecode(json)),
        (e, s) => e as FormatException,
      );

  Future<IMap<String, TarotLayout>> fetchLayouts() async {
    /// This function loads a json file at assets/tarotLayouts.json that describes all of the different
    /// tarotLayouts available, captured as a single object where each key represents a different pascalCase layout name
    /// and the contents of each key are a json-encoded TarotLayout.  This is simple to read and the function
    /// requires no inputs to achieve its results.
    verbose("LayoutProvider.fetchLayouts");

    IMap<String, TarotLayout> retVal = const IMap<String, TarotLayout>.empty();

    String layoutsJson = await rootBundle.loadString(
      "assets/tarotLayouts.json",
    );
    verbose("  layoutsJson is $layoutsJson");

    if (layoutsJson.isNotEmpty) {
      verbose("  trying repairJson");
      final decodedData = repairJson(
        layoutsJson,
        logging: true,
        skipDecodeAttempt: true,
      );
      verbose("  repairJson returned $decodedData");

      final LayoutList? allLayouts;

      verbose("  trying LayoutList.fromJson()");
      try {
        allLayouts = LayoutList.fromJson(decodedData['data']);
        verbose("  success! allLayouts is $allLayouts");
        verbose("  converting to map");

        for (var item in allLayouts.layouts) {
          retVal = retVal.add(item.name, item);
        }
      } catch (e, _) {
        error("  Failure! LayoutList.fromJson raised error $e");
      }
    }

    return retVal;
  }

  Future<Option<String>> loadMarkdownAsset(String assetPath) async =>
      TaskOption<String>.tryCatch(
        () async => await rootBundle.loadString(assetPath),
      ).run();

  Future<Option<String>> tryLoadMarkdownAsset(
    Iterable<String> assetPaths,
    String kind,
  ) async {
    return assetPaths
        .where((asset) => assetKind(asset) == kind)
        .firstOrNull
        .letWithElse(
          (asset) => loadMarkdownAsset(asset),
          orElse: Option<String>.none(),
        );
  }

  Option<AssetGenImage> tryImageAsset(
    Iterable<String> assetPaths,
    String kind,
  ) => assetPaths
      .where((asset) => assetKind(asset) == kind)
      .firstOrNull
      .letWithElse(
        (assetPath) => Option<AssetGenImage>.of(AssetGenImage(assetPath)),
        orElse: Option<AssetGenImage>.none(),
      );

  String assetKind(String assetPath) =>
      assetPath.split("/").let((it) => it[it.length - 2]);

  Future<TCModelAssets> loadAssetsForCard(TarotDeckCards card) async {
    log("AssetProvider.loadAssetsForCard");

    if (card == TarotDeckCards.noneCard) {
      return (
        description: Option<String>.none(),
        uprightMeaning: Option<String>.none(),
        reversedMeaning: Option<String>.none(),
        image: Option<AssetGenImage>.none(),
      );
    }

    return ComputedsManager.deckAssetPaths.value
        .where((String assetName) => assetName.contains(card.name))
        .let(
          (cardAssets) async => switch (cardAssets.isEmpty) {
            true => (
              description: Option<String>.none(),
              uprightMeaning: Option<String>.none(),
              reversedMeaning: Option<String>.none(),
              image: Option<AssetGenImage>.none(),
            ),
            false => (
              description: await tryLoadMarkdownAsset(
                cardAssets,
                "descriptions",
              ),
              uprightMeaning: await tryLoadMarkdownAsset(
                cardAssets,
                "uprightMeanings",
              ),
              reversedMeaning: await tryLoadMarkdownAsset(
                cardAssets,
                "reversedMeanings",
              ),
              image: tryImageAsset(cardAssets, "images"),
            ),
          },
        );
  }
}
