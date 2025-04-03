part of 'bulk_card_control_bloc.dart';

@freezed
abstract class BulkCardControlState with _$BulkCardControlState {
  factory BulkCardControlState({
    required bool everybodyFaceUp,
    required bool reversalsAllowed,
  }) = _BulkCardControlState;

  factory BulkCardControlState.fromJson(Map<String, Object?> json) =>
      _$BulkCardControlStateFromJson(json);
}

//
// @freezed
// class BulkCardControlState with _$BulkCardControlState {
//   // final bool reversalsAllowed;
//
//   // if, and only if, everybodyFaceUp is true, then all cards turn face up.
//   // otherwise, cards determine their face-upedness individually.
//   // final bool everybodyFaceUp;
//
//   factory BulkCardControlState({
//     required bool reversalsAllowed,
//     required bool everybodyFaceUp,
//   }) => _BulkCardControlState;
//
//   factory BulkCardControlState.fromJson(Map<String, dynamic> json) =>
//       _$BulkCardControlStateFromJson(json);
//
// Map<String, dynamic> toJson() => _$BulkCardControlStateToJson(this);
//
// BulkCardControlState copyWith({
//   bool? reversalsAllowed,
//   bool? everybodyFaceUp,
// }) =>
//     BulkCardControlState(
//       reversalsAllowed: reversalsAllowed ?? this.reversalsAllowed,
//       everybodyFaceUp: everybodyFaceUp ?? this.everybodyFaceUp
//     );
//
// @override
// List<Object?> get props => [ reversalsAllowed, everybodyFaceUp ];
// }