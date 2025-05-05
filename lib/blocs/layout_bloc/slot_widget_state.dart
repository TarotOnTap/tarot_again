part of 'layout_bloc.dart';

@freezed
sealed class SlotWidgetState with _$SlotWidgetState {
  const factory SlotWidgetState.notDealt({
    required int slotIndex,
    @Default("") String slotName,
  }) = SlotWidgetStateNotDealt;

  const factory SlotWidgetState.dealt({
    required int slotIndex,
    @Default("") String slotName,
    required bool faceUp,
    required DealtCard card,
  }) = SlotWidgetStateDealt;

  factory SlotWidgetState.fromJson(Map<String, dynamic> json) =>
      _$SlotWidgetStateFromJson(json);
}
