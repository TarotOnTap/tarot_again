import 'package:tarot_again/util/util.dart';

import 'hivez_persisted_signal.dart';

@singleton
class SignalsManager {
  static final Signal<Iterable<String>> allAssetPaths =
      signal<Iterable<String>>(
        [],
        options: SignalOptions(name: "allAssetPaths"),
      );

  static final Signal<bool> allCardsFaceUp = signal<bool>(
    false,
    options: SignalOptions(name: "allCardsFaceUp"),
  );

  static final cardBackStyle = hivezPersistedSignal<String>(
    key: "cardBackStyle",
    initialValue: "animated_solid_color",
    options: SignalOptions(name: "cardBackStyle"),
  );

  static final deckName = hivezPersistedSignal<StandardTarotDecks>(
    key: "deckName",
    initialValue: StandardTarotDecks.rws,
    options: SignalOptions(name: "deckName"),
  );

  static final HivezPersistedSignal<DeckTypesEnum> deckType =
      hivezPersistedSignal<DeckTypesEnum>(
        key: deckType,
        initialValue: DeckTypesEnum.standardTarot,
        options: SignalOptions(name: "deckType"),
      );

  static final HivezPersistedSignal<RandomGenerators> currentRandomGenerator =
      hivezPersistedSignal<RandomGenerators>(
        key: "currentRandomGenerator",
        initialValue: RandomGenerators.none,
        options: SignalOptions(name: "currentRandomGenerator"),
      );

  static final HivezPersistedSignal<IRandomsProvider> currentRandomProvider =
      hivezPersistedSignal<IRandomsProvider>(
        key: "currentRandomsProvider",
        initialValue: SecureRandom(),
        options: SignalOptions(name: "currentProvider"),
      );

  // When this is true,
  // dealing out tarot cards will display cards as upright or reversed; setting
  // it false will deal out upright cards only.
  static final HivezPersistedSignal<bool> reversalsAllowed =
      hivezPersistedSignal<bool>(
        key: "reversalsAllowed",
        initialValue: true,
        options: SignalOptions(name: "reversalsAllowed"),
      );

  static final Signal<IList<TarotDeckCards>> shuffledDeck =
      signal<IList<TarotDeckCards>>(
        const IList<TarotDeckCards>.empty(),
        options: SignalOptions(name: "shuffledDeck"),
      );

  static final HivezPersistedSignal<TarotLayout> tarotLayout =
      hivezPersistedSignal<TarotLayout>(
        key: "tarotLayout",
        initialValue: TarotLayout.nullLayout(),
        options: SignalOptions(name: "tarotLayout"),
      );

  static final Signal<IMap<String, TarotLayout>> tarotLayouts =
      signal<IMap<String, TarotLayout>>(
        const IMap<String, TarotLayout>.empty(),
      );

  static final Signal<IMap<String, TarotLayout>> tarotLayoutsByName =
      signal<IMap<String, TarotLayout>>(
        const IMap<String, TarotLayout>.empty(),
        options: SignalOptions(name: "tarotLayoutsByName"),
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
