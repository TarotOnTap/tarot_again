part of 'card_widget_bloc.dart';

@immutable
sealed class CardWidgetEvent {}

@immutable
class CardWidgetFaceUpEvent extends CardWidgetEvent {}

@immutable
class CardWidgetFaceDownEvent extends CardWidgetEvent {}

@immutable
class CardWidgetFlipFaceEvent extends CardWidgetEvent {}

@immutable
class CardWidgetSetReverseEvent extends CardWidgetEvent {
  final bool reverse;

  CardWidgetSetReverseEvent({required this.reverse});
}

@immutable
class CardWidgetFlipReverseEvent extends CardWidgetEvent {}

//
// @immutable
// class CardWidgetSetCardEvent extends CardWidgetEvent {
//   final TCModel card;
//
//   CardWidgetSetCardEvent(this.card);
// }
//
// @immutable
// class CardWidgetSetDescriptionEvent extends CardWidgetEvent {
//   final String description;
//
//   CardWidgetSetDescriptionEvent(this.description);
// }
//
// @immutable
// class CardWidgetSetUprightMeaningEvent extends CardWidgetEvent {
//   final String uprightMeaning;
//
//   CardWidgetSetUprightMeaningEvent(this.uprightMeaning);
// }
//
// @immutable
// class CardWidgetSetReversedMeaningEvent extends CardWidgetEvent {
//   final String reversedMeaning;
//
//   CardWidgetSetReversedMeaningEvent({required this.reversedMeaning});
// }