import 'package:flutter/material.dart';
import 'package:tarot_again/blocs/blocs.dart';
import 'package:tarot_again/data_layer/data_layer.dart';
import 'package:tarot_again/ui_layer/ui_layer.dart';
import 'package:tarot_again/util/util.dart';

part 'layout_bloc.freezed.dart';
part 'layout_bloc.g.dart';
part 'layout_event.dart';
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

class LayoutBloc extends HydratedBloc<LayoutEvent, LayoutState> with Logging {
  late final LayoutRepository layoutRepository;

  LayoutBloc._() : super(const LayoutState.layoutInitial()) {
    layoutRepository = sl<LayoutRepository>();

    on<Starting>(
      (event, emit) =>
          emit(state.copyWith(layoutNames: layoutRepository.listLayouts)),
    );

    on<SetLayoutNames>(
      (event, emit) => emit(state.copyWith(layoutNames: event.newLayoutNames)),
    );

    on<SetNewLayout>((SetNewLayout event, emit) {
      final layoutNames = layoutRepository.layoutDisplayNames;
      final TarotLayout layout = layoutRepository.getLayoutByDisplayName(
        event.newLayout,
      );

      KeyIterable slotKeys = layout.numCards.range().map((item) => GlobalKey());

      emit(
        LayoutState.layoutStateReadyToDeal(
          currentLayoutName: event.newLayout,
          currentLayout: layout,
          layoutNames: layoutNames,
          slotKeys: slotKeys,
        ),
      );
    });

    on<DealCards>((event, emit) async {
      if (state is LayoutStateReadyToDeal) {
        final deckRepository = sl<DeckRepository>();

        deckRepository.shuffleDeck();

        final cards = await deckRepository.dealtCardQueue.take(
          state.currentLayout.numCards,
        );

        var keys = IList<SlotKey>((state as LayoutStateReadyToDeal).slotKeys);
        var c = IList<DealtCard>(cards);

        for (var (k, item) in keys.zip(c)) {
          k.currentState?.setDealtCard(item);
        }

        emit(
          LayoutState.layoutStateDealt(
            layoutNames: state.layoutNames,
            currentLayoutName: state.currentLayoutName,
            currentLayout: state.currentLayout,
            dealtCards: cards,
            slotKeys: (state as LayoutStateReadyToDeal).slotKeys,
          ),
        );
      }
    });

    add(LayoutEvent.starting());
  }

  @override
  LayoutState? fromJson(Map<String, dynamic> json) {
    final state = LayoutState.fromJson(json);

    // switch (state) {}

    return state;
  }

  @override
  Map<String, dynamic>? toJson(LayoutState state) => state.toJson();

  factory LayoutBloc() {
    if (!sl.isRegistered<LayoutBloc>()) {
      sl.registerSingleton<LayoutBloc>(LayoutBloc._());
    }

    return sl<LayoutBloc>();
  }
}
