part of 'layout_bloc.dart';

enum NewLayout { yes, no }

@freezed
sealed class LayoutState with _$LayoutState {
  const factory LayoutState({
    // required NewLayout newLayout,
    @Default(IList<String>.empty()) IList<String> layoutNames,
    @Default("Empty Layout") String currentLayoutName,
    @Default(TarotLayout.nullLayout()) TarotLayout currentLayout,
    @Default(const SWStates.empty()) SWStates slotWidgetStates,
    @Default(const IList<String>.empty()) IList<String> slotNames,
  }) = _LayoutState;

  factory LayoutState.fromJson(Map<String, dynamic> json) =>
      _$LayoutStateFromJson(json);
}
