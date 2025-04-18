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

    on<BulkCardDealCards>((event, emit) async {
      verbose("BulkCardControlBloc on<BulkCardDealCards event");
      verbose("  event is $event");

      DeckRepository deck = sl<DeckRepository>();
      await deck.shuffleDeck();
      Option<Iterable<DealtCard>> cardsOut = None();

      verbose("  dealing cards");
      List<DealtCard> deal =
          (await deck.dealtCardQueue.take(event.howMany)).toList();

      if (deal.isNotEmpty) {
        cardsOut = Option<Iterable<DealtCard>>.of(deal);
      }

      verbose("  dealt cards is $cardsOut");

      if (deal.isNotEmpty) {
        emit(state.copyWith(cards: cardsOut));
      }
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
