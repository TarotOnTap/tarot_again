import 'package:tarot_again/util/util.dart';

part 'slot_state.freezed.dart';
part 'slot_state.g.dart';

@freezed
abstract class SlotState with _$SlotState {
  const SlotState._();

  const factory SlotState({
    @Default(TarotDeckCards.noneCard) TarotDeckCards deckCard,
    @Default(ShowingFaceEnum.showingFaceBack) ShowingFaceEnum showingFace,
    @Default(ReversalEnum.reversalUpright) ReversalEnum reversal,
    @JsonKey(includeFromJson: false, includeToJson: false)
    @Default(emptyTCModelAssets)
    TCModelAssets assets,
    required String slotName,
    required int slotIndex,
  }) = _SlotState;

  bool get isDealt => deckCard != TarotDeckCards.noneCard;

  factory SlotState.fromJson(Map<String, dynamic> json) =>
      _$SlotStateFromJson(json);
}
