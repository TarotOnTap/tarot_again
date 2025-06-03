import 'package:tarot_again/util/util.dart';

/// [SessionManager] is the single source of truth for values about this session,
/// where a session is the total set of choices about a particular reading session -
/// what deck is used, whether reversals are allowed, what layout is chosen,
/// what cards are dealt into that layout, etc.
class SessionManager {
  SessionManager() {
    log("SessionManager.SessionManager");
    // this happens when the value of deckType, or the value of tarotLayout, changes.
    // We don't actually care about the
    // new value, we just need to reset the dealtCards list when these change.
    // so that we're not trying to hold on to cards that are no longer valid.
    // effect(() => deckType.value.also((_) => _emptySlots()));

    // effect(() => untracked(() => tarotLayout.value.also((_) => _emptySlots())));
  }

  void _emptySlots() {
    untracked(
      () => batch(() {
        SignalsManager.cardsDealt.value = false;

        for (var (slot) in ComputedsManager.cardSlots.value) {
          slot.deckCard.value = null;
          slot.assets.value = null;

          slot.faceUp.value = false;
          slot.reversed.value = false;

          // slotName stays just as it is.
        }

        SignalsManager.allCardsFaceUp.value = false;
      }),
    );
  }

  Future<void> dealCards() async {
    // requires that slots have already been laid out
    log("SessionManager.dealCards");

    final AsyncRandoms ar = sl<AsyncRandoms>();

    if (SignalsManager.tarotLayout.value is! NullLayout) {
      Logging.staticVerbose(
        "  tarotLayout.value is ${SignalsManager.tarotLayout.value}",
      );

      Logging.staticVerbose(
        "  cardsDealt.value is ${SignalsManager.cardsDealt.value}",
      );
      if (!SignalsManager.cardsDealt.value) {
        await StandardDeckProvider.shuffleDeck();

        final int howMany = SignalsManager.tarotLayout.value.numCards;
        log("  howMany is $howMany");

        // after switching shuffledDeck on StandardDeckProvider to an asyncSignal,
        // we shouldn't ever have an empty deck. Instead, the deck is initialized
        // in the loading state, to wait until after the command to shuffle the deck has
        // been given. This way, we're never trying to deal from a deck that hasn't been
        // shuffled.

        if (SignalsManager.shuffledDeck.value.isNotEmpty) {
          Logging.staticVerbose("  shuffledDeck.isNotEmpty");
          final Iterable<TarotDeckCards> cards = SignalsManager
              .shuffledDeck
              .value
              .take(howMany);

          final Iterable<bool> reversals = await [
            for (var _ in howMany.range()) ar.getNextBool(),
          ].wait;

          for (var (
                int index,
                [card as TarotDeckCards, slot as SlotState, reversal as bool],
              )
              in zipIt([
                cards,
                ComputedsManager.cardSlots.value as Iterable<SlotState>,
                reversals,
              ]).indexed) {
            Logging.staticVerbose(
              "  index $index; setting signal.value to SlotStateDealt",
            );

            slot.faceUp.value = false;
            slot.reversed.value = reversal;
            slot.deckCard.value = card;
            AssetRepository.loadAssetsForSlot(slot: slot);
          }

          Logging.staticVerbose("  calling _loadAssets for each card");
          for (var slotState in ComputedsManager.cardSlots.value) {
            Logging.staticVerbose(
              "  before loadAssets: slotState is $slotState",
            );
            await AssetRepository.loadAssetsForSlot(slot: slotState);
            Logging.staticVerbose(
              "  after loadAssets: slotState is $slotState",
            );
          }

          Logging.staticVerbose("  setting cardsDealt.value to true");
          SignalsManager.cardsDealt.value = true;
        }
      }
    }
  }

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

  bool _isDealt(SlotState slot) => slot.deckCard.value != null;

  void setCardFaceUp(SlotState slot) {
    if (_isDealt(slot)) {
      slot.faceUp.value = true;
    }
  }

  void setCardFaceDown(SlotState slot) {
    if (_isDealt(slot)) {
      slot.faceUp.value = false;
    }
  }

  void setCardFlipFace(SlotState slot) {
    if (_isDealt(slot)) {
      slot.faceUp.value = !slot.faceUp.value;
    }
  }

  void freshSpread() {
    _emptySlots();
    dealCards();
  }
}
