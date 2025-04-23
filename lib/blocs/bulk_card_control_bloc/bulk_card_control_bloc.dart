import 'package:fpdart/fpdart.dart';
import 'package:tarot_again/blocs/blocs.dart';
import 'package:tarot_again/data_layer/data_layer.dart';
import 'package:tarot_again/util/util.dart';

part 'bulk_card_control_bloc.freezed.dart';
part 'bulk_card_control_bloc.g.dart';
part 'bulk_card_control_event.dart';
part 'bulk_card_control_state.dart';

class BulkCardControlBloc
    extends HydratedBloc<BulkCardControlEvent, BulkCardControlState>
    with Logging {
  BulkCardControlBloc._() : super(BulkCardControlState()) {
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

  factory BulkCardControlBloc() {
    if (!sl.isRegistered<BulkCardControlBloc>()) {
      sl.registerSingleton<BulkCardControlBloc>(BulkCardControlBloc._());
    }

    return sl<BulkCardControlBloc>();
  }
}
