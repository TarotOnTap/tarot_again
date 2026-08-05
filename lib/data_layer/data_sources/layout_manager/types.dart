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

  /// internal *only* for testing purposes. do not write this layout to Json
  const factory TarotLayout.simpleGrid({
    required String name,
    required String displayName,
    required String layoutType,
    required int numCards,
    required String mdLayoutDescription,
  }) = SimpleGrid;

  // keep NullLayout as our default, initial layout. do not write this layout to Json
  const factory TarotLayout.nullLayout({
    @Default("nullLayout") String name,
    @Default("Empty Layout") String displayName,
    @Default("nullLayout") String layoutType,
    @Default(0) int numCards,
    @Default("") String mdLayoutDescription,
  }) = NullLayout;

  const factory TarotLayout.newTarotLayout({
    required String name,
    required String displayName,
    required String layoutType,
    required IList<PositionRepresentation> positions,
    String? mdLayoutDescription,
    String? attribution,
    String? url,
    String? documentation,
  }) = NewTarotLayout;

  factory TarotLayout.fromJson(Map<String, dynamic> json) =>
      _$TarotLayoutFromJson(json);
}

@freezed
abstract class SimpleGrid extends TarotLayout with _$SimpleGrid {
  const SimpleGrid._() : super._();

  const factory SimpleGrid({
    required String name,
    required String displayName,
    required String layoutType,
    required int numCards,
    required String mdLayoutDescription,
  }) = _SimpleGrid;

  factory SimpleGrid.fromJson(Map<String, dynamic> json) =>
      _$SimpleGridFromJson(json);
}

@freezed
abstract class NullLayout extends TarotLayout with _$NullLayout {
  const NullLayout._() : super._();

  const factory NullLayout({
    @Default("nullLayout") String name,
    @Default("Empty Layout") String displayName,
    @Default("nullLayout") String layoutType,
    @Default(0) int numCards,
    @Default("") String mdLayoutDescription,
  }) = _NullLayout;

  factory NullLayout.fromJson(Map<String, dynamic> json) =>
      _$NullLayoutFromJson(json);
}

@freezed
abstract class NewTarotLayout extends TarotLayout with _$NewTarotLayout {
  const NewTarotLayout._() : super._();

  const factory NewTarotLayout({
    required String name,
    required String displayName,
    required String layoutType,
    required PositionRepresentations positions,
    String? mdLayoutDescription,
    String? attribution,
    String? url,
    String? documentation,
  }) = _NewTarotLayout;

  factory NewTarotLayout.fromJson(Map<String, dynamic> json) =>
      _$NewTarotLayoutFromJson(json);

  static const jsonSchema = _$_NewTarotLayoutJsonSchema;
}

@freezed
abstract class LayoutList with _$LayoutList {
  const LayoutList._();

  const factory LayoutList({required Iterable<TarotLayout> layouts}) =
      _LayoutList;

  factory LayoutList.fromJson(Map<String, dynamic> json) =>
      _$LayoutListFromJson(json);

  static const jsonSchema = _$_LayoutListJsonSchema;
}
