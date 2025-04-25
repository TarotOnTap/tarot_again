// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tc_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TCMinorArcanaModel _$TCMinorArcanaModelFromJson(Map<String, dynamic> json) =>
    TCMinorArcanaModel(
      sortOrder: (json['sortOrder'] as num).toInt(),
      assetName: json['assetName'] as String,
      suit: $enumDecode(_$SuitsEnumMap, json['suit']),
      pips: $enumDecode(_$PipsEnumMap, json['pips']),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$TCMinorArcanaModelToJson(TCMinorArcanaModel instance) =>
    <String, dynamic>{
      'sortOrder': instance.sortOrder,
      'assetName': instance.assetName,
      'suit': _$SuitsEnumMap[instance.suit]!,
      'pips': _$PipsEnumMap[instance.pips]!,
      'type': instance.$type,
    };

const _$SuitsEnumMap = {
  Suits.wands: 'wands',
  Suits.cups: 'cups',
  Suits.swords: 'swords',
  Suits.pentacles: 'pentacles',
};

const _$PipsEnumMap = {
  Pips.ace: 'ace',
  Pips.two: 'two',
  Pips.three: 'three',
  Pips.four: 'four',
  Pips.five: 'five',
  Pips.six: 'six',
  Pips.seven: 'seven',
  Pips.eight: 'eight',
  Pips.nine: 'nine',
  Pips.ten: 'ten',
  Pips.page: 'page',
  Pips.knight: 'knight',
  Pips.queen: 'queen',
  Pips.king: 'king',
};

TCMajorArcanaModel _$TCMajorArcanaModelFromJson(Map<String, dynamic> json) =>
    TCMajorArcanaModel(
      sortOrder: (json['sortOrder'] as num).toInt(),
      assetName: json['assetName'] as String,
      card: $enumDecode(_$MajorArcanaEnumMap, json['card']),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$TCMajorArcanaModelToJson(TCMajorArcanaModel instance) =>
    <String, dynamic>{
      'sortOrder': instance.sortOrder,
      'assetName': instance.assetName,
      'card': _$MajorArcanaEnumMap[instance.card]!,
      'type': instance.$type,
    };

const _$MajorArcanaEnumMap = {
  MajorArcana.fool: 'fool',
  MajorArcana.magician: 'magician',
  MajorArcana.highPriestess: 'highPriestess',
  MajorArcana.empress: 'empress',
  MajorArcana.emperor: 'emperor',
  MajorArcana.hierophant: 'hierophant',
  MajorArcana.lovers: 'lovers',
  MajorArcana.chariot: 'chariot',
  MajorArcana.strength: 'strength',
  MajorArcana.hermit: 'hermit',
  MajorArcana.wheelOfFortune: 'wheelOfFortune',
  MajorArcana.justice: 'justice',
  MajorArcana.hangedMan: 'hangedMan',
  MajorArcana.death: 'death',
  MajorArcana.temperance: 'temperance',
  MajorArcana.devil: 'devil',
  MajorArcana.tower: 'tower',
  MajorArcana.star: 'star',
  MajorArcana.moon: 'moon',
  MajorArcana.sun: 'sun',
  MajorArcana.judgment: 'judgment',
  MajorArcana.theWorld: 'theWorld',
};
