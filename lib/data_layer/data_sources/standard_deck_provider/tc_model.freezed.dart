// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tc_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
TCModel _$TCModelFromJson(
  Map<String, dynamic> json
) {
        switch (json['type']) {
                  case 'TcMinorArcanaModel':
          return TCMinorArcanaModel.fromJson(
            json
          );
                case 'TcMajorArcanaModel':
          return TCMajorArcanaModel.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'type',
  'TCModel',
  'Invalid union type "${json['type']}"!'
);
        }
      
}

/// @nodoc
mixin _$TCModel {

 int get sortOrder; String get assetReference;
/// Create a copy of TCModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TCModelCopyWith<TCModel> get copyWith => _$TCModelCopyWithImpl<TCModel>(this as TCModel, _$identity);

  /// Serializes this TCModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TCModel&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.assetReference, assetReference) || other.assetReference == assetReference));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sortOrder,assetReference);

@override
String toString() {
  return 'TCModel(sortOrder: $sortOrder, assetReference: $assetReference)';
}


}

/// @nodoc
abstract mixin class $TCModelCopyWith<$Res>  {
  factory $TCModelCopyWith(TCModel value, $Res Function(TCModel) _then) = _$TCModelCopyWithImpl;
@useResult
$Res call({
 int sortOrder, String assetReference
});




}
/// @nodoc
class _$TCModelCopyWithImpl<$Res>
    implements $TCModelCopyWith<$Res> {
  _$TCModelCopyWithImpl(this._self, this._then);

  final TCModel _self;
  final $Res Function(TCModel) _then;

/// Create a copy of TCModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sortOrder = null,Object? assetReference = null,}) {
  return _then(_self.copyWith(
sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,assetReference: null == assetReference ? _self.assetReference : assetReference // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class TCMinorArcanaModel implements TCModel {
   TCMinorArcanaModel({required this.sortOrder, required this.suit, required this.pips, required this.assetReference, final  String? $type}): $type = $type ?? 'TcMinorArcanaModel';
  factory TCMinorArcanaModel.fromJson(Map<String, dynamic> json) => _$TCMinorArcanaModelFromJson(json);

@override final  int sortOrder;
 final  Suits suit;
 final  Pips pips;
@override final  String assetReference;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of TCModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TCMinorArcanaModelCopyWith<TCMinorArcanaModel> get copyWith => _$TCMinorArcanaModelCopyWithImpl<TCMinorArcanaModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TCMinorArcanaModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TCMinorArcanaModel&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.suit, suit) || other.suit == suit)&&(identical(other.pips, pips) || other.pips == pips)&&(identical(other.assetReference, assetReference) || other.assetReference == assetReference));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sortOrder,suit,pips,assetReference);

@override
String toString() {
  return 'TCModel.tcMinorArcanaModel(sortOrder: $sortOrder, suit: $suit, pips: $pips, assetReference: $assetReference)';
}


}

/// @nodoc
abstract mixin class $TCMinorArcanaModelCopyWith<$Res> implements $TCModelCopyWith<$Res> {
  factory $TCMinorArcanaModelCopyWith(TCMinorArcanaModel value, $Res Function(TCMinorArcanaModel) _then) = _$TCMinorArcanaModelCopyWithImpl;
@override @useResult
$Res call({
 int sortOrder, Suits suit, Pips pips, String assetReference
});




}
/// @nodoc
class _$TCMinorArcanaModelCopyWithImpl<$Res>
    implements $TCMinorArcanaModelCopyWith<$Res> {
  _$TCMinorArcanaModelCopyWithImpl(this._self, this._then);

  final TCMinorArcanaModel _self;
  final $Res Function(TCMinorArcanaModel) _then;

/// Create a copy of TCModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sortOrder = null,Object? suit = null,Object? pips = null,Object? assetReference = null,}) {
  return _then(TCMinorArcanaModel(
sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,suit: null == suit ? _self.suit : suit // ignore: cast_nullable_to_non_nullable
as Suits,pips: null == pips ? _self.pips : pips // ignore: cast_nullable_to_non_nullable
as Pips,assetReference: null == assetReference ? _self.assetReference : assetReference // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class TCMajorArcanaModel implements TCModel {
   TCMajorArcanaModel({required this.sortOrder, required this.card, required this.assetReference, final  String? $type}): $type = $type ?? 'TcMajorArcanaModel';
  factory TCMajorArcanaModel.fromJson(Map<String, dynamic> json) => _$TCMajorArcanaModelFromJson(json);

@override final  int sortOrder;
 final  MajorArcana card;
@override final  String assetReference;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of TCModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TCMajorArcanaModelCopyWith<TCMajorArcanaModel> get copyWith => _$TCMajorArcanaModelCopyWithImpl<TCMajorArcanaModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TCMajorArcanaModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TCMajorArcanaModel&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.card, card) || other.card == card)&&(identical(other.assetReference, assetReference) || other.assetReference == assetReference));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sortOrder,card,assetReference);

@override
String toString() {
  return 'TCModel.tcMajorArcanaModel(sortOrder: $sortOrder, card: $card, assetReference: $assetReference)';
}


}

/// @nodoc
abstract mixin class $TCMajorArcanaModelCopyWith<$Res> implements $TCModelCopyWith<$Res> {
  factory $TCMajorArcanaModelCopyWith(TCMajorArcanaModel value, $Res Function(TCMajorArcanaModel) _then) = _$TCMajorArcanaModelCopyWithImpl;
@override @useResult
$Res call({
 int sortOrder, MajorArcana card, String assetReference
});




}
/// @nodoc
class _$TCMajorArcanaModelCopyWithImpl<$Res>
    implements $TCMajorArcanaModelCopyWith<$Res> {
  _$TCMajorArcanaModelCopyWithImpl(this._self, this._then);

  final TCMajorArcanaModel _self;
  final $Res Function(TCMajorArcanaModel) _then;

/// Create a copy of TCModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sortOrder = null,Object? card = null,Object? assetReference = null,}) {
  return _then(TCMajorArcanaModel(
sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,card: null == card ? _self.card : card // ignore: cast_nullable_to_non_nullable
as MajorArcana,assetReference: null == assetReference ? _self.assetReference : assetReference // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
