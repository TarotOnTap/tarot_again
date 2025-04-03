// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_widget_bloc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CardWidgetState _$CardWidgetStateFromJson(Map<String, dynamic> json) =>
    _CardWidgetState(
      faceUp: json['faceUp'] as bool? ?? false,
      reversed: json['reversed'] as bool? ?? false,
      card:
          json['card'] == null
              ? null
              : TCModel.fromJson(json['card'] as Map<String, dynamic>),
      description: json['description'] as String?,
      uprightMeaning: json['uprightMeaning'] as String?,
      reversedMeaning: json['reversedMeaning'] as String?,
    );

Map<String, dynamic> _$CardWidgetStateToJson(_CardWidgetState instance) =>
    <String, dynamic>{
      'faceUp': instance.faceUp,
      'reversed': instance.reversed,
      'card': instance.card,
      'description': instance.description,
      'uprightMeaning': instance.uprightMeaning,
      'reversedMeaning': instance.reversedMeaning,
    };
