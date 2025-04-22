import 'package:tarot_again/util/util.dart';

import 'enums.dart';

part 'tc_model.freezed.dart';
part 'tc_model.g.dart';

/// The base model for delivering the two different flavors of tarot cards around
/// the app.
/// [tcMindorArcanaModel] is the factory constructor that creates the derived
/// [TCMinorArcanaModel] class; [tcMajorArcanaModel] creates the [TCMajorArcanaModel]
/// class.
/// Both sublcasses have a [sortOrder] and an [assetName] member.
/// Subclass [TCMinorArcanaModel] also has a [suits] member, values are from the
/// [Suits] enum, and a [pips] member, values from the [Pips] enum.
/// [TCMajorArcanaModel] only adds the [card] parameter, which is a value from
/// the [MajorArcana] enum, which itself holds a String [name] and String [romanNumber] parameter.
@freezed
sealed class TCModel with _$TCModel {
  factory TCModel.tcMinorArcanaModel({
    required int sortOrder,
    required String assetName,
    required Suits suit,
    required Pips pips,
  }) = TCMinorArcanaModel;

  factory TCModel.tcMajorArcanaModel({
    required int sortOrder,
    required String assetName,
    required MajorArcana card,
  }) = TCMajorArcanaModel;

  factory TCModel.fromJson(Map<String, dynamic> json) =>
      _$TCModelFromJson(json);
}
