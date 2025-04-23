import 'package:tarot_again/blocs/blocs.dart';
import 'package:tarot_again/data_layer/data_layer.dart';
import 'package:tarot_again/util/util.dart';

part 'layout_bloc.freezed.dart';
part 'layout_bloc.g.dart';

/// layout_event contains all of the events for this bloc
part 'layout_event.dart';

/// layout_state contains state for this bloc
part 'layout_state.dart';

class LayoutBloc
    extends HydratedBloc<LayoutEvent, LayoutState> /* with Logging */ {
  late final LayoutRepository layoutRepository;

  LayoutBloc._() : super(const LayoutState()) {
    layoutRepository = sl<LayoutRepository>();

    on<LayoutStarting>((event, emit) async {
      await layoutRepository.cacheLayouts();

      emit(state.copyWith(layoutNames: layoutRepository.layoutDisplayNames));
    });

    on<SetNewLayout>((SetNewLayout event, emit) {
      final TarotLayout layout = layoutRepository.getLayoutByDisplayName(
        event.newLayout,
      );

      final (titles, states) = _makeSlotData();

      emit(
        state.copyWith(
          currentLayoutName: event.newLayout,
          currentLayout: layout,
          slotTitles: titles,
          slotWidgetStates: states,
          dealtCards: const IList<DealtCard>.empty(),
        ),
      );
    });

    on<DealCards>((event, emit) async {
      sl<DeckRepository>().also((deckRepository) async {
        sl<LayoutBloc>().state.currentLayout.also((layout) async {
          await deckRepository.shuffleDeck();
          final cards = await deckRepository.dealtCardQueue.take(
            layout.numCards,
          );

          final dealtCards = IList<DealtCard>(cards);
          // verbose("  dealtCards is $dealtCards");

          emit(state.copyWith(dealtCards: dealtCards));
        });
      });
    });

    add(LayoutStarting());
  }

  (IList<String>, IList<SlotWidgetState>) _makeSlotData() {
    // this gets called when a new layout is set
    IList<String> localTitles;
    IList<SlotWidgetState> localStates;

    localTitles =
        switch (state.currentLayout) {
          HorizontalLinear(slotNames: var slotNames) => slotNames,
          _ => state.currentLayout.numCards.range().map((_) => ""),
        }.toIList();

    localStates = state.currentLayout.numCards.range().fold(
      const IList<SlotWidgetState>.empty(),
      (prev, elem) => prev.add(
        SlotWidgetState.notDealt(slotIndex: elem, slotName: localTitles[elem]),
      ),
    );

    return (localTitles, localStates);
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
