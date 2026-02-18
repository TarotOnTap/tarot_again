import 'package:flutter/material.dart';
import 'package:tarot_again/ui_layer/card_widget/position_slot_widget.dart';
import 'package:tarot_again/util/util.dart';

@singleton
class ComputedsManager with Logging {
  // final SignalsManager signals;

  static final Computed<String> deckString = computed(
    () =>
        "decks/${SignalsManager.deckType.value.name}/${SignalsManager.deckName.value.name}",
    debugLabel: "deckString",
  );

  static final Computed<Iterable<String>> layoutAssetPaths = computed(
    () => SignalsManager.allAssetPaths.value.where(
      (path) => path.contains("assets/layouts"),
    ),
    debugLabel: "layoutAssetPaths",
  );

  static final Computed<IList<String>> layoutDisplayNames = computed(
    () => SignalsManager.tarotLayoutsByName.value.values
        .map((TarotLayout l) => l.displayName)
        .toIList(),
    debugLabel: "layoutDisplayNames",
  );

  static final Computed<IList<String>> layoutNames = computed(
    () => SignalsManager.tarotLayoutsByName.value.keys.toIList(),
    debugLabel: "layoutNames",
  );

  static final Computed<LayoutAssetCache> layoutsByDisplayName = computed(
    () => SignalsManager.tarotLayoutsByName.value.map(
      (key, value) => MapEntry<String, TarotLayout>(value.displayName, value),
    ),
    debugLabel: "layoutsByDisplayName",
  );

  static final Computed<Iterable<String>> deckAssetPaths = computed(
    () => SignalsManager.allAssetPaths.value.where(
      (path) => path.contains("decks/${SignalsManager.deckType.value.name}"),
    ),
    debugLabel: "deckAssetPaths",
  );

  static final Computed<IList<GlobalKey<PositionSlotWidgetState>>>
  slotKeys = computed(
    () =>
        (switch (SignalsManager.tarotLayout.value) {
          NullLayout _ =>
            const IList<GlobalKey<PositionSlotWidgetState>>.empty().also((it) {
              Logging.staticVerbose("slotKeys for NullLayout: $it");
            }),
          // HorizontalLinear hl =>
          //   hl.slotNames
          //       .map(
          //         (slotName) =>
          //             GlobalKey<PositionSlotWidgetState>(debugLabel: slotName),
          //       )
          //       .toIList()
          //       .also((it) {
          //         Logging.staticVerbose("slotKeys for HorizontalLinear: $it");
          //       }),
          SimpleGrid sg =>
            sg.numCards.range
                .map(
                  (index) => GlobalKey<PositionSlotWidgetState>(
                    debugLabel: "slot $index",
                  ),
                )
                .toIList()
                .also((it) {
                  Logging.staticVerbose("slotKeys for SimpleGrid: $it");
                }),
          NewTarotLayout nt =>
            nt.positions
                .map(
                  (position) => GlobalKey<PositionSlotWidgetState>(
                    debugLabel: position.name,
                  ),
                )
                .toIList()
                .also((it) {
                  Logging.staticVerbose("slotKeys for NewTarotLayout: $it");
                }),
        }).also((it) {
          Logging.staticVerbose("  slotKeys calculated, is now $it");
        }),
  );

  static final Computed<Iterable<String>> tarotLayoutAssetPaths = computed(
    () => SignalsManager.allAssetPaths.value.where(
      (path) => path.contains("assets/layouts"),
    ),

    debugLabel: "layoutAssetPaths",
  );

  void ensureComputeds() {
    // var _ = cardSlots.value;
    var _ = deckString.value;
    var _ = layoutAssetPaths.value;
    var _ = layoutDisplayNames.value;
    var _ = layoutNames.value;
    var _ = layoutsByDisplayName.value;
    var _ = deckAssetPaths.value;
    var _ = tarotLayoutAssetPaths.value;
  }

  ComputedsManager(SignalsManager signals) {
    ensureComputeds();
  }
}
