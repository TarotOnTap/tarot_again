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

  static final Signal<StandardTarotDecksEnum> deckName =
      signal<StandardTarotDecksEnum>(
        StandardTarotDecksEnum.rws,
        debugLabel: "deckName",
      );

  static final Signal<DeckTypesEnum> deckType = signal<DeckTypesEnum>(
    DeckTypesEnum.standardTarot,
    debugLabel: "deckType",
  );

  static final Signal<RandomGenerators> currentRandomGenerator =
      signal<RandomGenerators>(
        RandomGenerators.none,
        debugLabel: "currentGenerator",
      );

  static final Signal<RandomsProvider> currentRandomProvider =
      signal<RandomsProvider>(SecureRandom(), debugLabel: "currentProvider");

  static final Signal<bool> reversalsAllowed = signal<bool>(
    true,
    debugLabel: "reversalsAllowed",
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
