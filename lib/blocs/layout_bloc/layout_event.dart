part of 'layout_bloc.dart';

@Freezed(copyWith: false)
sealed class LayoutEvent with _$LayoutEvent implements BlocWidgetEvent {
  const factory LayoutEvent.starting() = LayoutStarting;

  //
  // const factory LayoutEvent.setLayoutNames({
  //   required Iterable<String> newLayoutNames,
  // }) = SetLayoutNames;

  const factory LayoutEvent.setNewLayout({required String newLayout}) =
      SetNewLayout;

  const factory LayoutEvent.dealCards() = DealCards;

  const factory LayoutEvent.emptyLayout() = EmptyLayout;
}
