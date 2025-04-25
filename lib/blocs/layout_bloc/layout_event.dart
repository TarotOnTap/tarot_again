part of 'layout_bloc.dart';

@freezed
sealed class LayoutEvent with _$LayoutEvent implements BlocWidgetEvent {
  const factory LayoutEvent.starting() = LayoutStarting;

  //
  // const factory LayoutEvent.layoutNamesReady({
  //   required Iterable<String> layoutNames,
  // }) = LayoutNamesReady;

  const factory LayoutEvent.setNewLayout({required String newLayout}) =
      SetNewLayout;

  const factory LayoutEvent.dealCards() = DealCards;

  const factory LayoutEvent.emptyLayout() = EmptyLayout;

  const factory LayoutEvent.slotWidgetFlipFaceEvent({required int index}) =
      SlotWidgetFlipFaceEvent;

  const factory LayoutEvent.slotWidgetFaceUpEvent({required int index}) =
      SlotWidgetFaceUpEvent;

  const factory LayoutEvent.slotWidgetFaceDownEvent({required int index}) =
      SlotWidgetFaceDownEvent;

  // const factory LayoutEvent.addSlotBloc({required SlotWidgetBloc newBloc}) =
  //     AddSlotBloc;
}
