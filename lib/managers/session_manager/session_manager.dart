import 'package:tarot_again/util/util.dart';

import 'types.dart';

// class LoggingSignal<T> extends Signal<T> with TrackedSignalMixin<T>, Logging {
//   final String? name;
//
//   LoggingSignal(
//     super.value, {
//     this.name,
//     super.debugLabel,
//     super.autoDispose = false,
//   }) {
//     subscribe((v) => verbose("Signal $name changed from $previousValue to $v"));
//   }
// }
//
// LoggingSignal<T> loggingSignal<T>(
//   T value, {
//   String? name,
//   String? debugLabel,
//   bool autoDispose = false,
// }) => LoggingSignal<T>(
//   value,
//   name: name,
//   debugLabel: debugLabel,
//   autoDispose: autoDispose,
// );
//
// class LoggingComputed<T> extends Computed<T>
//     with TrackedSignalMixin<T>, Logging {
//   final String? name;
//
//   LoggingComputed(
//     super.fn, {
//     this.name,
//     super.debugLabel,
//     super.autoDispose = false,
//   }) {
//     subscribe(
//       (v) => verbose("Computed $name changed from $previousValue to $v"),
//     );
//   }
// }
//
// LoggingComputed<T> loggingComputed<T>(
//   T Function() fn, {
//   String? name,
//   String? debugLabel,
//   bool autoDispose = false,
// }) => LoggingComputed<T>(
//   fn,
//   name: name,
//   debugLabel: debugLabel,
//   autoDispose: autoDispose,
// );

/// [SessionManager] is the single source of truth for values about this session,
/// where a session is the total set of choices about a particular reading session -
/// what deck is used, whether reversals are allowed, what layout is chosen,
/// what cards are dealt into that layout, etc.
class SessionManager /* with DeckManager */ with Logging {
  final LoggingSignal<DeckTypesEnum> deckType = loggingSignal<DeckTypesEnum>(
    DeckTypesEnum.standardTarot,
    name: "deckType",
  );

  final LoggingSignal<IList<Signal<DealtCard>>> dealtCards = loggingSignal(
    const IList<Signal<DealtCard>>.empty(),
    name: "dealtCards",
  );

  final LoggingSignal<StandardTarotDecksEnum> deckName =
      loggingSignal<StandardTarotDecksEnum>(
        StandardTarotDecksEnum.rws,
        name: "deckName",
      );

  final LoggingSignal<String> cardBackStyle = loggingSignal<String>(
    "",
    name: "cardBackStyle",
  );

  final LoggingSignal<bool> allCardsFaceUp = loggingSignal<bool>(
    false,
    name: "allCardsFaceUp",
  );

  final LoggingSignal<bool> reversalsAllowed = loggingSignal<bool>(
    true,
    name: "reversalsAllowed",
  );

  // IList<Computed<DealtCard>> dealtCardSelectors =
  //     const IList<Computed<DealtCard>>.empty();

  final LoggingSignal<IList<bool>> faceUpCards = loggingSignal<IList<bool>>(
    const IList<bool>.empty(),
    name: "faceUpCards",
  );

  // final Signal<bool> newCardsDealt = signal<bool>(false);

  //
  // final Signal<TarotLayout> tarotLayout = signal<TarotLayout>(
  //   TarotLayout.nullLayout(),
  // );

  late final LoggingComputed<String> deckString;
  late final LoggingComputed<IMap<String, String>> tarotLayoutMap;

  LoggingComputed<IList<String>> get layoutNames => LayoutProvider.layoutNames;

  LoggingComputed<IList<String>> get layoutDisplayNames =>
      LayoutProvider.layoutDisplayNames;

  late final LoggingComputed<bool> assetsNeedReloading;
  late final LoggingComputed<IList<Signal<SlotState>>> slotStates;

  LoggingSignal<TarotLayout> get tarotLayout =>
      sl<LayoutRepository>().tarotLayout;

  SessionManager() {
    deckString = loggingComputed(
      () => "decks/${deckType.value.name}/${deckName.value.name}",
      name: "deckString",
    );
    //
    // layoutNames = sl<LayoutProvider>().layoutNames;
    // layoutDisplayNames = sl<LayoutProvider>().layoutDisplayNames;

    slotStates = loggingComputed(
      () => tarotLayout.value.let(
        (_) => [
          for (var i in tarotLayout.value.numCards.range())
            signal(SlotState.notDealt(slotIndex: i)),
        ].toIList(),
      ),
      name: "slotStates",
    );

    // this happens when the value of deckType, or the value of tarotLayout, changes.
    // We don't actually care about the
    // new value, we just need to reset the dealtCards list when these change.
    // so that we're not trying to hold on to cards that are no longer valid.
    effect(() => deckType.value.also((_) => _clearDeck()));

    effect(() => tarotLayout.value.also((_) => _clearDeck()));
  }

  void _clearDeck() {
    untracked(() {
      // slotStates.value = const IList<Signal<SlotState>>.empty();

      // dealtCardSelectors =
      //     const IList<Computed<DealtCard>>.empty(); // selectors is not a signal
      allCardsFaceUp.value = false;
    });
  }

  void _setDealtCardsAssets() {}

  // void shuffleDeck() => unawaited(sl<StandardDeckProvider>().shuffleDeck());

  void changeDeckName(StandardTarotDecksEnum newName) =>
      deckName.value = newName;

  void changeDeckType(DeckTypesEnum newType) => deckType.value = newType;

  void changeCardBacks() {}

  void selectLayout() {}

  void turnAllCardsFaceUp() => allCardsFaceUp.value = true;

  void turnAllCardsFaceDown() => allCardsFaceUp.value = false;

  void flipAllCardsFace() => allCardsFaceUp.value = !allCardsFaceUp.value;

  void allowReversals() => reversalsAllowed.value = true;

  void disallowReversals() => reversalsAllowed.value = false;

  void setCardFaceUp(int index) =>
      faceUpCards.value = faceUpCards.value.replace(index, true);

  void setCardFaceDown(int index) =>
      faceUpCards.value = faceUpCards.value.replace(index, false);

  void flipCardFace(int index) => faceUpCards.value = faceUpCards.value.replace(
    index,
    !faceUpCards.value[index],
  );

  Future<void> _dealCards() async {
    final sd = sl<StandardDeckProvider>();
    final ar = sl<AsyncRandoms>();

    if (tarotLayout.value is! NullLayout) {
      final IList<TarotDeckCards> shuffledDeck = await sd.shuffledDeck.future;

      final int howMany = tarotLayout.value.numCards;

      // after switching shuffledDeck on StandardDeckProvider to an asyncSignal,
      // we shouldn't ever have an empty deck. Instead, the deck is initialized
      // in the loading state, to wait until after the command to shuffle the deck has
      // been given. This way, we're never trying to deal from a deck that hasn't been
      // shuffled.
      if (shuffledDeck.isNotEmpty) {
        final initial = shuffledDeck.take(howMany);
        final reversals = await [
          for (var i in howMany.range()) ar.getNextBool(),
        ].wait;

        dealtCards.value = [
          for (var (c, r) in initial.toIList().zip(reversals))
            signal(DeckCard(tcCard: c, reversed: r)),
        ].toIList();
      }
    }
  }

  void emptyDealtCards() =>
      dealtCards.value = const IList<Signal<DealtCard>>.empty();

  void dealCards() => unawaited(_dealCards());

  void shuffleDeck() => sl<StandardDeckProvider>().shuffleDeck();
}
