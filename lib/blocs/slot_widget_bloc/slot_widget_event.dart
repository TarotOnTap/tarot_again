part of 'slot_widget_bloc.dart';

@immutable
sealed class SlotWidgetEvent implements BlocWidgetEvent {}

@immutable
class SlotWidgetFaceUpEvent extends SlotWidgetEvent {}

@immutable
class SlotWidgetFaceDownEvent extends SlotWidgetEvent {}

@immutable
class SlotWidgetFlipFaceEvent extends SlotWidgetEvent {}

// @immutable
// class SlotWidgetSetReverseEvent extends SlotWidgetEvent {
//   final bool reverse;
//
//   SlotWidgetSetReverseEvent({required this.reverse});
// }
//
// @immutable
// class SlotWidgetFlipReverseEvent extends SlotWidgetEvent {}

@immutable
class SlotWidgetSetCardEvent extends SlotWidgetEvent {
  final DealtCard card;

  SlotWidgetSetCardEvent(this.card);
}

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
