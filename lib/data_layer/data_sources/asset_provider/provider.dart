import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import 'package:tarot_again/data_layer/data_layer.dart'
    show TCModel, AssetPathMap;
import 'package:tarot_again/util/util.dart' show Logging;

typedef LoadedAssetsMap = IMap<String, Object?>;

class AssetProvider with Logging {
  AssetProvider();

  Future<Image?> loadImageAsset(String assetPath) async {
    ByteData? result;
    Image? image;

    if (assetPath.isNotEmpty) {
      try {
        result = await rootBundle.load(assetPath);
      } catch (e, s) {
        verbose(
          "AssetProvider.loadImageAsset raised error $e. Asset not found.\n\n$s",
        );
      }

      if (result != null) {
        image = Image.memory(Uint8List.sublistView((result)));
      }
    }

    return image;
  }

  Future<String?> loadMarkdownAsset(String assetPath) async {
    String? result;

    if (assetPath.isNotEmpty) {
      try {
        result = await rootBundle.loadString(assetPath);
      } catch (e, s) {
        verbose("AssetProvider.loadMarkdownAsset raised error $e\n\n$s");
      }
    }

    return result;
  }

  Future<LoadedAssetsMap> loadAssetsByFileExtension(
    AssetPathMap assetPaths,
  ) async {
    IMap<String, Future<Object?>> assets =
        const IMap<String, Future<Object?>>.empty();

    // in this for loop, we're not going to await every asset load. Instead, we'll
    // collect them all afterwards and use Future.wait to do the waiting.
    for (var MapEntry(:key, :value) in assetPaths.entries) {
      if (value != null) {
        if (value.endsWith(".jpg")) {
          assets = assets.add(key, loadImageAsset(value));
        }

        if (value.endsWith(".md")) {
          assets = assets.add(key, loadMarkdownAsset(value));
        }
      }
    }

    final r = await Future.wait(assets.values);

    final LoadedAssetsMap finalResult = LoadedAssetsMap.fromIterables(
      assets.keys,
      r,
    );

    return finalResult;
  }
}
