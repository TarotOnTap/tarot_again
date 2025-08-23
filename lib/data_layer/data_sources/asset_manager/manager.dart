import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:fpdart/fpdart.dart';
import 'package:tarot_again/util/util.dart';

export 'types.dart';

class AssetManager implements PostInit {
  AssetManager() {
    log("AssetManager.AssetManager");
  }

  @override
  Future<void> postInit() async {
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

  static (String, String) _layoutNameAndPath(String assetPath) {
    final partsList = assetPath.split("/");
    final nameParts = partsList.last.split(".");

    return (nameParts[0], partsList.sublist(0, partsList.length - 2).join("/"));
  }

  static Future<TarotLayout> loadLayout(String layoutAsset) async {
    log("LayoutProvider.loadLayout\n  layoutAsset is $layoutAsset");

    TarotLayout retVal = TarotLayout.nullLayout();

    String assetData = "";

    try {
      assetData = await rootBundle.loadString(layoutAsset);

      if (assetData.isNotEmpty) {
        retVal = TarotLayout.fromJson(jsonDecode(assetData));
      }
    } catch (e) {
      log("loadLayout raised error $e on asset string $layoutAsset");
    }

    return retVal;
  }

  Future<IMap<String, TarotLayout>> fetchLayouts(
    Iterable<String> assetPaths,
  ) async {
    log("LayoutProvider.fetchLayouts");

    // return await Stream<String>.fromIterable(
    //   assetPaths.where((path) => path.contains("assets/layouts")),
    // ).asyncMap((event) => loadLayout(event)).fold(const IMap<String, TarotLayout>.empty(), (map, layout) => map.add(layout.name, layout));

    IMap<String, TarotLayout> retVal = const IMap<String, TarotLayout>.empty();

    final layoutPaths = assetPaths.where(
      (path) => path.contains("assets/layouts"),
    );

    // final Iterable<String> names = layoutPaths.map(
    //   ((String name, String path)) => _layoutNameAndPath(name),
    // );

    final Iterable<String> names = [''];

    final sPaths = await Stream<String>.fromIterable(
      layoutPaths,
    ).asyncMap((event) => loadLayout(event)).toList();

    retVal = IMap<String, TarotLayout>.fromIterables(names, sPaths);

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
