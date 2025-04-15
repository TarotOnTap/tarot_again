import 'package:tarot_again/data_layer/data_layer.dart';
import 'package:tarot_again/util/util.dart';

import '../blocs.dart';

part 'card_widget_bloc.freezed.dart';
part 'card_widget_bloc.g.dart';
part 'card_widget_event.dart';
part 'card_widget_state.dart';

class CardWidgetBloc extends HydratedBloc<CardWidgetEvent, CardWidgetState> {
  final String _id;

  @override
  String get id => _id;

  CardWidgetBloc({required String id, required card})
    : _id = id,
      super(CardWidgetState(card: card)) {
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
  }

  @override
  fromJson(Map<String, dynamic> json) => CardWidgetState.fromJson(json);

  @override
  toJson(CardWidgetState state) => state.toJson();
}
