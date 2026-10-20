import 'package:tarot_again/util/util.dart';
import 'package:tarot_again/util/flutter_util.dart' show TopLevelDisplay;

import 'package:tarot_again/ui_layer/ui_layer.dart';

// import 'hivez_persisted_signal.dart';

@singleton
class SignalsManager(final HiveService hiveService) with Logging {
  this : assert(true) {
    ensureSignals();
  }

  final Signal<Iterable<String>> allAssetPaths = signal<Iterable<String>>(
    [],
    options: SignalOptions(name: "allAssetPaths"),
  );

  final Signal<bool> allCardsFaceUp = signal<bool>(
    false,
    options: SignalOptions(name: "allCardsFaceUp"),
  );

  final cardBackStyle = hivezPersistedSignal<String>(
    "cardBackStyle",
    "animated_solid_color",
  );

  final cardWidth = Signal<double>(
    100.0,
    options: SignalOptions(name: "cardWidth"),
  );

  final cardHeight = Signal<double>(
    150.0,
    options: SignalOptions(name: "cardHeight"),
  );

  final deckName = hivezPersistedSignal<StandardTarotDecks>(
    "deckName",
    StandardTarotDecks.rws,
  );

  final HivezPersistedSignal<DeckTypesEnum> deckType =
      hivezPersistedSignal<DeckTypesEnum>(
        "deckType",
        DeckTypesEnum.standardTarot,
      );

  final HivezPersistedSignal<RandomGenerators> currentRandomGenerator =
      hivezPersistedSignal<RandomGenerators>(
        "currentRandomGenerator",
        RandomGenerators.none,
      );

  final HivezPersistedSignal<IRandomsProvider> currentRandomProvider =
      hivezPersistedSignal<IRandomsProvider>(
        "currentRandomsProvider",
        SecureRandom(),
      );

  // When this is true,
  // dealing out tarot cards will display cards as upright or reversed; setting
  // it false will deal out upright cards only.
  final HivezPersistedSignal<bool> reversalsAllowed =
      hivezPersistedSignal<bool>("reversalsAllowed", true);

  final Signal<IList<TarotDeckCards>> shuffledDeck =
      signal<IList<TarotDeckCards>>(
        const IList<TarotDeckCards>.empty(),
        options: SignalOptions(name: "shuffledDeck"),
      );

  final HivezPersistedSignal<TarotLayout> tarotLayout =
      hivezPersistedSignal<TarotLayout>(
        "tarotLayout",
        TarotLayout.nullLayout(),
      );

  final Signal<IList<TarotLayout>> tarotLayouts = signal<IList<TarotLayout>>(
    const IList<TarotLayout>.empty(),
  );

  final Signal<IMap<String, TarotLayout>> tarotLayoutsByName =
      signal<IMap<String, TarotLayout>>(
        const IMap<String, TarotLayout>.empty(),
        options: SignalOptions(name: "tarotLayoutsByName"),
      );

  final HivezPersistedSignal<String> tarotLayoutsHash =
      hivezPersistedSignal<String>("tarotLayoutsHash", "");

  final HivezPersistedSignal<TopLevelDisplay> topLevelDisplay =
      hivezPersistedSignal<TopLevelDisplay>(
        "TopLevelDisplay",
        TopLevelDisplay.cardStage,
      );

  final HivezPersistedMapSignal<String, TarotLayout> existingLayoutsBox =
      hivezPersistedMapSignal<String, TarotLayout>(
        "existingLayoutsBox",
        <String, TarotLayout>{},
      );

  final HivezPersistedSignal<DestinationPaths> scaffoldChildWidget =
      hivezPersistedSignal<DestinationPaths>(
        "ScaffoldChildWidget",
        DestinationPaths.cardsStageLayout,
      );

  late final EffectCleanup allAssetPathsEffectDisposer;

  void ensureSignals() {
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
}
