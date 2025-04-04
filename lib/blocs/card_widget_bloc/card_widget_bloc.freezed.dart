// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'card_widget_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CardWidgetState {

 bool get faceUp; bool get reversed;
/// Create a copy of CardWidgetState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CardWidgetStateCopyWith<CardWidgetState> get copyWith => _$CardWidgetStateCopyWithImpl<CardWidgetState>(this as CardWidgetState, _$identity);

  /// Serializes this CardWidgetState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CardWidgetState&&(identical(other.faceUp, faceUp) || other.faceUp == faceUp)&&(identical(other.reversed, reversed) || other.reversed == reversed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,faceUp,reversed);

@override
String toString() {
  return 'CardWidgetState(faceUp: $faceUp, reversed: $reversed)';
}


}

/// @nodoc
abstract mixin class $CardWidgetStateCopyWith<$Res>  {
  factory $CardWidgetStateCopyWith(CardWidgetState value, $Res Function(CardWidgetState) _then) = _$CardWidgetStateCopyWithImpl;
@useResult
$Res call({
 bool faceUp, bool reversed
});




}
/// @nodoc
class _$CardWidgetStateCopyWithImpl<$Res>
    implements $CardWidgetStateCopyWith<$Res> {
  _$CardWidgetStateCopyWithImpl(this._self, this._then);

  final CardWidgetState _self;
  final $Res Function(CardWidgetState) _then;

/// Create a copy of CardWidgetState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? faceUp = null,Object? reversed = null,}) {
  return _then(_self.copyWith(
faceUp: null == faceUp ? _self.faceUp : faceUp // ignore: cast_nullable_to_non_nullable
as bool,reversed: null == reversed ? _self.reversed : reversed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _CardWidgetState implements CardWidgetState {
   _CardWidgetState({this.faceUp = false, this.reversed = false});
  factory _CardWidgetState.fromJson(Map<String, dynamic> json) => _$CardWidgetStateFromJson(json);

@override@JsonKey() final  bool faceUp;
@override@JsonKey() final  bool reversed;

/// Create a copy of CardWidgetState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CardWidgetStateCopyWith<_CardWidgetState> get copyWith => __$CardWidgetStateCopyWithImpl<_CardWidgetState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CardWidgetStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CardWidgetState&&(identical(other.faceUp, faceUp) || other.faceUp == faceUp)&&(identical(other.reversed, reversed) || other.reversed == reversed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,faceUp,reversed);

@override
String toString() {
  return 'CardWidgetState(faceUp: $faceUp, reversed: $reversed)';
}


}

/// @nodoc
abstract mixin class _$CardWidgetStateCopyWith<$Res> implements $CardWidgetStateCopyWith<$Res> {
  factory _$CardWidgetStateCopyWith(_CardWidgetState value, $Res Function(_CardWidgetState) _then) = __$CardWidgetStateCopyWithImpl;
@override @useResult
$Res call({
 bool faceUp, bool reversed
});




}
/// @nodoc
class __$CardWidgetStateCopyWithImpl<$Res>
    implements _$CardWidgetStateCopyWith<$Res> {
  __$CardWidgetStateCopyWithImpl(this._self, this._then);

  final _CardWidgetState _self;
  final $Res Function(_CardWidgetState) _then;

/// Create a copy of CardWidgetState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? faceUp = null,Object? reversed = null,}) {
  return _then(_CardWidgetState(
faceUp: null == faceUp ? _self.faceUp : faceUp // ignore: cast_nullable_to_non_nullable
as bool,reversed: null == reversed ? _self.reversed : reversed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
