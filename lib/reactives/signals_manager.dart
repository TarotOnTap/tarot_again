import 'package:tarot_again/util/util.dart';

class SignalsManager {
  static final Signal<Iterable<String>> allAssetPaths =
      signal<Iterable<String>>([], debugLabel: "allAssetPaths");

  static final Signal<bool> allCardsFaceUp = signal<bool>(
    false,
    debugLabel: "allCardsFaceUp",
  );

  static final Signal<String> cardBackStyle = signal<String>(
    "",
    debugLabel: "cardBackStyle",
  );

  static final SettingsBackedSignal<StandardTarotDecks> deckName =
      settingsBackedSignal<StandardTarotDecks>(
        StandardTarotDecks.rwsTarotDeck,
        debugLabel: "deckName",
        settingsKey: "deckName",
      );

  static final SettingsBackedSignal<DeckTypesEnum> deckType =
      settingsBackedSignal<DeckTypesEnum>(
        DeckTypesEnum.standardTarotDeck,
        debugLabel: "deckType",
        settingsKey: "deckType",
      );

  static final Signal<RandomGenerators> currentRandomGenerator =
      signal<RandomGenerators>(
        RandomGenerators.none,
        debugLabel: "currentGenerator",
      );

  static final Signal<RandomsProvider> currentRandomProvider =
      signal<RandomsProvider>(SecureRandom(), debugLabel: "currentProvider");

  // a signal that is persisted to SharedPreferences storage.  When this is true,
  // dealing out tarot cards will display cards as upright or reversed; setting
  // it falls will deal out upright cards only.
  static final SettingsBackedSignal<bool> reversalsAllowed =
      settingsBackedSignal<bool>(
        true,
        debugLabel: "reversalsAllowed",
        settingsKey: "reversalsAllowed",
      );

  static final Signal<IList<TarotDeckCards>> shuffledDeck = signal(
    const IList<TarotDeckCards>.empty(),
    debugLabel: "shuffledDeck",
  );

  static final Signal<TarotLayout> tarotLayout = signal<TarotLayout>(
    TarotLayout.nullLayout(),
    debugLabel: "tarotLayout",
  );

  static final Signal<IMap<String, TarotLayout>> tarotLayouts =
      signal<IMap<String, TarotLayout>>(
        const IMap<String, TarotLayout>.empty(),
      );

  static final Signal<IMap<String, TarotLayout>> tarotLayoutsByName =
      signal<IMap<String, TarotLayout>>(
        const IMap<String, TarotLayout>.empty(),
        debugLabel: "tarotLayoutInfosByName",
      );

  static void ensureSignals() {
    final toInitialize = <ReadonlySignal>[
      allAssetPaths,
      allCardsFaceUp,
      cardBackStyle,
      // cardsDealt,
      currentRandomGenerator,
      currentRandomProvider,
      deckType,
      deckName,
      shuffledDeck,
      reversalsAllowed,
      tarotLayout,
      tarotLayoutsByName,
    ];

    for (var init in toInitialize) {
      var _ = init.value;
    }
  }

  SignalsManager() {
    ensureSignals();
  }
}
