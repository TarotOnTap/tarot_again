import 'package:tarot_again/util/util.dart';

export 'asset_reactives.dart';
export 'layout_reactives.dart';
export 'session_manager.dart';
// import 'types.dart';
export 'types.dart';

// Reactives is a class that manages the specific instances of reactivity, but
// does not itself host reactives. It ensures that every reactive is ready to go.
class Reactives with Logging implements Singleton {
  final Signal<bool> allCardsFaceUp = signal<bool>(
    false,
    debugLabel: "allCardsFaceUp",
  );

  final Signal<String> cardBackStyle = signal<String>(
    "",
    debugLabel: "cardBackStyle",
  );

  final Signal<bool> cardsDealt = signal<bool>(false, debugLabel: "cardsDealt");

  final Signal<IList<SlotState>> cardSlots = signal(
    const IList<SlotState>.empty(),
    debugLabel: "cardSlots",
  );

  final Signal<DeckTypesEnum> deckType = signal<DeckTypesEnum>(
    DeckTypesEnum.standardTarot,
    debugLabel: "deckType",
  );

  final Signal<StandardTarotDecksEnum> deckName =
      signal<StandardTarotDecksEnum>(
        StandardTarotDecksEnum.rws,
        debugLabel: "deckName",
      );

  final Signal<IList<TarotDeckCards>> shuffledDeck = signal(
    const IList<TarotDeckCards>.empty(),
    debugLabel: "shuffledDeck",
  );

  final Signal<bool> reversalsAllowed = signal<bool>(
    true,
    debugLabel: "reversalsAllowed",
  );

  // computeds
  // late final Computed<IList<String>> deckAssetPaths;

  late final Computed<String> deckString;

  // we're doing this as an effect because, if we do cardSlots as a computed,
  // every change to a member of cardSlots will trigger a rebuild of the entire
  // cardSlots list afresh, wiping out the assigned SlotStateDealt value.
  late final void Function() cancelComputeSlots;

  void _computeSlots() {
    if (tarotLayout.value is NullLayout) {
      cardSlots.value = const IList<SlotState>.empty();
    } else {
      batch(
        () => cardSlots.value = untracked(
          () => [
            for (var i in tarotLayout.value.numCards.range())
              SlotState(slotIndex: i),
          ].toIList(),
        ),
      );
    }
  }

  Reactives() {
    verbose("Reactives.Reactives");

    initializeAssetReactives();
    initializeLayoutReactives();

    for (var signal in [
      allCardsFaceUp,
      cardBackStyle,
      cardsDealt,
      cardSlots,
      deckType,
      deckName,
      shuffledDeck,
      reversalsAllowed,
    ]) {
      var _ = (signal as ReadonlySignal<dynamic>).value;
    }

    deckString = computed(
      () => "decks/${deckType.value.name}/${deckName.value.name}",
      debugLabel: "deckString",
    );

    cancelComputeSlots = effect(() {
      tarotLayout.value.also((_) {
        _computeSlots();
      });
    }, debugLabel: "cancelComputeSlots");
  }
}
