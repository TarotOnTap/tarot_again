import 'package:bloc/bloc.dart';

import 'package:tarot_again/util/util.dart';

part 'bulk_card_control_event.dart';
part 'bulk_card_control_state.dart';

// this is a very simple bloc, and it is used to control bulk aspects of our
// dealt cards - are reversals allowed? Some readers don't want them, so we offer
// a visual control to permit or deny them. NOTE - cards will still be dealt with
// reversals, but the display widget will use our state as a master switch, like so:
// if (di<BulkCardControlBloc>().state.reversalsAllowed && card.reversed)...
class BulkCardControlBloc extends Bloc<BulkCardControlEvent, BulkCardControlState> {
  BulkCardControlBloc() : super(BulkCardControlState()) {
    on<AllowReversals>((event, emit) =>
      emit(state.copyWith(reversalsAllowed: true)));

    on<DisallowReversals>((event, emit) =>
        emit(state.copyWith(reversalsAllowed: false)));

    on<TurnEverybodyFaceUpOn>((event, emit) =>
        emit(state.copyWith(everybodyFaceUp: true)));

    on<TurnEverybodyFaceUpOff>((event, emit) =>
        emit(state.copyWith(everybodyFaceUp: false)));
  }
}