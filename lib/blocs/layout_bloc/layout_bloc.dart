import 'package:tarot_again/blocs/blocs.dart';
import 'package:tarot_again/data_layer/data_layer.dart';
import 'package:tarot_again/util/util.dart';

part 'layout_bloc.freezed.dart';
part 'layout_bloc.g.dart';

/// layout_event contains all of the events for this bloc
part 'layout_event.dart';

/// layout_state contains state for this bloc
part 'layout_state.dart';

/// slot_widget_state contains sub-state for PositionSlotWidgets
part 'slot_widget_state.dart';

typedef SWStates = IMap<int, SlotWidgetState>;

// class LayoutBloc extends HydratedBloc<LayoutEvent, LayoutState> with Logging {
class LayoutBloc extends Bloc<LayoutEvent, LayoutState> with Logging {
  late final LayoutRepository layoutRepository;

  LayoutBloc._() : super(const LayoutState(/* newLayout: NewLayout.yes */)) {
    layoutRepository = sl<LayoutRepository>();

    on<LayoutStarting>((event, emit) async {
      // This is one way to get layout names into the state.
      // the other would be to have LayoutRepository add a different event on us
      // that signals the list of layout display names is ready, and have that handler
      // emit the new state. The async happens elsewhere.
      // For now, this seems to work fine - and it should.
      await layoutRepository.cacheLayouts();

      add(SetNewLayout(newLayout: "Empty Layout"));
      emit(state.copyWith(layoutNames: layoutRepository.layoutDisplayNames));
    });

    on<SetNewLayout>((SetNewLayout event, emit) {
      final TarotLayout layout = layoutRepository.getLayoutByDisplayName(
        event.newLayout,
      );

      if (layout.displayName != state.currentLayout.displayName) {
        final titles =
            switch (layout) {
              HorizontalLinear(slotNames: var slotNames) => slotNames,
              _ => layout.numCards.range().map((_) => "slot name"),
            }.toIList();

        final slotData = layout.numCards.range().fold(
          const SWStates.empty(),
          (prev, index) => prev.add(
            index,
            SlotWidgetStateNotDealt(slotIndex: index, slotName: titles[index]),
          ),
        );

        emit(
          state.copyWith(
            currentLayoutName: event.newLayout,
            currentLayout: layout,
            slotWidgetStates: slotData,
            slotNames: titles,
          ),
        );
      }
    });

    // on<AddSlotBloc>((event, emit) {
    //   SWStates addNew = const SWStates.empty();
    //
    //   final int idx = event.newBloc.state.slotIndex;
    //
    //   if (!state.slotWidgetStates.containsKey(idx)) {
    //     addNew = state.slotWidgetStates.add(idx, event.newBloc);
    //
    //     emit(state.copyWith(slotWidgetStates: addNew));
    //   }
    // });

    on<DealCards>((event, emit) async {
      final dr = sl<DeckRepository>();

      await dr.shuffleDeck();

      final cards = await dr.dealtCardQueue.take(state.currentLayout.numCards);

      final newStates = state.currentLayout.numCards.range().fold(
        const SWStates.empty(),
        (prev, index) => prev.add(
          index,
          SlotWidgetStateDealt(
            slotIndex: index,
            slotName: state.slotNames[index],
            faceUp: false,
            card: cards[index],
          ),
        ),
      );

      emit(state.copyWith(slotWidgetStates: newStates));
    });

    on<SlotWidgetFlipFaceEvent>(
      (event, emit) => _changeDealtState(
        index: event.index,
        changer: (s) => s.copyWith(faceUp: !s.faceUp),
      )?.also((c) => emit(state.copyWith(slotWidgetStates: c))),
    );

    on<SlotWidgetFaceUpEvent>(
      (event, emit) => _changeDealtState(
        index: event.index,
        changer: (s) => s.copyWith(faceUp: true),
      )?.also((c) => emit(state.copyWith(slotWidgetStates: c))),
    );

    on<SlotWidgetFaceDownEvent>(
      (event, emit) => _changeDealtState(
        index: event.index,
        changer: (s) => s.copyWith(faceUp: false),
      )?.also((c) => emit(state.copyWith(slotWidgetStates: c))),
    );

    add(LayoutStarting());
  }

  SWStates? _changeDealtState({
    required int index,
    required SlotWidgetStateDealt Function(SlotWidgetStateDealt) changer,
  }) {
    SWStates? retVal;

    if (state.slotWidgetStates[index] case SlotWidgetStateDealt d) {
      final newState = changer(d);

      retVal = state.slotWidgetStates.update(index, (ps) => newState);
    }

    return retVal;
  }

  // these next two are for use with HydratedBloc, keep 'em around
  // @override
  // LayoutState? fromJson(Map<String, dynamic> json) =>
  //     LayoutState.fromJson(json);
  //
  // @override
  // Map<String, dynamic>? toJson(LayoutState state) => state.toJson();

  factory LayoutBloc() {
    if (!sl.isRegistered<LayoutBloc>()) {
      sl.registerSingleton<LayoutBloc>(LayoutBloc._());
    }

    return sl<LayoutBloc>();
  }
}
