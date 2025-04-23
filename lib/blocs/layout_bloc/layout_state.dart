part of 'layout_bloc.dart';

@freezed
sealed class LayoutState with _$LayoutState {
  const factory LayoutState({
    @Default(IList<String>.empty()) IList<String> layoutNames,
    @Default("Empty Layout") String currentLayoutName,
    @Default(TarotLayout.nullLayout()) TarotLayout currentLayout,
  }) = _LayoutState;

  factory LayoutState.fromJson(Map<String, dynamic> json) =>
      _$LayoutStateFromJson(json);
}
