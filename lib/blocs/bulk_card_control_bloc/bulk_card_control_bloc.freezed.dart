// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bulk_card_control_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BulkCardControlState {

 bool get everybodyFaceUp; bool get reversalsAllowed; String get deckName;
/// Create a copy of BulkCardControlState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BulkCardControlStateCopyWith<BulkCardControlState> get copyWith => _$BulkCardControlStateCopyWithImpl<BulkCardControlState>(this as BulkCardControlState, _$identity);

  /// Serializes this BulkCardControlState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BulkCardControlState&&(identical(other.everybodyFaceUp, everybodyFaceUp) || other.everybodyFaceUp == everybodyFaceUp)&&(identical(other.reversalsAllowed, reversalsAllowed) || other.reversalsAllowed == reversalsAllowed)&&(identical(other.deckName, deckName) || other.deckName == deckName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,everybodyFaceUp,reversalsAllowed,deckName);

@override
String toString() {
  return 'BulkCardControlState(everybodyFaceUp: $everybodyFaceUp, reversalsAllowed: $reversalsAllowed, deckName: $deckName)';
}


}

/// @nodoc
abstract mixin class $BulkCardControlStateCopyWith<$Res>  {
  factory $BulkCardControlStateCopyWith(BulkCardControlState value, $Res Function(BulkCardControlState) _then) = _$BulkCardControlStateCopyWithImpl;
@useResult
$Res call({
 bool everybodyFaceUp, bool reversalsAllowed, String deckName
});




}
/// @nodoc
class _$BulkCardControlStateCopyWithImpl<$Res>
    implements $BulkCardControlStateCopyWith<$Res> {
  _$BulkCardControlStateCopyWithImpl(this._self, this._then);

  final BulkCardControlState _self;
  final $Res Function(BulkCardControlState) _then;

/// Create a copy of BulkCardControlState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? everybodyFaceUp = null,Object? reversalsAllowed = null,Object? deckName = null,}) {
  return _then(_self.copyWith(
everybodyFaceUp: null == everybodyFaceUp ? _self.everybodyFaceUp : everybodyFaceUp // ignore: cast_nullable_to_non_nullable
as bool,reversalsAllowed: null == reversalsAllowed ? _self.reversalsAllowed : reversalsAllowed // ignore: cast_nullable_to_non_nullable
as bool,deckName: null == deckName ? _self.deckName : deckName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _BulkCardControlState implements BulkCardControlState {
   _BulkCardControlState({required this.everybodyFaceUp, required this.reversalsAllowed, this.deckName = "RWS"});
  factory _BulkCardControlState.fromJson(Map<String, dynamic> json) => _$BulkCardControlStateFromJson(json);

@override final  bool everybodyFaceUp;
@override final  bool reversalsAllowed;
@override@JsonKey() final  String deckName;

/// Create a copy of BulkCardControlState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BulkCardControlStateCopyWith<_BulkCardControlState> get copyWith => __$BulkCardControlStateCopyWithImpl<_BulkCardControlState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BulkCardControlStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BulkCardControlState&&(identical(other.everybodyFaceUp, everybodyFaceUp) || other.everybodyFaceUp == everybodyFaceUp)&&(identical(other.reversalsAllowed, reversalsAllowed) || other.reversalsAllowed == reversalsAllowed)&&(identical(other.deckName, deckName) || other.deckName == deckName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,everybodyFaceUp,reversalsAllowed,deckName);

@override
String toString() {
  return 'BulkCardControlState(everybodyFaceUp: $everybodyFaceUp, reversalsAllowed: $reversalsAllowed, deckName: $deckName)';
}


}

/// @nodoc
abstract mixin class _$BulkCardControlStateCopyWith<$Res> implements $BulkCardControlStateCopyWith<$Res> {
  factory _$BulkCardControlStateCopyWith(_BulkCardControlState value, $Res Function(_BulkCardControlState) _then) = __$BulkCardControlStateCopyWithImpl;
@override @useResult
$Res call({
 bool everybodyFaceUp, bool reversalsAllowed, String deckName
});




}
/// @nodoc
class __$BulkCardControlStateCopyWithImpl<$Res>
    implements _$BulkCardControlStateCopyWith<$Res> {
  __$BulkCardControlStateCopyWithImpl(this._self, this._then);

  final _BulkCardControlState _self;
  final $Res Function(_BulkCardControlState) _then;

/// Create a copy of BulkCardControlState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? everybodyFaceUp = null,Object? reversalsAllowed = null,Object? deckName = null,}) {
  return _then(_BulkCardControlState(
everybodyFaceUp: null == everybodyFaceUp ? _self.everybodyFaceUp : everybodyFaceUp // ignore: cast_nullable_to_non_nullable
as bool,reversalsAllowed: null == reversalsAllowed ? _self.reversalsAllowed : reversalsAllowed // ignore: cast_nullable_to_non_nullable
as bool,deckName: null == deckName ? _self.deckName : deckName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
