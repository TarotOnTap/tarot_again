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
          return _TCMinorArcanaModel.fromJson(
            json
          );
                case 'TcMajorArcanaModel':
          return _TCMajorArcanaModel.fromJson(
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

 int get sortOrder; String get assetName;
/// Create a copy of TCModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TCModelCopyWith<TCModel> get copyWith => _$TCModelCopyWithImpl<TCModel>(this as TCModel, _$identity);

  /// Serializes this TCModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TCModel&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.assetName, assetName) || other.assetName == assetName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sortOrder,assetName);

@override
String toString() {
  return 'TCModel(sortOrder: $sortOrder, assetName: $assetName)';
}


}

/// @nodoc
abstract mixin class $TCModelCopyWith<$Res>  {
  factory $TCModelCopyWith(TCModel value, $Res Function(TCModel) _then) = _$TCModelCopyWithImpl;
@useResult
$Res call({
 int sortOrder, String assetName
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
@pragma('vm:prefer-inline') @override $Res call({Object? sortOrder = null,Object? assetName = null,}) {
  return _then(_self.copyWith(
sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,assetName: null == assetName ? _self.assetName : assetName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _TCMinorArcanaModel implements TCModel {
   _TCMinorArcanaModel({required this.sortOrder, required this.assetName, required this.suit, required this.pips, final  String? $type}): $type = $type ?? 'TcMinorArcanaModel';
  factory _TCMinorArcanaModel.fromJson(Map<String, dynamic> json) => _$TCMinorArcanaModelFromJson(json);

@override final  int sortOrder;
@override final  String assetName;
 final  Suits suit;
 final  Pips pips;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of TCModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TCMinorArcanaModelCopyWith<_TCMinorArcanaModel> get copyWith => __$TCMinorArcanaModelCopyWithImpl<_TCMinorArcanaModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TCMinorArcanaModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TCMinorArcanaModel&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.assetName, assetName) || other.assetName == assetName)&&(identical(other.suit, suit) || other.suit == suit)&&(identical(other.pips, pips) || other.pips == pips));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sortOrder,assetName,suit,pips);

@override
String toString() {
  return 'TCModel.tcMinorArcanaModel(sortOrder: $sortOrder, assetName: $assetName, suit: $suit, pips: $pips)';
}


}

/// @nodoc
abstract mixin class _$TCMinorArcanaModelCopyWith<$Res> implements $TCModelCopyWith<$Res> {
  factory _$TCMinorArcanaModelCopyWith(_TCMinorArcanaModel value, $Res Function(_TCMinorArcanaModel) _then) = __$TCMinorArcanaModelCopyWithImpl;
@override @useResult
$Res call({
 int sortOrder, String assetName, Suits suit, Pips pips
});




}
/// @nodoc
class __$TCMinorArcanaModelCopyWithImpl<$Res>
    implements _$TCMinorArcanaModelCopyWith<$Res> {
  __$TCMinorArcanaModelCopyWithImpl(this._self, this._then);

  final _TCMinorArcanaModel _self;
  final $Res Function(_TCMinorArcanaModel) _then;

/// Create a copy of TCModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sortOrder = null,Object? assetName = null,Object? suit = null,Object? pips = null,}) {
  return _then(_TCMinorArcanaModel(
sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,assetName: null == assetName ? _self.assetName : assetName // ignore: cast_nullable_to_non_nullable
as String,suit: null == suit ? _self.suit : suit // ignore: cast_nullable_to_non_nullable
as Suits,pips: null == pips ? _self.pips : pips // ignore: cast_nullable_to_non_nullable
as Pips,
  ));
}


}

/// @nodoc
@JsonSerializable()

class _TCMajorArcanaModel implements TCModel {
   _TCMajorArcanaModel({required this.sortOrder, required this.assetName, required this.card, final  String? $type}): $type = $type ?? 'TcMajorArcanaModel';
  factory _TCMajorArcanaModel.fromJson(Map<String, dynamic> json) => _$TCMajorArcanaModelFromJson(json);

@override final  int sortOrder;
@override final  String assetName;
 final  MajorArcana card;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of TCModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TCMajorArcanaModelCopyWith<_TCMajorArcanaModel> get copyWith => __$TCMajorArcanaModelCopyWithImpl<_TCMajorArcanaModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TCMajorArcanaModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TCMajorArcanaModel&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.assetName, assetName) || other.assetName == assetName)&&(identical(other.card, card) || other.card == card));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sortOrder,assetName,card);

@override
String toString() {
  return 'TCModel.tcMajorArcanaModel(sortOrder: $sortOrder, assetName: $assetName, card: $card)';
}


}

/// @nodoc
abstract mixin class _$TCMajorArcanaModelCopyWith<$Res> implements $TCModelCopyWith<$Res> {
  factory _$TCMajorArcanaModelCopyWith(_TCMajorArcanaModel value, $Res Function(_TCMajorArcanaModel) _then) = __$TCMajorArcanaModelCopyWithImpl;
@override @useResult
$Res call({
 int sortOrder, String assetName, MajorArcana card
});




}
/// @nodoc
class __$TCMajorArcanaModelCopyWithImpl<$Res>
    implements _$TCMajorArcanaModelCopyWith<$Res> {
  __$TCMajorArcanaModelCopyWithImpl(this._self, this._then);

  final _TCMajorArcanaModel _self;
  final $Res Function(_TCMajorArcanaModel) _then;

/// Create a copy of TCModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sortOrder = null,Object? assetName = null,Object? card = null,}) {
  return _then(_TCMajorArcanaModel(
sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,assetName: null == assetName ? _self.assetName : assetName // ignore: cast_nullable_to_non_nullable
as String,card: null == card ? _self.card : card // ignore: cast_nullable_to_non_nullable
as MajorArcana,
  ));
}


}

// dart format on
