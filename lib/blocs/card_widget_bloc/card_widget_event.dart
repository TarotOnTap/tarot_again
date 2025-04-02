

part of 'card_widget_bloc.dart';

@immutable
sealed class CardWidgetEvent extends Equatable {
  const CardWidgetEvent();
}

@immutable
class CardWidgetLoadAssetsEvent extends CardWidgetEvent {
  const CardWidgetLoadAssetsEvent() : super();

  @override
  List<Object> get props => [];
}

@immutable
class CardWidgetFaceUpEvent extends CardWidgetEvent {
  const CardWidgetFaceUpEvent() : super();

  @override
  List<Object> get props => [];

}

@immutable
class CardWidgetFaceDownEvent extends CardWidgetEvent {
  const CardWidgetFaceDownEvent() : super();

  @override
  List<Object> get props => [];
}

@immutable
class CardWidgetFlipFaceEvent extends CardWidgetEvent {
  const CardWidgetFlipFaceEvent() : super();

  @override
  List<Object> get props => [ ];
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

  @override
  List<Object> get props => [ ];
}

@immutable
class CardWidgetSetFaceEvent extends CardWidgetEvent {
  final Widget? face;

  const CardWidgetSetFaceEvent({this.face}) : super();

  @override
  List<Object?> get props => [ face ];
}

@immutable
class CardWidgetSetBackEvent extends CardWidgetEvent {
  final Widget? back;

  const CardWidgetSetBackEvent({this.back}) : super();

  @override
  List<Object?> get props => [ back ];
}