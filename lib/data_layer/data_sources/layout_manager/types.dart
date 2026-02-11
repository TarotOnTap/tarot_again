import 'package:tarot_again/util/util.dart';

part 'types.freezed.dart';
part 'types.g.dart';

class LayoutSlot {
  LayoutSlot();
}

// Some potential layout descriptions, here:
// {
//   "name": "pastPresentFuture",
//   "displayName": "Past, Present, Future",
//   "horizontalAlign": "center",
//   "verticalAlign": "center",
//   "centerOnPosition": 1,
//   "positions": {
//     "row": [
//       {"name": "Past", "x": 0, "y": 0, "rotation": 0 },
//       {"name": "Present", "x": 1, "y": 0, "rotation": 0 },
//       {"name": "Future", "x": 2, "y": 0, "rotation": 0 } ] }
//     ]
//  }
// }

@Freezed(unionKey: 'layoutType', unionValueCase: FreezedUnionCase.pascal)
sealed class TarotLayout with _$TarotLayout {
  /// These classes are only data and do not have any methods beyond toJson / fromJson
  factory TarotLayout.stackLayout({
    required String displayName,
    required String layoutType,
    required int numCards,
    required String mdLayoutDescription,
  }) = StackLayout;

  factory TarotLayout.complexLayout({
    required String displayName,
    required String layoutType,
    required int numCards,
    required String mdLayoutDescription,
  }) = ComplexLayout;

  factory TarotLayout.horizontalLinear({
    required String displayName,
    required String layoutType,
    required int numCards,
    required String horizontalAlign,
    required String verticalAlign,
    required int alignOnCard,
    required Iterable<String> slotNames,
    required String mdLayoutDescription,
  }) = HorizontalLinear;

  factory TarotLayout.simpleGrid({
    required String displayName,
    required String layoutType,
    required int numCards,
    required String mdLayoutDescription,
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
