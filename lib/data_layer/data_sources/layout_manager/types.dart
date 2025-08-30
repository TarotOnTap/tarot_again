import 'package:tarot_again/util/util.dart';

part 'types.freezed.dart';
part 'types.g.dart';

class LayoutSlot {
  LayoutSlot();
}

@Freezed(unionKey: 'layoutType', unionValueCase: FreezedUnionCase.pascal)
sealed class TarotLayout with _$TarotLayout {
  /// These classes are only data and do not have any methods
  // TODO: make mdLayoutDescription required with no default; this forces the json file these are built from to
  //       have a mdLayoutDescription field so that this file can be stable - doesn't require as many invocations of
  //       build runner that way. Move the internal texts to the json file; move the nullLayout definition to the
  //       json file, too.
  factory TarotLayout.horizontalLinear({
    required String displayName,
    required String layoutType,
    required int numCards,
    required String horizontalAlign,
    required String verticalAlign,
    required int alignOnCard,
    required Iterable<String> slotNames,
    @Default("# HorizontalLinear Description Undefined")
    String mdLayoutDescription,
  }) = HorizontalLinear;

  factory TarotLayout.simpleGrid({
    required String displayName,
    required String layoutType,
    required int numCards,
    @Default("# SimpleGrid Description Undefined") String mdLayoutDescription,
  }) = SimpleGrid;

  const factory TarotLayout.nullLayout({
    @Default("Empty Layout") String displayName,
    @Default("nullLayout") String layoutType,
    @Default(0) int numCards,
    @Default("# NULL LAYOUT") String mdLayoutDescription,
  }) = NullLayout;

  factory TarotLayout.fromJson(Map<String, dynamic> json) =>
      _$TarotLayoutFromJson(json);
}

// @freezed
// sealed class TarotLayoutInfo with _$TarotLayoutInfo {
//   factory TarotLayoutInfo.regularLayoutInfo({
//     required String name,
//     required String basePath,
//     required String displayName,
//     required String layoutJson,
//     required String layoutDescription,
//     required TarotLayout associatedLayout,
//   }) = RegularLayoutInfo;
//
//   factory TarotLayoutInfo.nullLayoutInfo({@Default("No Such Layout") String displayName}) =
//       NullLayoutInfo;
//
//   factory TarotLayoutInfo.fromJson(Map<String, dynamic> json) =>
//       _$TarotLayoutInfoFromJson(json);
// }
