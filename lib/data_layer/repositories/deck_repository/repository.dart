import 'package:tarot_again/util/util.dart';
import 'package:tarot_again/data_layer/data_layer.dart';

import 'asset_card.dart';

class DeckRepository {
  late AsyncRandoms randomsProvider;
  late StandardDeckProvider standardDeckProvider;

  late AssetProvider assetProvider;

  final String deckName;

  DeckRepository({required Object bloc, required this.deckName}) {
    randomsProvider = di<AsyncRandoms>();
    standardDeckProvider = di<StandardDeckProvider>();
    assetProvider = di<AssetProvider>();
  }

  Future<void> shuffleDeck() async {
    await standardDeckProvider.shuffleDeck();

    // TODO: bloc.add(DeckShuffled());
  }

  Future dealNextCard() async {
    // First, we get the next card from the standardDeckProvider.
    // if that card is empty, we let the provider know and return.
    // next, we convert the TCModel to an AssetCard, loading the associated assets into the
    // given card.
    // Lastly, we turn that into a dealt card by assigning reversal if appropriate.

    TCModel? nextCard = standardDeckProvider.getNextCard();

    if (nextCard == null) {
      // note, at this point we might like to get back to our bloc with the information
      // that the deck is empty; this gives an opportunity to ask the user if they want to
      //
      // TODO: bloc.add(DeckEmpty());
      // after this, the bloc will signal us to shuffle the deck (presumably) and
      // then retry dealNextCard - or whatever.
    } else {
      AssetCard assetCard = AssetCard(card: nextCard, deckName: deckName);

      final Iterable<String?> keys = assetCard.assetMap.keys.map(
              (String key) => assetCard.assetMap[key]).nonNulls;

      // TODO: if (bloc.state.reversalsAllowed) {
      //   bloc.send(DealtCard(assetCard, await randomsProvider.getNextBool()));
      // }
      //
    }
  }


}