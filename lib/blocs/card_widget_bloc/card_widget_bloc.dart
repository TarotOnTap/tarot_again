import 'package:tarot_again/data_layer/data_layer.dart';
import 'package:tarot_again/util/util.dart';

// part 'card_widget_bloc.freezed.dart';
part 'card_widget_bloc.freezed.dart';
part 'card_widget_bloc.g.dart';
part 'card_widget_event.dart';
part 'card_widget_state.dart';

class CardWidgetBloc extends Bloc<CardWidgetEvent, CardWidgetState> {
  CardWidgetBloc() : super(CardWidgetState()) {
    on<CardWidgetFaceUpEvent>(
      (event, emit) => emit(state.copyWith(faceUp: true)),
    );

    on<CardWidgetFaceDownEvent>(
      (event, emit) => emit(state.copyWith(faceUp: false)),
    );

    on<CardWidgetFlipFaceEvent>(
      (event, emit) => emit(state.copyWith(faceUp: !state.faceUp)),
    );

    on<CardWidgetSetReverseEvent>(
      (event, emit) => emit(state.copyWith(reversed: event.reverse)),
    );

    on<CardWidgetFlipReverseEvent>(
      (event, emit) => emit(state.copyWith(reversed: !state.reversed)),
    );

    on<CardWidgetSetDescriptionEvent>(
      (event, emit) => emit(state.copyWith(description: event.description)),
    );

    on<CardWidgetSetUprightMeaningEvent>(
      (event, emit) =>
          emit(state.copyWith(uprightMeaning: event.uprightMeaning)),
    );

    on<CardWidgetSetReversedMeaningEvent>(
      (event, emit) =>
          emit(state.copyWith(reversedMeaning: event.reversedMeaning)),
    );
  }
}