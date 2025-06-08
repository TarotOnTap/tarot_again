import 'package:tarot_again/util/util.dart';

/// [SessionManager] is the single source of truth for values about this session,
/// where a session is the total set of choices about a particular reading session -
/// what deck is used, whether reversals are allowed, what layout is chosen,
/// what cards are dealt into that layout, etc.
class SessionManager {
  SessionManager() {
    log("SessionManager.SessionManager");
  }

  void _emptySlots() {
    log("SessionManager._emptySlots");

    for (var key in ComputedsManager.slotKeys.value) {
      key.currentState?.setCard(TarotDeckCards.noneCard);
    }
  }

  Future<void> dealCards() async {
    // requires that slots have already been laid out
    log("SessionManager.dealCards");

    // final AsyncRandoms ar = sl<AsyncRandoms>();

    if (SignalsManager.tarotLayout.value is! NullLayout) {
      Logging.staticVerbose(
        "  tarotLayout.value is ${SignalsManager.tarotLayout.value}",
      );

      // Logging.staticVerbose(
      //   "  cardsDealt.value is ${SignalsManager.cardsDealt.value}",
      // );
      // if (!SignalsManager.cardsDealt.value) {
      await StandardDeckProvider.shuffleDeck();

      // final int howMany = SignalsManager.tarotLayout.value.numCards;
      // log("  howMany is $howMany");

      // after switching shuffledDeck on StandardDeckProvider to an asyncSignal,
      // we shouldn't ever have an empty deck. Instead, the deck is initialized
      // in the loading state, to wait until after the command to shuffle the deck has
      // been given. This way, we're never trying to deal from a deck that hasn't been
      // shuffled.

      if (SignalsManager.shuffledDeck.value.isNotEmpty) {
        Logging.staticVerbose("  shuffledDeck.isNotEmpty");

        for (var (index, key) in ComputedsManager.slotKeys.value.indexed) {
          key.currentState?.setCard(SignalsManager.shuffledDeck.value[index]);
        }
        // final IList<TarotDeckCards> cards = SignalsManager.shuffledDeck.value
        //     .take(howMany)
        //     .toIList();

        // final Iterable<bool> reversals = await [
        //   for (var _ in howMany.range()) ar.getNextBool(),
        // ].wait;

        // final cardInfos = cards.zip(reversals).toIList();
        //
        // for (var (index, slotSignal)
        //     in ComputedsManager.cardSlots.value.indexed) {
        //   final slot = slotSignal.value;
        //   final cardInfo = cardInfos[index];
        //   final card = cardInfo.$1;
        //   final reversal = cardInfo.$2;
        //
        //   final TCModelAssets? assets = await sl<AssetManager>()
        //       .loadAssetsForCard(card);
        //
        //   slotSignal.value = slot.copyWith(
        //     faceUp: false,
        //     reversed: reversal,
        //     deckCard: card,
        //     assets: assets,
        //   );
      }
    }

    // Logging.staticVerbose("  setting cardsDealt.value to true");
    // SignalsManager.cardsDealt.value = true;
  }

  // }

  void changeDeckName(StandardTarotDecksEnum newName) =>
      SignalsManager.deckName.value = newName;

  void changeDeckType(DeckTypesEnum newType) =>
      SignalsManager.deckType.value = newType;

  void changeCardBacks() {}

  void selectLayout() {}

  void turnAllCardsFaceUp() => SignalsManager.allCardsFaceUp.value = true;

  void turnAllCardsFaceDown() => SignalsManager.allCardsFaceUp.value = false;

  void flipAllCardsFace() => SignalsManager.allCardsFaceUp.value =
      !SignalsManager.allCardsFaceUp.value;

  void allowReversals() => SignalsManager.reversalsAllowed.value = true;

  void disallowReversals() => SignalsManager.reversalsAllowed.value = false;

  // bool _isDealt(SlotSignal slot) =>
  //     slot.value.deckCard != TarotDeckCards.noneCard;
  //
  // void setCardFaceUp(SlotSignal slot) {
  //   if (_isDealt(slot)) {
  //     slot.value = slot.value.copyWith(faceUp: true);
  //   }
  // }

  // void setCardFaceDown(SlotSignal slot) {
  //   if (_isDealt(slot)) {
  //     slot.value = slot.value.copyWith(faceUp: false);
  //   }
  // }
  //
  // void setCardFlipFace(SlotSignal slot) {
  //   if (_isDealt(slot)) {
  //     slot.value = slot.value.copyWith(faceUp: !slot.value.faceUp);
  //   }
  // }

  void freshSpread() {
    _emptySlots();
    dealCards();
  }
}
