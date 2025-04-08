import 'package:tarot_again/util/util.dart';

part 'types.freezed.dart';
part 'types.g.dart';

class LayoutSlot {
  LayoutSlot();
}

@freezed
sealed class Layout with _$Layout {
  /// These classes are only data and do not have any methods
  factory Layout.horizontalLinear({
    required String displayName,
    required String layoutType,
    required String horizontalAlign,
    required String verticalAlign,
    int? alignOnCard,
    required int numCards,
    required List<String> slots,
  }) = HorizontalLinear;

  factory Layout.simpleGrid({
    required String displayName,
    required String layoutType,
    required int numCard,
  }) = SimpleGrid;

  factory Layout.nullLayout() = NullLayout;

  factory Layout.fromJson(Map<String, dynamic> json) => _$LayoutFromJson(json);
}
