import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:tarot_again/data_layer/data_layer.dart';
import 'package:tarot_again/util/util.dart';

/// Layouts are assets that describe how many cards are needed, and where to
/// locate those cards on the screen, they also provide information on the meanings
/// of the slots.
/// Inside a layout, a card (DealtCard) will be assigned to each layout slot by
/// the LayoutRepository - not here.
///

typedef LayoutAssetCache = IMap<String, TarotLayout>;

class LayoutProvider extends BaseProvider with Logging {
  LayoutAssetCache assetCache = const LayoutAssetCache.empty();

  TarotLayout? currentLayout;

  LayoutProvider._();

  factory LayoutProvider() {
    if (!sl.isRegistered<LayoutProvider>()) {
      return sl.registerSingleton<LayoutProvider>(LayoutProvider._());
    }

    return sl<LayoutProvider>();
  }

  Future<TarotLayout> loadLayout(String layoutAsset) async {
    verbose("loadLayout");
    verbose("  layoutAsset is $layoutAsset");

    if (assetCache.containsKey(layoutAsset)) {
      verbose("  assetCache contains key");
      return assetCache[layoutAsset]!;
    } else {
      String assetData = "";
      TarotLayout retVal = TarotLayout.nullLayout();

      try {
        verbose("trying rootBundle.loadString on layoutAsset");
        assetData = await rootBundle.loadString(layoutAsset);
        verbose("  assetData is $assetData");

        if (assetData.isNotEmpty) {
          final resultMap = jsonDecode(assetData);

          retVal = TarotLayout.fromJson(resultMap);

          assetCache = assetCache.add(layoutAsset, retVal);
        }
      } catch (e) {
        verbose("loadLayout raised error $e");
      }

      return retVal;
    }
  }
}
