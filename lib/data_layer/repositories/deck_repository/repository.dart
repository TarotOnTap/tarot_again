// import 'package:signals/signals.dart';
// import 'package:tarot_again/data_layer/data_layer.dart';
// import 'package:tarot_again/managers/session_manager/session_manager.dart';
// import 'package:tarot_again/util/util.dart';
//
// mixin DeckManager on SessionManager {
//   TarotLayout get tarotLayout;
//
//   // this peculiar structure has two jobs:
//   // send a signal when the entire list of dealt cards changes, and
//   // allow each individual card to signal when it changes, without having
//   // to signal that the whole list has changed.
//   final Signal<IList<Signal<DealtCard>>> dealtCards = signal(
//     const IList<Signal<DealtCard>>.empty(),
//   );
//
//   Future<void> _dealCards() async {
//     final sd = sl<StandardDeckProvider>();
//     final ar = sl<AsyncRandoms>();
//
//     final IList<TarotDeckCards> shuffledDeck = await sd.shuffledDeck.future;
//
//     final int howMany = tarotLayout.value.howMany;
//
//     // after switching shuffledDeck on StandardDeckProvider to an asyncSignal,
//     // we shouldn't ever have an empty deck. Instead, the deck is initialized
//     // in the loading state, to wait until after the command to shuffle the deck has
//     // been given. This way, we're never trying to deal from a deck that hasn't been
//     // shuffled.
//     if (shuffledDeck.isNotEmpty) {
//       final initial = shuffledDeck.take(howMany);
//       final reversals = await [
//         for (var i in howMany.range()) ar.getNextBool(),
//       ].wait;
//
//       dealtCards.value = [
//         for (var (c, r) in initial.toIList().zip(reversals))
//           signal(DeckCard(tcCard: c, reversed: r)),
//       ].toIList();
//     }
//   }
//
//   void emptyDealtCards() =>
//       dealtCards.value = const IList<Signal<DealtCard>>.empty();
//
//   void dealCards({required int howMany}) => unawaited(_dealCards());
//
//   void shuffleDeck() => sl<StandardDeckProvider>().shuffleDeck();
// }
