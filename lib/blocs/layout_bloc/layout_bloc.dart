import 'package:flutter/material.dart';
import 'package:tarot_again/blocs/blocs.dart';
import 'package:tarot_again/data_layer/data_layer.dart';
import 'package:tarot_again/util/util.dart';

part 'layout_bloc.freezed.dart';
part 'layout_bloc.g.dart';

/// layout_event contains all of the events for this bloc
part 'layout_event.dart';

/// layout_state contains state for this bloc
part 'layout_state.dart';

/// extension [RangeGen] on [int]
/// very simple extension, with one method.
extension RangeGen on int {
  /// [range] is a generator that produces values from 0 up to the int it's applied to.
  /// it's useful replacing a for (var i=0; i<someInt; i++) (and that's all its useful for)
  Iterable<int> range() sync* {
    for (var i = 0; i < this; i++) {
      yield i;
    }
  }
}

typedef KeyCardMap = IMap<SlotBloc, DealtCard>;

class LayoutBloc extends HydratedBloc<LayoutEvent, LayoutState> with Logging {
  late final LayoutRepository layoutRepository;

  IMap mapByKey = const IMap<SlotWidgetBloc, DealtCard>.empty();
  IMap mapByName = const IMap<String, DealtCard>.empty();

  IList<SlotBloc> orderedKeyList = const IList<SlotBloc>.empty();
  IList<DealtCard> orderedCardList = const IList<DealtCard>.empty();

  LayoutBloc._() : super(const LayoutState.layoutInitial()) {
    layoutRepository = sl<LayoutRepository>();

    on<Starting>(
      (event, emit) => emit(
        state.copyWith(
          layoutNames: IList<String>(layoutRepository.listLayouts),
        ),
      ),
    );

    on<SetLayoutNames>(
      (event, emit) => emit(
        state.copyWith(layoutNames: IList<String>(event.newLayoutNames)),
      ),
    );

    on<SetNewLayout>((SetNewLayout event, emit) {
      verbose("received SetNewLayout, ${event.newLayout}");

      mapByKey = const KeyCardMap.empty();
      mapByName = const IMap<String, DealtCard>.empty();

      orderedKeyList = const IList<SlotBloc>.empty();
      orderedCardList = const IList<DealtCard>.empty();

      final TarotLayout layout = layoutRepository.getLayoutByDisplayName(
        event.newLayout,
      );
      verbose("  layout is $layout");

      for (var index in layout.numCards.range()) {
        orderedKeyList = orderedKeyList.add(SlotBloc());
      }

      verbose("  slotKeys is $mapByKey");

      final LayoutStateSlotsAssigned newState = LayoutStateSlotsAssigned(
        currentLayoutName: event.newLayout,
        currentLayout: layout,
        layoutNames: state.layoutNames,
        slotKeys: orderedKeyList,
      );
      verbose("  emitting new state $newState");

      emit(newState);
    });

    on<DealCards>((event, emit) async {
      if (state is LayoutStateSlotsAssigned) {
        verbose("received DealCards event");

        verbose("  state is $state");

        final deckRepository = sl<DeckRepository>();

        await deckRepository.shuffleDeck();

        final cards = await deckRepository.dealtCardQueue.take(
          state.currentLayout.numCards,
        );
        verbose("  cards: take produced ${cards.length} items");

        orderedCardList = IList<DealtCard>(cards);
        verbose("  orderedKeyList is ${orderedKeyList.length} long");
        verbose("  orderedCardList is ${orderedCardList.length} long");

        mapByKey = KeyCardMap.fromIterables(orderedKeyList, orderedCardList);

        verbose("  cards is ${cards.length} long, $cards");
        verbose("  emitting new state with dealtCards: cards");

        final newState = LayoutStateCardsAssigned(
          currentLayoutName: state.currentLayoutName,
          currentLayout: state.currentLayout,
          layoutNames: state.layoutNames,
          slotKeys: orderedKeyList,
          dealtCards: orderedCardList,
        );

        // the trick with states is that every new state for which an Iterable is changed,
        // the state's iterables need to be fresh copies with different identities. Hence, IList copies.
        emit(newState);
      }
    });

    on<SlotWidgetReadyForCard>((event, emit) {
      verbose("received SlotWidgetReadyForCard");

      if (state is LayoutStateCardsAssigned) {
        verbose("  state is LayoutCardsSlotAssigned");

        LayoutStateCardsAssigned st = state as LayoutStateCardsAssigned;

        final DealtCard? card = mapByKey.get(event.key);
        verbose("  card is $card");
        if (card != null) {
          event.key.currentState?.setDealtCard(card);
        }
      }
    });

    add(LayoutEvent.starting());
  }

  @override
  LayoutState? fromJson(Map<String, dynamic> json) =>
      LayoutState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(LayoutState state) => state.toJson();

  factory LayoutBloc() {
    if (!sl.isRegistered<LayoutBloc>()) {
      sl.registerSingleton<LayoutBloc>(LayoutBloc._());
    }

    return sl<LayoutBloc>();
  }
}
