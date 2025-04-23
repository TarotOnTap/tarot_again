part of 'layout_bloc.dart';

@freezed
sealed class LayoutState with _$LayoutState {
  const factory LayoutState({
    @Default(IList<String>.empty()) IList<String> layoutNames,
    @Default("Empty Layout") String currentLayoutName,
    @Default(TarotLayout.nullLayout()) TarotLayout currentLayout,
    @Default(const IList<SlotWidgetState>.empty())
    IList<SlotWidgetState> slotWidgetStates,
    @Default(const IList<String>.empty()) IList<String> slotTitles,
    @Default(const IList<DealtCard>.empty()) IList<DealtCard> dealtCards,
  }) = _LayoutState;

  factory LayoutState.fromJson(Map<String, dynamic> json) =>
      _$LayoutStateFromJson(json);
}
