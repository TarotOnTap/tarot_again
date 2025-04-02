import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';

import 'package:tarot_again/util/util.dart';
import 'package:tarot_again/data_layer/data_layer.dart';

part 'card_widget_event.dart';
part 'card_widget_state.dart';

class CardWidgetBloc extends Bloc<CardWidgetEvent, CardWidgetState> {
  CardWidgetBloc({required DealtCard card}) : super(CardWidgetState(card: card)) {
    on<CardWidgetFaceUpEvent>((event, emit) =>
        emit(state.copyWith(faceUp: true)));

    on<CardWidgetFaceDownEvent>((event, emit) =>
        emit(state.copyWith(faceUp: false)));

    on<CardWidgetFlipFaceEvent>((event, emit) =>
      emit(state.copyWith(faceUp: !state.faceUp)));

    on<CardWidgetLoadAssetsEvent>((event, emit) =>
        _loadCardAssets(emit));
  }

  Future<void> _loadCardAssets(Emitter<CardWidgetState> emit) async {
    AssetProvider assetProvider = di<AssetProvider>();




  }
}