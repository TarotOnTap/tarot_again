import 'package:tarot_again/util/util.dart';

class ComputedsManager {
  static final Computed<IList<SlotState>> cardSlots = computed(
    () => switch (SignalsManager.tarotLayout.value) {
      NullLayout _ => const IList<SlotState>.empty(),
      _ => untracked(
        () => [
          for (var i in SignalsManager.tarotLayout.value.numCards.range())
            SlotState(slotIndex: i),
        ].toIList(),
      ),
    },
    debugLabel: "cardSlots",
  );

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

  static final Computed<Iterable<String>> tarotLayoutAssetPaths = computed(
    () => SignalsManager.allAssetPaths.value.where(
      (path) => path.contains("assets/layouts"),
    ),

    debugLabel: "layoutAssetPaths",
  );

  void ensureComputeds() {
    var _ = cardSlots.value;
    var _ = deckString.value;
    var _ = layoutAssetPaths.value;
    var _ = layoutDisplayNames.value;
    var _ = layoutNames.value;
    var _ = layoutsByDisplayName.value;
    var _ = deckAssetPaths.value;
    var _ = tarotLayoutAssetPaths.value;
  }

  ComputedsManager() {
    ensureComputeds();
  }
}
