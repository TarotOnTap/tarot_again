import 'package:fpdart/fpdart.dart';
import 'package:tarot_again/blocs/blocs.dart';
import 'package:tarot_again/util/util.dart';

part 'bulk_card_control_bloc.freezed.dart';
part 'bulk_card_control_bloc.g.dart';
part 'bulk_card_control_event.dart';
part 'bulk_card_control_state.dart';

// this is a very simple bloc, and it is used to control bulk aspects of our
// dealt cards - are reversals allowed? Some readers don't want them, so we offer
// a visual control to permit or deny them. NOTE - cards will still be dealt with
// reversals, but the display widget will use our state as a master switch, like so:
// if (di<BulkCardControlBloc>().state.reversalsAllowed && card.reversed)...
class BulkCardControlBloc
    extends HydratedBloc<BulkCardControlEvent, BulkCardControlState> {
  BulkCardControlBloc() : super(BulkCardControlState()) {
    on<AllowReversals>(
      (event, emit) => emit(state.copyWith(reversalsAllowed: true)),
    );

    on<DisallowReversals>(
      (event, emit) => emit(state.copyWith(reversalsAllowed: false)),
    );

    on<TurnEverybodyFaceUpOn>(
      (event, emit) => emit(state.copyWith(everybodyFaceUp: true)),
    );

    on<TurnEverybodyFaceUpOff>(
      (event, emit) => emit(state.copyWith(everybodyFaceUp: false)),
    );

    on<AddCardPosition>((event, emit) {
      Option<CardPositions> toEmit = state.positions.fold(
        () => Option<CardPositions>.of(CardPositions([event.position])),
        (CardPositions l) => Option<CardPositions>.of(l.add(event.position)),
      );

      emit(state.copyWith(positions: toEmit));
    });

    on<SetDeckName>((event, emit) {
      // this one is actually some hard work!

      // TODO: update the deck name where it matters - AssetProvider, StandardDeckProvider,
      // TODO: DeckRepository

      emit(state.copyWith(deckName: event.deckName));
    });
  }

  @override
  BulkCardControlState? fromJson(Map<String, dynamic> json) =>
      BulkCardControlState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(BulkCardControlState state) => state.toJson();
}

Future<void> initializeBulkCardControlBloc() async {
  if (!sl.isRegistered<BulkCardControlBloc>()) {
    sl.registerSingleton<BulkCardControlBloc>(BulkCardControlBloc());
  }
}
