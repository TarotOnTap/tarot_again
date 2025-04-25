part of 'layout_bloc.dart';

enum NewLayout { yes, no }

// class SlotWidgetBlocConverter
//     implements JsonConverter<SlotWidgetBloc, Map<String, dynamic>> {
//   const SlotWidgetBlocConverter();
//
//   @override
//   SlotWidgetBloc fromJson(Map<String, dynamic> json) => SlotWidgetBloc(
//     slotName: json["slotName"] ?? "",
//     slotIndex: json["slotIndex"],
//   );
//
//   @override
//   Map<String, dynamic> toJson(SlotWidgetBloc bloc) => {
//     "slotName": bloc.state.slotName,
//     "slotIndex": bloc.state.slotIndex,
//   };
// }

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
