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

  Future<DealtCard> _transformTCModelToDealtCard(TCModel card) async {
    final bool reversed = await sl<AsyncRandoms>().getNextBool();

    DealtModel model = DealtModel(assetName: card.assetName);

    return await model.transform(card: card, isReversed: reversed);
  }

  Stream<DealtCard> dealtCardStream() async* {
    // can't use Stream.map here because of async _transformTCModelToDealtCard
    await for (var card in sl<StandardDeckProvider>().currentShuffleStream) {
      yield await _transformTCModelToDealtCard(card);
    }
  }

  StreamQueue<DealtCard> get dealtCardQueue => StreamQueue(dealtCardStream());

  Future<DealtCard> dealNextCard() async {
    // First, we get the next card from the standardDeckProvider.
    // if that card is empty, we let the provider know and return.
    // next, we convert the TCModel to an AssetCard, loading the associated assets into the
    // given card.
    // Lastly, we turn that into a dealt card by assigning reversal if appropriate.

    TCModel? nextCard = await sl<StandardDeckProvider>().getNextCard();
    DealtCard returnCard = DealtCard.deckEmpty();

    if (nextCard != null) {
      returnCard = await _transformTCModelToDealtCard(nextCard);
    }

    return returnCard;
  }
}
