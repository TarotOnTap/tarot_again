import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import 'package:tarot_again/data_layer/data_layer.dart' show TCModel, AssetCard, AssetMap;
import 'package:tarot_again/util/util.dart' show Logging;

class AssetProvider with Logging {
  AssetProvider();

  Future<Image?> loadImageAsset(String assetPath) async {
    ByteData? result;
    Image? image;

    try {
       result = await rootBundle.load(assetPath);
    } catch (e, s) {
      verbose("AssetProvider.loadImageAsset raised error $e. Asset not found.\n\n$s");
    }

    if (result != null) {
      image = Image.memory(Uint8List.sublistView((result)));
    }

    return image;
  }

  Future<String?> loadMarkdownAsset(String assetPath) async {
    String? result;

    try {
      result = await rootBundle.loadString(assetPath);
    } catch (e, s) {
      verbose("AssetProvider.loadMarkdownAsset raised error $e\n\n$s");
    }

    return result;
  }

  Future<IMap<String, Object?>> loadAssetsByFileExtension(AssetMap assetPaths) async {
    IMap<String, Object?> assets = const IMap<String, Future<Object?>>.empty();

    for (final entry in assetPaths.entries) {
      if (entry.key.endsWith(".jpg")) {
        assets = assets.add(entry.key, await loadImageAsset(entry.value));
      }

      if (entry.key.endsWith(".md")) {
        assets = assets.add(entry.key, await loadMarkdownAsset(entry.key));
      }
    }

    return assets;
  }
}