import 'package:tarot_again/data_layer/data_layer.dart';
import 'package:tarot_again/util/util.dart';

class DeckRepository {
  late AsyncRandoms randomsProvider;
  late StandardDeckProvider standardDeckProvider;

  late AssetProvider assetProvider;

  String deckName;

  DeckRepository({required this.deckName}) {
    randomsProvider = sl<AsyncRandoms>();
    standardDeckProvider = sl<StandardDeckProvider>();
    assetProvider = sl<AssetProvider>();
  }

  Future<void> shuffleDeck() async {
    await standardDeckProvider.shuffleDeck();
  }

  Future<DealtCard> dealNextCard() async {
    // First, we get the next card from the standardDeckProvider.
    // if that card is empty, we let the provider know and return.
    // next, we convert the TCModel to an AssetCard, loading the associated assets into the
    // given card.
    // Lastly, we turn that into a dealt card by assigning reversal if appropriate.

    TCModel? nextCard = await standardDeckProvider.currentShuffle?.next;
    DealtCard returnCard = DealtCard.deckEmpty();

    if (nextCard != null) {
      // final AssetPathMap paths = assetPathGenerator(nextCard.assetName);
      final bool reversed = await di<AsyncRandoms>().getNextBool();

      DealtModel model = DealtModel(assetName: nextCard.assetName);

      returnCard = await model.transform(card: nextCard, reversed: reversed);
    }

    return returnCard;
  }
}
