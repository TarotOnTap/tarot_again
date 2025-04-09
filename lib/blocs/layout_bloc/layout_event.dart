part of 'layout_bloc.dart';

@freezed
sealed class LayoutEvent with _$LayoutEvent {
  const factory LayoutEvent.started() = _Started;

  factory LayoutEvent.setNewLayout({required TarotLayout newLayout}) =
      SetNewLayout;

  factory LayoutEvent.emptyLayout() = EmptyLayout;
}
