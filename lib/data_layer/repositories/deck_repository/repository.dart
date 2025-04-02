import 'package:tarot_again/util/util.dart';
import 'package:tarot_again/data_layer/data_layer.dart';
import 'package:tarot_again/blocs/blocs.dart';

import 'asset_card.dart';
import 'types.dart';

class DeckRepository {
  late AsyncRandoms randomsProvider;
  late StandardDeckProvider standardDeckProvider;

  late AssetProvider assetProvider;

  String deckName;

  DeckRepository({required this.deckName}) {
    randomsProvider = di<AsyncRandoms>();
    standardDeckProvider = di<StandardDeckProvider>();
    assetProvider = di<AssetProvider>();
  }

  Future<void> shuffleDeck() async {
    await standardDeckProvider.shuffleDeck();
  }

  void dealNextCard(CardWidgetBloc bloc) async {
    // First, we get the next card from the standardDeckProvider.
    // if that card is empty, we let the provider know and return.
    // next, we convert the TCModel to an AssetCard, loading the associated assets into the
    // given card.
    // Lastly, we turn that into a dealt card by assigning reversal if appropriate.

    final assetProvider = di<AssetProvider>();

    TCModel? nextCard = await standardDeckProvider.getNextCard();

    if (nextCard == null) {
      // note, at this point we might like to get back to our bloc with the information
      // that the deck is empty; this gives an opportunity to ask the user if they want to
      //
      // TODO: bloc.add(DeckEmpty());
      // after this, the bloc will signal us to shuffle the deck (presumably) and
      // then retry dealNextCard - or whatever.
    } else {
      final AssetPathsCard assetCard = AssetPathsCard(card: nextCard, deckName: deckName);

      final LoadedAssetsMap loadedAssets = await
        assetProvider.loadAssetsByFileExtension(assetCard.assetMap);

      DealtCard dc = DealtCard(card: assetCard, assets: loadedAssets, reversed: reversed);

      bloc.add()
    }
  }
}