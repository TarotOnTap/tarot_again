part of 'slot_widget_bloc.dart';

@freezed
sealed class SlotWidgetState with _$SlotWidgetState {
  // Note to self - the DealtModel card is actually a property
  // of our bloc, rather than changeable state; it is set by the constructor
  // when the CardWidgetBloc is created.
  const factory SlotWidgetState.notDealt({
    required int slotIndex,
    required String slotName,
  }) = SlotWidgetStateNotDealt;

  const factory SlotWidgetState.dealt({
    required int slotIndex,
    required String slotName,
    required bool faceUp,
    required DealtCard card,
  }) = SlotWidgetStateDealt;
}
