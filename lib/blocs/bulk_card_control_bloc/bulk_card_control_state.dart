part of 'bulk_card_control_bloc.dart';

class BulkCardControlState extends Equatable {
  final bool reversalsAllowed;

  // if, and only if, everybodyFaceUp is true, then all cards turn face up.
  // otherwise, cards determine their face-upedness individually.
  final bool everybodyFaceUp;

  const BulkCardControlState({this.reversalsAllowed=true, this.everybodyFaceUp=false});

  BulkCardControlState copyWith({bool? reversalsAllowed, bool? everybodyFaceUp}) =>
      BulkCardControlState(
        reversalsAllowed: reversalsAllowed ?? this.reversalsAllowed,
        everybodyFaceUp: everybodyFaceUp ?? this.everybodyFaceUp
      );

  @override
  List<Object?> get props => [ reversalsAllowed, everybodyFaceUp ];
}