import 'package:tarot_again/util/util.dart';

// import 'hivez_persisted_signal.dart';

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
    "cardBackStyle",
    "animated_solid_color",
  );

  static final deckName = hivezPersistedSignal<StandardTarotDecks>(
    "deckName",
    StandardTarotDecks.rws,
  );

  static final HivezPersistedSignal<DeckTypesEnum> deckType =
      hivezPersistedSignal<DeckTypesEnum>(
        "deckType",
        DeckTypesEnum.standardTarot,
      );

  static final HivezPersistedSignal<RandomGenerators> currentRandomGenerator =
      hivezPersistedSignal<RandomGenerators>(
        "currentRandomGenerator",
        RandomGenerators.none,
      );

  static final HivezPersistedSignal<IRandomsProvider> currentRandomProvider =
      hivezPersistedSignal<IRandomsProvider>(
        "currentRandomsProvider",
        SecureRandom(),
      );

  // When this is true,
  // dealing out tarot cards will display cards as upright or reversed; setting
  // it false will deal out upright cards only.
  static final HivezPersistedSignal<bool> reversalsAllowed =
      hivezPersistedSignal<bool>("reversalsAllowed", true);

  static final Signal<IList<TarotDeckCards>> shuffledDeck =
      signal<IList<TarotDeckCards>>(
        const IList<TarotDeckCards>.empty(),
        options: SignalOptions(name: "shuffledDeck"),
      );

  static final HivezPersistedSignal<TarotLayout> tarotLayout =
      hivezPersistedSignal<TarotLayout>(
        "tarotLayout",
        TarotLayout.nullLayout(),
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

  static final HivezPersistedSignal<String> tarotLayoutsHash =
      hivezPersistedSignal<String>("tarotLayoutsHash", "");

  static final HivezPersistedMapSignal<String, TarotLayout> existingLayoutsBox =
      hivezPersistedMapSignal<String, TarotLayout>(
        "existingLayoutsBox",
        <String, TarotLayout>{},
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

  SignalsManager(this.hiveService) {
    ensureSignals();
  }

  final HiveService hiveService;
}
