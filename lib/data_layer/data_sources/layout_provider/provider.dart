import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:tarot_again/managers/session_manager/types.dart';
import 'package:tarot_again/util/util.dart';

/// Layouts are assets that describe how many cards are needed, and where to
/// locate those cards on the screen, they also provide information on the meanings
/// of the slots.
/// Inside a layout, a card (DealtCard) will be assigned to each layout slot by
/// the LayoutRepository - not here.
///

typedef LayoutAssetCache = IMap<String, TarotLayout>;

class LayoutProvider extends BaseProvider with Logging {
  // late final FutureSignal<LayoutAssetCache> layoutAssetMap;

  final LoggingSignal<LayoutAssetCache> layoutsByName = loggingSignal(
    const LayoutAssetCache.empty(),
    name: "layoutsByName",
  );

  late final LoggingComputed<LayoutAssetCache> layoutsByDisplayName;

  late final LoggingComputed<IList<String>> layoutNames;
  late final LoggingComputed<IList<String>> layoutDisplayNames;

  LayoutProvider() {
    layoutsByDisplayName = loggingComputed(() {
      final keys = layoutsByDisplayName.value.values.map(
        (TarotLayout l) => l.displayName,
      );

      return LayoutAssetCache.fromIterables(
        keys,
        layoutsByDisplayName.value.values,
      );
    }, name: "layoutsByDisplayName");

    layoutNames = loggingComputed(
      () => layoutsByName.value.keys.toIList(),
      name: "layoutNames",
    );

    layoutDisplayNames = loggingComputed(
      () => layoutsByDisplayName.value.keys.toIList(),
      name: "layoutDisplayNames",
    );

    effect(
      () => sl<AssetProvider>().tarotLayoutAssetPaths.value.also(
        (_) => loadLayouts(),
      ),
    );
  }

  String _layoutName(String assetPath) {
    final partsList = assetPath.split("/");
    final nameParts = partsList.last.split(".");

    return nameParts[0];
  }

  Future<TarotLayout> loadLayout(String layoutAsset) async {
    verbose("LayoutProvider.loadLayout\n  layoutAsset is $layoutAsset");

    // AssetProvider ap = sl<AssetProvider>();

    TarotLayout retVal = TarotLayout.nullLayout();

    String assetData = "";

    try {
      verbose("trying rootBundle.loadString on layoutAsset");
      assetData = await rootBundle.loadString(layoutAsset);
      verbose("  assetData is $assetData");

      if (assetData.isNotEmpty) {
        verbose("  assetData is not empty");
        final resultMap = jsonDecode(assetData);
        verbose("  resultMap is $resultMap");

        retVal = TarotLayout.fromJson(resultMap);
        verbose("  retVal is $retVal");
      }
    } catch (e) {
      verbose("loadLayout raised error $e on asset string $layoutAsset");
    }

    return retVal;
    // }
  }

  Future<void> _loadLayouts() async {
    final ap = sl<AssetProvider>();

    IList<String> names = ap.layoutAssetPaths.value.map(_layoutName).toIList();

    final sPaths = await Stream<String>.fromIterable(
      ap.layoutAssetPaths.value,
    ).asyncMap((event) => loadLayout(event)).toList();

    layoutsByName.value = IMap<String, TarotLayout>.fromIterables(
      names,
      sPaths,
    );
  }

  void loadLayouts() => unawaited(_loadLayouts());
}
