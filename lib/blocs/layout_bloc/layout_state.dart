part of 'layout_bloc.dart';

typedef SlotKey = GlobalKey<PositionSlotWidgetState>;
typedef KeyIterable = Iterable<SlotKey>;

@immutable
class KeyConverter extends JsonConverter<SlotKey, int> {
  const KeyConverter();

  @override
  SlotKey fromJson(int fromJson) => GlobalKey();

  // fromJson.map((item) => GlobalKey<PositionSlotWidgetState>()).toList();

  @override
  int toJson(SlotKey key) => 0;

  // Iterable<int> toJson(KeyIterable toJson) => toJson.map((item) => 0);
}

@freezed
sealed class LayoutState with _$LayoutState {
  const factory LayoutState.layoutInitial({
    @Default(<String>[]) Iterable<String> layoutNames,
    @Default("Empty Layout") String currentLayoutName,
    @Default(TarotLayout.nullLayout()) TarotLayout currentLayout,
  }) = LayoutInitial;

  factory LayoutState.layoutStateReadyToDeal({
    required Iterable<String> layoutNames,
    required String currentLayoutName,
    required TarotLayout currentLayout,

    @KeyConverter() required KeyIterable slotKeys,
  }) = LayoutStateReadyToDeal;

  factory LayoutState.layoutStateDealt({
    required Iterable<String> layoutNames,
    required String currentLayoutName,
    required TarotLayout currentLayout,
    required Iterable<DealtCard> dealtCards,

    // this field is always generated as the app runs, otherwise it wouldn't
    // work.
    @KeyConverter() required KeyIterable slotKeys,
  }) = LayoutStateDealt;

  factory LayoutState.fromJson(Map<String, dynamic> json) =>
      _$LayoutStateFromJson(json);
}
