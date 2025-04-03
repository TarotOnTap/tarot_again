import 'package:tarot_again/util/util.dart';

import 'enums.dart';

part 'tc_model.freezed.dart';
part 'tc_model.g.dart';

@freezed
sealed class TCModel with _$TCModel {
  factory TCModel.tcMinorArcanaModel({
    required int sortOrder,
    required String assetName,
    required Suits suit,
    required Pips pips,
  }) = _TCMinorArcanaModel;

  factory TCModel.tcMajorArcanaModel({
    required int sortOrder,
    required String assetName,
    required MajorArcana card,
  }) = _TCMajorArcanaModel;

  factory TCModel.fromJson(Map<String, Object?> json) =>
      _$TCModelFromJson(json);
}