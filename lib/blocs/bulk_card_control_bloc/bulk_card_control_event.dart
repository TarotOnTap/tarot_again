part of 'bulk_card_control_bloc.dart';

@immutable
sealed class BulkCardControlEvent {}

@immutable
class AllowReversals extends BulkCardControlEvent {}

@immutable
class DisallowReversals extends BulkCardControlEvent {}

class TurnEverybodyFaceUpOn extends BulkCardControlEvent {}

class TurnEverybodyFaceUpOff extends BulkCardControlEvent {}
