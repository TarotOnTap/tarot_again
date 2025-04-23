import 'package:tarot_again/data_layer/data_layer.dart';
import 'package:tarot_again/util/util.dart';

import '../blocs.dart';

part 'slot_widget_bloc.freezed.dart';
part 'slot_widget_bloc.g.dart';
part 'slot_widget_event.dart';

/// don't mess with this
/// don't mess with this
part 'slot_widget_state.dart';

/// don't mess with this
/// don't mess with this

class SlotWidgetBloc extends Bloc<SlotWidgetEvent, SlotWidgetState> {
  SlotWidgetBloc({required int slotIndex, String slotName = ""})
    : super(SlotWidgetStateNotDealt(slotIndex: slotIndex, slotName: slotName)) {
    on<SlotWidgetFaceUpEvent>((event, emit) {
      if (state case SlotWidgetStateDealt sd) emit(sd.copyWith(faceUp: true));
    });

    on<SlotWidgetFaceDownEvent>((event, emit) {
      if (state case SlotWidgetStateDealt sd) emit(sd.copyWith(faceUp: false));
    });

    on<SlotWidgetFlipFaceEvent>((event, emit) {
      if (state case SlotWidgetStateDealt sd) {
        emit(sd.copyWith(faceUp: !sd.faceUp));
      }
    });

    on<SlotWidgetSetCardEvent>(
      (event, emit) => emit(
        SlotWidgetStateDealt(
          slotIndex: state.slotIndex,
          slotName: state.slotName,
          faceUp: false,
          card: event.card,
        ),
      ),
    );
  }
}
