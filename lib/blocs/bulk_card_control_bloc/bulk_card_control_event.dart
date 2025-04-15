part of 'bulk_card_control_bloc.dart';

@immutable
sealed class BulkCardControlEvent implements BlocWidgetEvent {}

@immutable
class AllowReversals extends BulkCardControlEvent {}

@immutable
class DisallowReversals extends BulkCardControlEvent {}

class TurnEverybodyFaceUpOn extends BulkCardControlEvent {}

class TurnEverybodyFaceUpOff extends BulkCardControlEvent {}

@immutable
class SetDeckName extends BulkCardControlEvent {
  final String deckName;

  SetDeckName(this.deckName);
}

@immutable
class AddCardPosition extends BulkCardControlEvent {
  final CardPosition position;

  AddCardPosition(this.position);
}

@immutable
class BulkCardDealCards extends BulkCardControlEvent {
  final int howMany;

  BulkCardDealCards(this.howMany);
}
