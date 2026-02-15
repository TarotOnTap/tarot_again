import 'package:tarot_again/util/util.dart';

export 'position_representation.dart';

// that are used

part 'types.freezed.dart'; // j
//
part 'types.g.dart';

class LayoutSlot {
  LayoutSlot();
}

@Freezed(unionKey: 'layoutType', unionValueCase: FreezedUnionCase.pascal)
sealed class TarotLayout with _$TarotLayout {
  /// These classes are only data and do not have any methods beyond toJson / fromJson
  const TarotLayout._();

  const factory TarotLayout.horizontalLinear({
    required String name,
    required String displayName,
    required String layoutType,
    required int numCards,
    required String horizontalAlign,
    required String verticalAlign,
    required int alignOnCard,
    required Iterable<String> slotNames,
    required String mdLayoutDescription,
  }) = HorizontalLinear;

  const factory TarotLayout.simpleGrid({
    required String name,
    required String displayName,
    required String layoutType,
    required int numCards,
    required String mdLayoutDescription,
  }) = SimpleGrid;

  const factory TarotLayout.nullLayout({
    @Default("nullLayout") String name,
    @Default("Empty Layout") String displayName,
    @Default("nullLayout") String layoutType,
    @Default(0) int numCards,
    @Default("# NULL LAYOUT") String mdLayoutDescription,
  }) = NullLayout;

  const factory TarotLayout.newTarotLayout({
    required String name,
    required String displayName,
    required String layoutType,
    // required int numCards,
    String? mdLayoutDescription,
    String? attribution,
    String? url,
    String? documentation,
    required IList<PositionRepresentation> positions,
  }) = NewTarotLayout;

  factory TarotLayout.fromJson(Map<String, dynamic> json) =>
      _$TarotLayoutFromJson(json);
}

@freezed
abstract class NewTarotLayout extends TarotLayout with _$NewTarotLayout {
  const NewTarotLayout._() : super._();

  const factory NewTarotLayout({
    required String name,
    required String displayName,
    required String layoutType,
    String? mdLayoutDescription,
    String? attribution,
    String? url,
    String? documentation,
    required IList<PositionRepresentation> positions,
  }) = _NewTarotLayout;

  factory NewTarotLayout.fromJson(Map<String, dynamic> json) =>
      _$NewTarotLayoutFromJson(json);

  static const jsonSchema = _$_NewTarotLayoutJsonSchema;
}

@freezed
abstract class LayoutList with _$LayoutList {
  const LayoutList._();

  const factory LayoutList({required IList<TarotLayout> layouts}) = _LayoutList;

  factory LayoutList.fromJson(Map<String, dynamic> json) =>
      _$LayoutListFromJson(json);

  static const jsonSchema = _$_LayoutListJsonSchema;
}
