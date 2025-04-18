import 'package:flutter/material.dart';
import 'package:tarot_again/data_layer/data_layer.dart';
import 'package:tarot_again/util/util.dart';

import '../blocs.dart';

part 'slot_widget_bloc.freezed.dart';
part 'slot_widget_event.dart';
part 'slot_widget_state.dart';

class SlotWidgetBloc extends Bloc<SlotWidgetEvent, SlotWidgetState> {
  SlotWidgetBloc({required Key slotKey})
    : super(SlotWidgetStateNotDealt(slotKey: slotKey)) {
    on<SlotWidgetFaceUpEvent>((event, emit) {
      if (state is SlotWidgetStateDealt) {
        emit((state as SlotWidgetStateDealt).copyWith(faceUp: true));
      }
    });

    on<SlotWidgetFaceDownEvent>((event, emit) {
      if (state is SlotWidgetStateDealt) {
        emit((state as SlotWidgetStateDealt).copyWith(faceUp: false));
      }
    });

    on<SlotWidgetFlipFaceEvent>((event, emit) {
      if (state is SlotWidgetStateDealt) {
        final SlotWidgetStateDealt _state = state as SlotWidgetStateDealt;

        emit(_state.copyWith(faceUp: _state.faceUp));
      }
    });

    on<SlotWidgetSetCardEvent>(
      (event, emit) => emit(
        SlotWidgetState.dealt(
          slotKey: slotKey,
          faceUp: false,
          card: event.card,
        ),
      ),
    );
  }
}
