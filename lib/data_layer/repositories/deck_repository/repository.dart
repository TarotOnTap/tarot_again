import 'package:tarot_again/data_layer/data_layer.dart';
import 'package:tarot_again/data_layer/repositories/types.dart';
import 'package:tarot_again/util/util.dart';

class DeckRepository extends SingletonRepository with Logging {
  String deckName;

  DeckRepository._({required this.deckName});

  factory DeckRepository({String? deckName}) {
    if (!sl.isRegistered<DeckRepository>()) {
      sl.registerSingleton<DeckRepository>(
        DeckRepository._(deckName: deckName ?? "RWS"),
      );
    }

    return sl<DeckRepository>();
  }

  Future<void> shuffleDeck() async {
    await sl<StandardDeckProvider>().shuffleDeck();
  }

  // Future<DealtCard> _transformTCModelToDealtCard(TCModel card) async {
  //   verbose("DeckRepository._transformTCModelToDealtCard");
  //   verbose("  card is $card");
  //
  //   final bool reversed = await sl<AsyncRandoms>().getNextBool();
  //
  //   return DeckCard(card, reversed);
  //
  //   DealtModel model = DealtModel(assetName: card.assetReference, card: card);
  //   verbose("  model is $model");
  //
  //   final temp = await model.transform(card: card, isReversed: reversed);
  //   verbose("  temp is $temp");
  //
  //   return temp;
  //
  //   // return await model.transform(card: card, isReversed: reversed);
  // }

  Stream<DealtCard> dealtCardStream() async* {
    // can't use Stream.map here because of async _transformTCModelToDealtCard
    await for (var card in sl<StandardDeckProvider>().currentShuffleStream) {
      final bool reversed = await sl<AsyncRandoms>().getNextBool();
      yield DeckCard(tcCard: card, reversed: reversed);
    }
  }

  StreamQueue<DealtCard> get dealtCardQueue => StreamQueue(dealtCardStream());

  Future<DealtCard> dealNextCard() async {
    // First, we get the next card from the standardDeckProvider.
    // if that card is empty, we let the provider know and return.
    // next, we convert the TCModel to an AssetCard, loading the associated assets into the
    // given card.
    // Lastly, we turn that into a dealt card by assigning reversal if appropriate.

    return (await sl<StandardDeckProvider>().getNextCard()).letWithElse((
      it,
    ) async {
      final bool reversed = await sl<AsyncRandoms>().getNextBool();
      return DeckCard(tcCard: it, reversed: reversed);
    }, orElse: DealtCard.deckEmpty());
    //
    // TCModel? nextCard = await sl<StandardDeckProvider>().getNextCard();
    // DealtCard returnCard = DealtCard.deckEmpty();
    //
    // if (nextCard != null) {
    //   final bool reversed = await sl<AsyncRandoms>().getNextBool();
    //   returnCard = DeckCard(tcCard: nextCard, reversed: reversed);
    // }
    //
    // return returnCard;
  }

  Future<void> loadCardAssets(
    TarotDeckCards card,
    void Function(TCModelAssets?) callback,
  ) async {
    await sl<AssetProvider>()
        .loadAssetsForCard(card)
        .then((TCModelAssets? assets) => callback(assets));
  }
}
