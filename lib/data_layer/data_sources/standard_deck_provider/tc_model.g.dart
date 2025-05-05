// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tc_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TCMinorArcanaModel _$TCMinorArcanaModelFromJson(Map<String, dynamic> json) =>
    TCMinorArcanaModel(
      sortOrder: (json['sortOrder'] as num).toInt(),
      suit: $enumDecode(_$SuitsEnumMap, json['suit']),
      pips: $enumDecode(_$PipsEnumMap, json['pips']),
      assetReference: json['assetReference'] as String,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$TCMinorArcanaModelToJson(TCMinorArcanaModel instance) =>
    <String, dynamic>{
      'sortOrder': instance.sortOrder,
      'suit': _$SuitsEnumMap[instance.suit]!,
      'pips': _$PipsEnumMap[instance.pips]!,
      'assetReference': instance.assetReference,
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
      card: $enumDecode(_$MajorArcanaEnumMap, json['card']),
      assetReference: json['assetReference'] as String,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$TCMajorArcanaModelToJson(TCMajorArcanaModel instance) =>
    <String, dynamic>{
      'sortOrder': instance.sortOrder,
      'card': _$MajorArcanaEnumMap[instance.card]!,
      'assetReference': instance.assetReference,
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
