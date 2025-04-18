part of 'layout_bloc.dart';

@freezed
sealed class LayoutEvent with _$LayoutEvent {
  const factory LayoutEvent.starting() = Starting;

  factory LayoutEvent.setLayoutNames({
    required Iterable<String> newLayoutNames,
  }) = SetLayoutNames;

  factory LayoutEvent.setNewLayout({required String newLayout}) = SetNewLayout;

  factory LayoutEvent.emptyLayout() = EmptyLayout;
}
