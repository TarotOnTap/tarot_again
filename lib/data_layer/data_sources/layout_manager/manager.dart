import 'package:tarot_again/util/util.dart';

/// Layouts are assets that describe how many cards are needed, and where to
/// locate those cards on the screen, they also provide information on the meanings
/// of the slots.
/// Inside a layout, a card (DealtCard) will be assigned to each layout slot by
/// the LayoutRepository - not here.
///

typedef LayoutAssetCache = IMap<String, TarotLayout>;

class LayoutManager {
  LayoutManager() {
    log("LayoutManager.LayoutManager");
  }

  TarotLayout? getLayoutByLayoutName(String name) =>
      SignalsManager.tarotLayoutsByName.value[name];

  void setLayoutByLayoutName(String name) => SignalsManager.tarotLayout.value =
      getLayoutByLayoutName(name) ?? TarotLayout.nullLayout();

  TarotLayout? getLayoutByDisplayName(String displayName) =>
      ComputedsManager.layoutsByDisplayName.value[displayName] ??
      TarotLayout.nullLayout(displayName: "No Such Layout");

  void setLayoutByDisplayName(String displayName) =>
      SignalsManager.tarotLayout.value =
          getLayoutByDisplayName(displayName) ?? TarotLayout.nullLayout();
}
