

part of 'card_widget_bloc.dart';

@immutable
sealed class CardWidgetEvent extends Equatable {
  const CardWidgetEvent();

  @override
  List<Object> get props => [];
}

@immutable
class CardWidgetFaceUpEvent extends CardWidgetEvent {
  const CardWidgetFaceUpEvent() : super();
}

@immutable
class CardWidgetFaceDownEvent extends CardWidgetEvent {
  const CardWidgetFaceDownEvent() : super();
}

@immutable
class CardWidgetFlipFaceEvent extends CardWidgetEvent {
  const CardWidgetFlipFaceEvent() : super();
}

@immutable
class CardWidgetSetReverseEvent extends CardWidgetEvent {
  final bool reverse;
  const CardWidgetSetReverseEvent(this.reverse) : super();

  @override
  List<Object> get props => [ reverse ];
}

@immutable
class CardWidgetFlipReverseEvent extends CardWidgetEvent {
  const CardWidgetFlipReverseEvent() : super();
}

@immutable
class CardWidgetSetFaceEvent extends CardWidgetEvent {
  final Widget face;

  const CardWidgetSetFaceEvent({required this.face}) : super();

  @override
  List<Object> get props => [ face ];
}

@immutable
class CardWidgetSetBackEvent extends CardWidgetEvent {
  final Widget back;

  const CardWidgetSetBackEvent({required this.back}) : super();

  @override
  List<Object> get props => [ back ];
}

@immutable
class CardWidgetSetDescriptionEvent extends CardWidgetEvent {
  final String description;

  const CardWidgetSetDescriptionEvent(this.description) : super();

  @override
  List<Object> get props => [ description ];
}

@immutable
class CardWidgetSetUprightMeaningEvent extends CardWidgetEvent {
  final String uprightMeaning;

  const CardWidgetSetUprightMeaningEvent(this.uprightMeaning) : super();

  @override
  List<Object> get props => [ uprightMeaning ];
}

@immutable
class CardWidgetSetReversedMeaningEvent extends CardWidgetEvent {
  final String reversedMeaning;

  const CardWidgetSetReversedMeaningEvent({required this.reversedMeaning}) : super();

  @override
  List<Object> get props => [ reversedMeaning ];
}