import 'package:tarot_again/util/util.dart';

part 'types.freezed.dart';

// @JsonEnum()
enum StandardTarotDecksEnum {
  rws(displayName: "RWS");

  const StandardTarotDecksEnum({required this.displayName});

  final String displayName;
}

// @JsonEnum()
enum DeckTypesEnum {
  standardTarot(displayName: "Standard Tarot"),
  standardPlayingCards(displayName: "Standard Playing Cards");

  const DeckTypesEnum({required this.displayName});

  final String displayName;
}

enum ShowingFaceEnum {
  front(displayName: "Front"),
  back(displayName: "Back");

  const ShowingFaceEnum({required this.displayName});

  final String displayName;
}

enum ReversalEnum {
  upright(displayName: "Upright"),
  reversed(displayName: "Reversed");

  const ReversalEnum({required this.displayName});

  final String displayName;
}

@freezed
abstract class SlotState with _$SlotState {
  const SlotState._();

  const factory SlotState({
    @Default(TarotDeckCards.noneCard) TarotDeckCards deckCard,
    @Default(ShowingFaceEnum.back) ShowingFaceEnum showingFace,
    @Default(ReversalEnum.upright) ReversalEnum reversal,
    @Default(null) TCModelAssets? assets,
    required String slotName,
    required int slotIndex,
  }) = _SlotState;

  bool get isDealt => deckCard != TarotDeckCards.noneCard;

  bool get hasAssets => assets != null;
}
