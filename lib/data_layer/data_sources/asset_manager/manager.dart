import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:fpdart/fpdart.dart';
import 'package:tarot_again/util/util.dart';

export 'types.dart';

class LayoutPathInfo {
  final String name;
  final String path;
  final String? descriptionFile;

  LayoutPathInfo({
    required this.name,
    required this.path,
    this.descriptionFile,
  });
}

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
      // log("  loading asset manifest from asset bundle");
      assetManifest = await AssetManifest.loadFromAssetBundle(rootBundle);
      // log("  asset manifest loaded from asset bundle");
      log("  assetManifest is $assetManifest");
      // log("  assetManifest.listAssets() is ${assetManifest.listAssets()}");
      assetPaths = assetManifest.listAssets();
    } catch (e, s) {
      log("  loadFromAssetBundle raised error $e");
      assetPaths = [e.toString(), s.toString()];
    }

    // log("  assetManifest.listAssets() is '${assetManifest?.listAssets()}'");

    return assetPaths;
  }

  Future<IMap<String, TarotLayout>> fetchLayouts() async {
    /// This function loads a json file at assets/tarotLayouts.json that describes all of the different
    /// tarotLayouts available, captured as a single object where each key represents a different camelCase layout name
    /// and the contents of each key are a json-encoded TarotLayout.  This is simple to read and the function
    /// requires no inputs to achieve its results.
    log("LayoutProvider.fetchLayouts");

    String? layoutsJson;

    try {
      // try to load our asset file from the fixed location given
      layoutsJson = await rootBundle.loadString("assets/tarotLayouts.json");
    } catch (e, _) {
      // if that fails, log an error
      log("fetchLayouts raised error $e");

      // and return an empty layout map
      return const IMap<String, TarotLayout>.empty();
    }

    // otherwise, decode the whole json into a map
    IMap<String, dynamic> layoutsItems = IMap<String, dynamic>(
      jsonDecode(layoutsJson),
    );

    // log("  layoutsItems is $layoutsItems");
    //
    // IMap<String, TarotLayout> retVal = const IMap<String, TarotLayout>.empty();
    //
    // for (String key in layoutsItems.keys) {
    //   log("attempting to add $key:${layoutsItems.keys} to retVal");
    //
    //   try {
    //     retVal = retVal.add(key, TarotLayout.fromJson(layoutsItems[key]));
    //   } catch (e, _) {
    //     log("  key $key raised error $e");
    //   }
    // }
    //
    // log("  retval is $retVal");
    // return retVal;

    // and return a map that uses the same keys as our json file input, but has TarotLayout objects as values
    return layoutsItems.map<String, TarotLayout>(
      (key, value) =>
          MapEntry<String, TarotLayout>(key, TarotLayout.fromJson(value)),
    );
  }

  Future<Option<String>> loadMarkdownAsset(String assetPath) async =>
      TaskOption<String>.tryCatch(
        () async => await rootBundle.loadString(assetPath),
      ).run();

  Future<Option<String>> tryLoadMarkdownAsset(
    Iterable<String> assetPaths,
    String kind,
  ) async {
    String? assetPath = assetPaths
        .where((asset) => assetKind(asset) == kind)
        .firstOrNull;

    if (assetPath == null) {
      return Option<String>.none();
    } else {
      return loadMarkdownAsset(assetPath);
    }
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
