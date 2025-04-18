part of 'layout_bloc.dart';

@freezed
sealed class LayoutState with _$LayoutState {
  const factory LayoutState.layoutInitial({
    @Default(<String>[]) Iterable<String> layoutNames,
    @Default("Empty Layout") String currentLayoutName,
    @Default(TarotLayout.nullLayout()) TarotLayout currentLayout,
  }) = LayoutInitial;

  // const factory LayoutState.changeLayoutState({
  //   @Default(<String>[]) Iterable<String> layoutNames,
  //   @Default("Empty Layout") String currentLayoutName,
  //   @Default(TarotLayout.nullLayout()) TarotLayout currentLayout,
  // }) = ChangeLayoutState;

  factory LayoutState.layoutStateReadyToDeal({
    required Iterable<String> layoutNames,
    required String currentLayoutName,
    required TarotLayout currentLayout,
  }) = LayoutStateReadyToDeal;

  factory LayoutState.layoutStateDealt({
    required Iterable<String> layoutNames,
    required String currentLayoutName,
    required TarotLayout currentLayout,
  }) = LayoutStateDealt;

  factory LayoutState.fromJson(Map<String, dynamic> json) =>
      _$LayoutStateFromJson(json);
}
