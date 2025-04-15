import 'package:flutter/services.dart';
import 'package:tarot_again/data_layer/data_layer.dart'
    show AssetPathMap, BaseProvider;
import 'package:tarot_again/util/util.dart';

typedef LoadedAssetsMap = IMap<String, String>;

class AssetProvider extends BaseProvider with Logging {
  AssetProvider._();

  factory AssetProvider() {
    if (!sl.isRegistered<AssetProvider>()) {
      return sl.registerSingleton<AssetProvider>(AssetProvider._());
    }

    return sl<AssetProvider>();
  }

  Future<String> loadMarkdownAsset(String assetPath) async {
    String? result;

    if (assetPath.isNotEmpty) {
      try {
        result = await rootBundle.loadString(assetPath);
      } catch (e, s) {
        verbose("AssetProvider.loadMarkdownAsset raised error $e\n\n$s");
      }
    }

    return result ?? "";
  }

  Future<LoadedAssetsMap> loadAssetsByFileExtension(
    AssetPathMap assetPaths,
  ) async {
    // IMap<String, Future<String>> assets =
    //     const IMap<String, Future<String>>.empty();

    IMap<String, Future<String>> assets = assetPaths.map((k, v) {
      Future<String> vX = Future<String>.value("");

      String hold = v ?? "";

      if (hold.endsWith(".jpg")) {
        vX = Future<String>.value(hold);
      }

      if (hold.endsWith(".md")) {
        vX = loadMarkdownAsset(hold).then((String? v) => v ?? "");
      }

      return MapEntry(k, vX);
    });

    final waitables = assets.values;
    final waited = await Future.wait(waitables);

    final LoadedAssetsMap finalResult = LoadedAssetsMap.fromIterables(
      assets.keys,
      waited,
    );

    return finalResult;
  }
}
