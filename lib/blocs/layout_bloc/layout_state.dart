part of 'layout_bloc.dart';

@freezed
sealed class LayoutState with _$LayoutState {
  const factory LayoutState.initial() = _Initial;

  const factory LayoutState.changeLayoutState({
    required String selectedLayout,
  }) = ChangeLayoutState;

  factory LayoutState.layoutStateReadyToDeal({required String selectedLayout}) =
      LayoutStateReadyToDeal;

  factory LayoutState.layoutStateDealt({required String selectedLayout}) =
      LayoutStateDealt;

  factory LayoutState.fromJson(Map<String, dynamic> json) =>
      _$LayoutStateFromJson(json);
}
