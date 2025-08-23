import 'package:tarot_again/util/util.dart';

// @immutable
// class TarotLayoutInfo {
//   final String name;
//   final String basePath;
//   final String displayName;
//
//   final String layoutJson;
//   final String layoutDescription;
//
//   final TarotLayout associatedLayout;
//
//   const TarotLayoutInfo({
//     this.name = "",
//     this.basePath = "",
//     this.displayName = "",
//     this.layoutJson = "",
//     this.layoutDescription = "",
//     this.associatedLayout = const TarotLayout.nullLayout(),
//   });
// }

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

  static final Signal<IMap<String, TarotLayoutInfo>> tarotLayoutInfos =
      signal<IMap<String, TarotLayoutInfo>>(
        const IMap<String, TarotLayoutInfo>.empty(),
      );

  // static final Signal<IMap<String, String>> tarotLayoutNamesPath =
  //     signal<IMap<String, String>>(
  //       const IMap<String, String>.empty(),
  //       debugLabel: "tarotLayoutNamesPath",
  //     );
  //
  static final Signal<IMap<String, TarotLayout>> tarotLayoutsByName =
      signal<IMap<String, TarotLayout>>(
        const IMap<String, TarotLayout>.empty(),
        debugLabel: "tarotLayoutsByName",
      );

  static void ensureSignals() {
    final toInitialize = <ReadonlySignal>[
      allAssetPaths,
      allCardsFaceUp,
      cardBackStyle,
      // cardsDealt,
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
