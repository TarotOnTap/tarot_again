part of 'layout_bloc.dart';

@Freezed(copyWith: false)
sealed class LayoutEvent with _$LayoutEvent implements BlocWidgetEvent {
  const factory LayoutEvent.starting() = Starting;

  const factory LayoutEvent.setLayoutNames({
    required Iterable<String> newLayoutNames,
  }) = SetLayoutNames;

  const factory LayoutEvent.setNewLayout({required String newLayout}) =
      SetNewLayout;

  // factory LayoutEvent.setBlocsAndKeys({required Iterable<SlotWidgetBloc> blocs, required })

  const factory LayoutEvent.dealCards() = DealCards;

  // const factory LayoutEvent._alertDealtCards() = _AlertDealtCards;
  const factory LayoutEvent.slotWidgetReadyForCard({
    required GlobalKey<PositionSlotWidgetState> key,
  }) = SlotWidgetReadyForCard;

  const factory LayoutEvent.emptyLayout() = EmptyLayout;
}
