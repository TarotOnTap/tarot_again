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
class LayoutProvider extends BaseProvider with Logging {
  TarotLayout? currentLayout;

  LayoutProvider._();

  factory LayoutProvider() {
    if (!sl.isRegistered<LayoutProvider>()) {
      return sl.registerSingleton<LayoutProvider>(LayoutProvider._());
    }

    return sl<LayoutProvider>();
  }

  Future<TarotLayout> loadLayout(String layoutAsset) async {
    String assetData = "";
    TarotLayout retVal = TarotLayout.nullLayout();

    try {
      assetData = await rootBundle.loadString(layoutAsset);
    } catch (e) {
      verbose("loadLayout raised error $e");
    }

    if (assetData.isNotEmpty) {
      final resultMap = jsonDecode(assetData);

      retVal = TarotLayout.fromJson(resultMap);
    }

    return retVal;
  }
}
