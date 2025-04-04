import 'package:tarot_again/blocs/blocs.dart';
import 'package:tarot_again/data_layer/data_layer.dart';
import 'package:tarot_again/util/util.dart';

import 'asset_card.dart';

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

  // Future<DealtCard?> dealNextCardTo() async {
  //   // we're going to create a new bloc, and then set a bunch of handlers to retrieve
  //   // assets and stuff for it. Finally we return the newly created bloc, or null
  //   // if eg the deck is empty
  //   DealtCard? returnCard;
  //
  //   final TCModel? nextCard = await standardDeckProvider.getNextCard();
  //
  //   if (nextCard != null) {
  //     final bool reversed = await randomsProvider.getNextBool();
  //   } else {}
  //
  //   return returnCard;
  // }

  Future<DealtCard> dealNextCard() async {
    // First, we get the next card from the standardDeckProvider.
    // if that card is empty, we let the provider know and return.
    // next, we convert the TCModel to an AssetCard, loading the associated assets into the
    // given card.
    // Lastly, we turn that into a dealt card by assigning reversal if appropriate.

    TCModel? nextCard = await standardDeckProvider.currentShuffle?.next;
    DealtCard returnCard = DeckEmpty();

    if (nextCard != null) {
      AssetPathMap paths = assetPathGenerator(nextCard.assetName);

      // bloc.add(CardWidgetSetCardEvent(nextCard));
      //
      // bool reversed = await randomsProvider.getNextBool();
      //
      // bloc.add(CardWidgetSetReverseEvent(reverse: reversed));
      //
      // final AssetPathsCard assetCard = AssetPathsCard(
      //   card: nextCard,
      //   deckName: deckName,
      // );

      final LoadedAssetsMap loadedAssets = await assetProvider
          .loadAssetsByFileExtension(assetCard.assetMap);

      // bloc.add()
    }

    return returnCard;
  }
}