import 'package:flutter/material.dart';
import 'package:tarot_again/ui_layer/card_widget/position_slot_widget.dart';
import 'package:tarot_again/util/util.dart';
import 'package:fpdart/fpdart.dart';

@singleton
class ComputedsManager(final SignalsManager signalsManager) with Logging {
  late final Computed<String> deckString = computed(
    () =>
        "decks/${signalsManager.deckType.value.name}/${signalsManager.deckName.value.name}",
    options: ComputedOptions(name: "deckString"),
  );

  late final Computed<Iterable<String>> layoutAssetPaths = computed(
    () => signalsManager.allAssetPaths.value.where(
      (path) => path.contains("assets/layouts"),
    ),
    options: ComputedOptions(name: "layoutAssetPaths"),
  );

  late final Computed<IList<String>> layoutDisplayNames = computed(
    () => signalsManager.tarotLayoutsByName.value.values
        .map((TarotLayout l) => l.displayName)
        .toIList(),
    options: ComputedOptions(name: "layoutDisplayNames"),
  );

  late final Computed<IList<String>> layoutNames = computed(
    () => signalsManager.tarotLayoutsByName.value.keys.toIList(),
    options: ComputedOptions(name: "layoutNames"),
  );

  late final Computed<LayoutAssetCache> layoutsByDisplayName = computed(
    () => signalsManager.tarotLayoutsByName.value.map(
      (key, value) => MapEntry<String, TarotLayout>(value.displayName, value),
    ),
    options: ComputedOptions(name: "layoutsByDisplayName"),
  );

  late final Computed<Iterable<String>> deckAssetPaths = computed(
    () => signalsManager.allAssetPaths.value.where(
      (path) => path.contains("decks/${signalsManager.deckType.value.name}"),
    ),
    options: ComputedOptions(name: "deckAssetPaths"),
  );

  late final Computed<IList<GlobalKey<PositionSlotWidgetState>>>
  slotKeys = computed(
    () => (switch (signalsManager.tarotLayout.value) {
      NullLayout _ => const IList<GlobalKey<PositionSlotWidgetState>>.empty(),

      SimpleGrid sg =>
        sg.numCards.range
            .map(
              (index) =>
                  GlobalKey<PositionSlotWidgetState>(debugLabel: "slot $index"),
            )
            .toIList()
            .also((it) {
              Logging.sVerbose("slotKeys for SimpleGrid: $it");
            }),
      NewTarotLayout nt =>
        nt.positions
            .map(
              (position) =>
                  GlobalKey<PositionSlotWidgetState>(debugLabel: position.name),
            )
            .toIList()
            .also((it) {
              Logging.sVerbose("slotKeys for NewTarotLayout: $it");
            }),
    }),
  );

  late final Computed<Iterable<String>> tarotLayoutAssetPaths = computed(
    () => signalsManager.allAssetPaths.value.where(
      (path) => path.contains("assets/layouts/tarotLayouts"),
    ),
    options: ComputedOptions(name: "tarotLayoutAssetPaths"),
  );

  late final FutureSignal<Option<String>> tarotLayoutDescription = computedFrom(
    [signalsManager.tarotLayout],
    (args) async {
      final TarotLayout layout = args[0];
      final String location = layout.mdLayoutDescription ?? "";
      final description = await sl<AssetManager>().loadMarkdownAsset(location);

      return description;
    },
    options: AsyncSignalOptions(name: "tarotLayoutDescription"),
  );

  void ensureComputeds() {
    // var _ = cardSlots.value;
    var _ = deckString.value;
    var _ = layoutAssetPaths.value;
    var _ = layoutDisplayNames.value;
    var _ = layoutNames.value;
    var _ = layoutsByDisplayName.value;
    var _ = deckAssetPaths.value;
    var _ = slotKeys.value;
    var _ = tarotLayoutAssetPaths.value;
    var _ = tarotLayoutDescription.value;
  }
}
