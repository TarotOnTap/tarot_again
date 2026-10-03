import 'package:tarot_again/util/util.dart';

/// [SessionManager] is the single source of truth for values about this session,
/// where a session is the total set of choices about a particular reading session -
/// what deck is used, whether reversals are allowed, what layout is chosen,
/// what cards are dealt into that layout, etc.
@singleton
class SessionManager(
  final SignalsManager signalsManager,
  final ComputedsManager computedsManager,
) with Logging {
  void _emptySlots() {
    verbose("SessionManager()._emptySlots");

    for (var key in computedsManager.slotKeys.value) {
      key.currentState?.setCard(TarotDeckCards.noneCard);
    }
  }

  void dealCards() {
    // requires that slots have already been laid out
    verbose("SessionManager().dealCards");

    if (signalsManager.tarotLayout.value is! NullLayout) {
      verbose("  tarotLayout.value is ${signalsManager.tarotLayout.value}");

      if (signalsManager.tarotLayout.value is SimpleGrid) {
        StandardDeckProvider.unShuffleDeck();
      } else {
        StandardDeckProvider.shuffleDeck();
      }

      // after switching shuffledDeck on StandardDeckProvider to an asyncSignal,
      // we shouldn't ever have an empty deck. Instead, the deck is initialized
      // in the loading state, to wait until after the command to shuffle the deck has
      // been given. This way, we're never trying to deal from a deck that hasn't been
      // shuffled.

      final sD = signalsManager.shuffledDeck.value;

      for (var (index, key) in computedsManager.slotKeys.value.indexed) {
        key.currentState?.setCard(sD[index]);
      }
    }
  }

  void changeDeckName(StandardTarotDecks newName) =>
      signalsManager.deckName.value = newName;

  void changeDeckType(DeckTypesEnum newType) =>
      signalsManager.deckType.value = newType;

  void changeCardBacks() {}

  void selectLayout() {}

  void turnAllCardsFaceUp() => signalsManager.allCardsFaceUp.value = true;

  void turnAllCardsFaceDown() => signalsManager.allCardsFaceUp.value = false;

  void flipAllCardsFace() => signalsManager.allCardsFaceUp.value =
      !signalsManager.allCardsFaceUp.value;

  void allowReversals() => signalsManager.reversalsAllowed.value = true;

  void disallowReversals() => signalsManager.reversalsAllowed.value = false;

  void freshSpread() {
    _emptySlots();
    dealCards();
  }
}
