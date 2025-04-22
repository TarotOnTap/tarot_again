part of 'layout_bloc.dart';

typedef SlotBloc = SlotWidgetBloc;
typedef KeyIterable = IList<SlotBloc>;

@immutable
class KeyConverter extends JsonConverter<SlotWidgetBloc, String> {
  const KeyConverter();

  @override
  SlotWidgetBloc fromJson(String fromJson) =>
      SlotWidgetBloc(slotName: fromJson);

  // fromJson.map((item) => GlobalKey<PositionSlotWidgetState>()).toList();

  @override
  String toJson(SlotWidgetBloc slot) => slot.state.slotName;

  // Iterable<int> toJson(KeyIterable toJson) => toJson.map((item) => 0);
}

@freezed
sealed class LayoutState with _$LayoutState {
  const factory LayoutState.layoutInitial({
    @Default(IList<String>.empty()) IList<String> layoutNames,
    @Default("Empty Layout") String currentLayoutName,
    @Default(TarotLayout.nullLayout()) TarotLayout currentLayout,
  }) = LayoutInitial;

  factory LayoutState.slotsAssigned({
    required String currentLayoutName,
    required TarotLayout currentLayout,
    required IList<String> layoutNames,

    // this field is always generated as the app runs, otherwise it wouldn't
    // work.
    @KeyConverter() required KeyIterable slotKeys,
  }) = LayoutStateSlotsAssigned;

  factory LayoutState.cardsAssigned({
    required String currentLayoutName,
    required TarotLayout currentLayout,
    required IList<String> layoutNames,

    // this field is always generated as the app runs, otherwise it wouldn't
    // work.
    @KeyConverter() required KeyIterable slotKeys,
    required IList<DealtCard> dealtCards,
  }) = LayoutStateCardsAssigned;

  factory LayoutState.fromJson(Map<String, dynamic> json) =>
      _$LayoutStateFromJson(json);
}
