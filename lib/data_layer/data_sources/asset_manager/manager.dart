import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:fpdart/fpdart.dart';
import 'package:tarot_again/util/util.dart';

export 'types.dart';

typedef JsonMap = IMap<String, dynamic>;

class AssetManager implements PostInit {
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
    log("LayoutProvider.fetchLayouts");

    IMap<String, TarotLayout> retVal = const IMap<String, TarotLayout>.empty();

    String layoutsJson = await rootBundle.loadString(
      "assets/tarotLayouts.json",
    );

    if (layoutsJson.isNotEmpty) {
      // KEEP the comments below, they document the former effort to safely retrieve
      // our asset. Dart documentation tells that errors derived from Error are not meant
      // to be caught; they represent a programming error.
      // try {
      //   // try to load our asset file from the fixed location given
      //   layoutsJson = await rootBundle.loadString("assets/tarotLayouts.json");
      // } catch (e, _) {
      //   // if that fails, log an error
      //   log("fetchLayouts raised error $e");
      //
      //   return retVal; // return an empty map
      // }

      try {
        retVal = IMap<String, dynamic>(jsonDecode(layoutsJson))
            .map<String, TarotLayout>(
              (key, value) => MapEntry<String, TarotLayout>(
                key,
                TarotLayout.fromJson(value),
              ),
            );
      } catch (e, _) {
        log("error decoding json: $e");
      }
    }

    // and return a map that uses the same keys as our json file input, but has TarotLayout objects as values
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
