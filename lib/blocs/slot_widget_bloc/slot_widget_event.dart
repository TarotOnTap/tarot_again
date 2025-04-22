part of 'slot_widget_bloc.dart';

@immutable
sealed class SlotWidgetEvent implements BlocWidgetEvent {}

@immutable
class SlotWidgetFaceUpEvent extends SlotWidgetEvent {}

@immutable
class SlotWidgetFaceDownEvent extends SlotWidgetEvent {}

@immutable
class SlotWidgetFlipFaceEvent extends SlotWidgetEvent {}

@immutable
class SlotWidgetSetCardEvent extends SlotWidgetEvent {
  final DealtCard card;

  SlotWidgetSetCardEvent(this.card);
}
