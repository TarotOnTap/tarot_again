part of 'bulk_card_control_bloc.dart';

@immutable
sealed class BulkCardControlEvent extends Equatable {
  const BulkCardControlEvent() : super();

  @override
  List<Object> get props => [];
}

@immutable
class AllowReversals extends BulkCardControlEvent {
  const AllowReversals() : super();
}

@immutable
class DisallowReversals extends BulkCardControlEvent {
  const DisallowReversals() : super();
}

class TurnEverybodyFaceUpOn extends BulkCardControlEvent {
  const TurnEverybodyFaceUpOn() : super();
}

class TurnEverybodyFaceUpOff extends BulkCardControlEvent {
  const TurnEverybodyFaceUpOff() : super();
}