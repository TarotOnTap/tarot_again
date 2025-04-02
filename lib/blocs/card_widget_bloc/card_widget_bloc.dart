import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';

import 'package:tarot_again/util/util.dart';
import 'package:tarot_again/data_layer/data_layer.dart';

part 'card_widget_event.dart';
part 'card_widget_state.dart';

class CardWidgetBloc extends Bloc<CardWidgetEvent, CardWidgetState> {
  CardWidgetBloc({required TCModel card}) : super(CardWidgetState(card: card)) {
    on<CardWidgetFaceUpEvent>((event, emit) =>
        emit(state.copyWith(faceUp: true)));

    on<CardWidgetFaceDownEvent>((event, emit) =>
        emit(state.copyWith(faceUp: false)));

    on<CardWidgetFlipFaceEvent>((event, emit) =>
      emit(state.copyWith(faceUp: !state.faceUp)));

    on<CardWidgetSetReverseEvent>((event, emit) =>
      emit(state.copyWith(reversed: event.reverse)));

    on<CardWidgetFlipReverseEvent>((event, emit) =>
      emit(state.copyWith(reversed: !state.reversed)));

    on<CardWidgetSetFaceEvent>((event, emit) =>
      emit(state.copyWith(face: event.face)));

    on<CardWidgetSetBackEvent>((event, emit) =>
      emit(state.copyWith(back: event.back)));

    on<CardWidgetSetDescriptionEvent>((event, emit) =>
      emit(state.copyWith(description: event.description)));

    on<CardWidgetSetUprightMeaningEvent>((event, emit) =>
      emit(state.copyWith(uprightMeaning: event.uprightMeaning)));

    on<CardWidgetSetReversedMeaningEvent>((event, emit) =>
      emit(state.copyWith(reversedMeaning: event.reversedMeaning)));
  }
}