import 'package:tarot_again/data_layer/data_layer.dart';
import 'package:tarot_again/util/util.dart';

part 'types.freezed.dart';
part 'types.g.dart';

@freezed
abstract class LayoutPositionInfo with _$LayoutPositionInfo {
  factory LayoutPositionInfo({
    required String positionTitle,
    required DealtCard dealtCard,
    required bool isManagedPosition,
    double? x,
    double? y,
    double? rotation,
  }) = _LayoutPositionInfo;

  factory LayoutPositionInfo.fromJson(Map<String, dynamic> json) =>
      _$LayoutPositionInfoFromJson(json);
}

@freezed
abstract class TarotLayout with _$TarotLayout {
  factory TarotLayout({required String layoutName}) = _TarotLayout;

  factory TarotLayout.fromJson(Map<String, dynamic> json) =>
      _$TarotLayoutFromJson(json);
}
