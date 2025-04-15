export 'types.dart';

// This repository shuffles decks and deals cards.
// shuffling the deck is easy -RandomsProvider does that work.
// dealing a card:
// need to get a random TCModel (just get the next item off the shuffled deck),
// determine and load its assets (AssetProvider), and determine whether it
// is reversed or not (RandomsProvider again), and pass all that back to the bloc
// that requested it (bloc.add(DealtCard(our card type).

// Other features -
// the deck we're using can be changed on the fly.
// the *kind* of cards (playing cards, tarot cards, ?) can be changed on the fly,
// which influences the assets that get loaded for each card.
// the RandomsProvider we're using can be changed on the fly.
// those requests come not from the individual card blocs, but from the app-level
// bloc that coordinates all that stuff.
