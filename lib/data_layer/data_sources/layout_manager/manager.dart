import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:tarot_again/util/util.dart';

/// Layouts are assets that describe how many cards are needed, and where to
/// locate those cards on the screen, they also provide information on the meanings
/// of the slots.
/// Inside a layout, a card (DealtCard) will be assigned to each layout slot by
/// the LayoutRepository - not here.
///

typedef LayoutAssetCache = IMap<String, TarotLayout>;

class LayoutManager extends BaseProvider with Logging {
  LayoutManager() {
    verbose("LayoutManager.LayoutManager");

    // make sure the signals and computeds we use are initialized
    final _ = allAssetPaths.value;
    final _ = tarotLayoutAssetPaths.value;
    final _ = layoutsByDisplayName.value;

    // fetchLayouts().then((layouts) => tarotLayoutsByName.value = layouts);
  }

  static String _layoutName(String assetPath) {
    final partsList = assetPath.split("/");
    final nameParts = partsList.last.split(".");

    return nameParts[0];
  }

  static Future<TarotLayout> loadLayout(String layoutAsset) async {
    Logging.staticVerbose(
      "LayoutProvider.loadLayout\n  layoutAsset is $layoutAsset",
    );

    // AssetProvider ap = sl<AssetProvider>();

    TarotLayout retVal = TarotLayout.nullLayout();

    String assetData = "";

    try {
      Logging.staticVerbose("trying rootBundle.loadString on layoutAsset");
      assetData = await rootBundle.loadString(layoutAsset);
      Logging.staticVerbose("  assetData is $assetData");

      if (assetData.isNotEmpty) {
        Logging.staticVerbose("  assetData is not empty");
        final resultMap = jsonDecode(assetData);
        Logging.staticVerbose("  resultMap is $resultMap");

        retVal = TarotLayout.fromJson(resultMap);
        Logging.staticVerbose("  retVal is $retVal");
      }
    } catch (e) {
      Logging.staticVerbose(
        "loadLayout raised error $e on asset string $layoutAsset",
      );
    }

    return retVal;
    // }
  }

  Future<IMap<String, TarotLayout>> fetchLayouts() async {
    Logging.staticVerbose("LayoutProvider.fetchLayouts");

    final Iterable<String> names = tarotLayoutAssetPaths.value.map(
      (name) => _layoutName(name),
    );

    final sPaths = await Stream<String>.fromIterable(
      tarotLayoutAssetPaths.value,
    ).asyncMap((event) => loadLayout(event)).toList();

    return IMap<String, TarotLayout>.fromIterables(names, sPaths);
  }

  TarotLayout getLayoutByLayoutName(String name) =>
      switch (tarotLayoutsByName.value) {
        AsyncData data => data.value[name],
        _ => TarotLayout.nullLayout(displayName: "No Such Layout"),
      };

  void setLayoutByLayoutName(String name) =>
      tarotLayout.value = getLayoutByLayoutName(name);

  TarotLayout getLayoutByDisplayName(String displayName) =>
      layoutsByDisplayName.value[displayName] ??
      TarotLayout.nullLayout(displayName: "No Such Layout");

  void setLayoutByDisplayName(String displayName) =>
      tarotLayout.value = getLayoutByDisplayName(displayName);
}
