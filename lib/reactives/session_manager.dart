import 'package:tarot_again/util/util.dart';

/// [SessionManager] is the single source of truth for values about this session,
/// where a session is the total set of choices about a particular reading session -
/// what deck is used, whether reversals are allowed, what layout is chosen,
/// what cards are dealt into that layout, etc.
class SessionManager with Logging {
  SessionManager() {
    verbose("SessionManager.SessionManager");
    // this happens when the value of deckType, or the value of tarotLayout, changes.
    // We don't actually care about the
    // new value, we just need to reset the dealtCards list when these change.
    // so that we're not trying to hold on to cards that are no longer valid.
    // effect(() => deckType.value.also((_) => _emptySlots()));

    // effect(() => untracked(() => tarotLayout.value.also((_) => _emptySlots())));
  }

  void _emptySlots() {
    untracked(() {
      sl<Reactives>().cardsDealt.value = false;

      for (var (slot) in sl<Reactives>().cardSlots.value) {
        slot.deckCard.value = null;
        slot.assets.value = null;

        slot.faceUp.value = false;
        slot.reversed.value = false;

        // slotName stays just as it is.
      }

      sl<Reactives>().allCardsFaceUp.value = false;
    });
  }

  static Future<void> dealCards() async {
    // requires that slots have already been laid out
    Logging.staticVerbose("SessionManager._dealCards");

    final Reactives reactives = sl<Reactives>();

    final AsyncRandoms ar = sl<AsyncRandoms>();
    // final AssetRepository assetRepo = sl<AssetRepository>();

    if (tarotLayout.value is! NullLayout) {
      Logging.staticVerbose("  tarotLayout.value is ${tarotLayout.value}");

      Logging.staticVerbose(
        "  cardsDealt.value is ${reactives.cardsDealt.value}",
      );
      if (!reactives.cardsDealt.value) {
        await StandardDeckProvider.shuffleDeck();

        final int howMany = tarotLayout.value.numCards;
        Logging.staticVerbose("  howMany is $howMany");

        // after switching shuffledDeck on StandardDeckProvider to an asyncSignal,
        // we shouldn't ever have an empty deck. Instead, the deck is initialized
        // in the loading state, to wait until after the command to shuffle the deck has
        // been given. This way, we're never trying to deal from a deck that hasn't been
        // shuffled.

        if (reactives.shuffledDeck.value.isNotEmpty) {
          Logging.staticVerbose("  shuffledDeck.isNotEmpty");
          final Iterable<TarotDeckCards> cards = reactives.shuffledDeck.value
              .take(howMany);
          // final Iterable<SlotState> slots = ;
          final Iterable<bool> reversals = await [
            for (var _ in howMany.range()) ar.getNextBool(),
          ].wait;

          for (var (
                int index,
                [card as TarotDeckCards, slot as SlotState, reversal as bool],
              )
              in zipIt([
                cards,
                reactives.cardSlots.value as Iterable<SlotState>,
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
          for (var slotState in reactives.cardSlots.value) {
            Logging.staticVerbose(
              "  before loadAssets: slotState is $slotState",
            );
            await AssetRepository.loadAssetsForSlot(slot: slotState);
            Logging.staticVerbose(
              "  after loadAssets: slotState is $slotState",
            );
          }

          // cardSlots.value.forEach(_loadAssets);

          Logging.staticVerbose("  setting cardsDealt.value to true");
          reactives.cardsDealt.value = true;
        }
      }
    }
  }

  void changeDeckName(StandardTarotDecksEnum newName) =>
      sl<Reactives>().deckName.value = newName;

  void changeDeckType(DeckTypesEnum newType) =>
      sl<Reactives>().deckType.value = newType;

  void changeCardBacks() {}

  void selectLayout() {}

  void turnAllCardsFaceUp() => sl<Reactives>().allCardsFaceUp.value = true;

  void turnAllCardsFaceDown() => sl<Reactives>().allCardsFaceUp.value = false;

  void flipAllCardsFace() => sl<Reactives>().allCardsFaceUp.value =
      !sl<Reactives>().allCardsFaceUp.value;

  void allowReversals() => sl<Reactives>().reversalsAllowed.value = true;

  void disallowReversals() => sl<Reactives>().reversalsAllowed.value = false;

  bool _isDealt(SlotState slot) => slot.deckCard.value != null;

  // Option<SlotState> _getSlotByIndex(int index) =>
  //     sl<Reactives>().cardSlots.value.isNotEmpty
  //     ? Option<SlotState>.of(sl<Reactives>().cardSlots.value[index])
  //     : Option<SlotState>.none();
  //
  // Option<SlotState> _getDealtByIndex(int index) =>
  //     sl<Reactives>().cardSlots.value.isNotEmpty
  //     ? switch (_isDealt(sl<Reactives>().cardSlots.value[index])) {
  //         true => Option<SlotState>.of(sl<Reactives>().cardSlots.value[index]),
  //         _ => Option<SlotState>.none(),
  //       }
  //     : Option<SlotState>.none();

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
