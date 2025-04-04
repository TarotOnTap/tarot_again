// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bulk_card_control_bloc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BulkCardControlState _$BulkCardControlStateFromJson(
  Map<String, dynamic> json,
) => _BulkCardControlState(
  everybodyFaceUp: json['everybodyFaceUp'] as bool,
  reversalsAllowed: json['reversalsAllowed'] as bool,
  deckName: json['deckName'] as String? ?? "RWS",
);

Map<String, dynamic> _$BulkCardControlStateToJson(
  _BulkCardControlState instance,
) => <String, dynamic>{
  'everybodyFaceUp': instance.everybodyFaceUp,
  'reversalsAllowed': instance.reversalsAllowed,
  'deckName': instance.deckName,
};
