import 'package:tarot_again/util/util.dart';

part 'types.freezed.dart';
part 'types.g.dart';

class LayoutSlot {
  LayoutSlot();
}

@Freezed(unionKey: 'layoutType', unionValueCase: FreezedUnionCase.pascal)
sealed class TarotLayout with _$TarotLayout {
  /// These classes are only data and do not have any methods
  factory TarotLayout.horizontalLinear({
    required String displayName,
    required String layoutType,
    required int numCards,
    required String horizontalAlign,
    required String verticalAlign,
    required int alignOnCard,
    required Iterable<String> slotNames,
  }) = HorizontalLinear;

  factory TarotLayout.simpleGrid({
    required String displayName,
    required String layoutType,
    required int numCards,
  }) = SimpleGrid;

  const factory TarotLayout.nullLayout({
    @Default("Empty Layout") String displayName,
    @Default("nullLayout") String layoutType,
    @Default(0) int numCards,
  }) = NullLayout;

  factory TarotLayout.fromJson(Map<String, dynamic> json) =>
      _$TarotLayoutFromJson(json);
}

@freezed
sealed class TarotLayoutInfo with _$TarotLayoutInfo {
  factory TarotLayoutInfo.regularLayoutInfo({
    required String name,
    required String basePath,
    required String displayName,
    required String layoutJson,
    required String layoutDescription,
    required TarotLayout associatedLayout,
  }) = RegularLayoutInfo;

  factory TarotLayoutInfo.nullLayoutInfo() = NullLayoutInfo;

  factory TarotLayoutInfo.fromJson(Map<String, dynamic> json) =>
      _$TarotLayoutInfoFromJson(json);
}
