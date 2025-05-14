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
part 'slot_state.dart';

typedef SWStates = IMap<int, SlotState>;

// class LayoutBloc extends HydratedBloc<LayoutEvent, LayoutState> with Logging {
class LayoutBloc extends Bloc<LayoutEvent, LayoutState> with Logging {
  late final LayoutRepository layoutRepository;

  LayoutBloc._() : super(const LayoutState(/* newLayout: NewLayout.yes */)) {
    verbose("LayoutBloc._()");
    layoutRepository = sl<LayoutRepository>();

    on<LayoutStarting>((event, emit) async {
      verbose("LayoutBloc:on<LayoutStarting");
      // This is one way to get layout names into the state.
      // the other would be to have LayoutRepository add a different event on us
      // that signals the list of layout display names is ready, and have that handler
      // emit the new state. The async happens elsewhere.
      // For now, this seems to work fine - and it should.

      await layoutRepository.loadLayouts();
      verbose("  awaited layoutRepository.loadLayouts()");

      add(SetNewLayout(newLayout: "Empty Layout"));
      verbose("  added SetNewLayout empty layout");
      emit(state.copyWith(layoutNames: layoutRepository.layoutDisplayNames));
      verbose(
        "  emitted new state with layoutNames: ${layoutRepository.layoutDisplayNames}",
      );
    });

    on<SetNewLayout>((SetNewLayout event, emit) {
      verbose("LayoutBloc: on<SetNewLayout>; newLayout is ${event.newLayout}");
      final TarotLayout layout = layoutRepository.getLayoutByDisplayName(
        event.newLayout,
      );

      if (layout.displayName != state.currentLayout.displayName) {
        final titles =
            switch (layout) {
              HorizontalLinear(slotNames: var slotNames) => slotNames,
              _ => layout.numCards.range().map((_) => ""),
            }.toIList();

        final slotData = layout.numCards.range().fold(
          const SWStates.empty(),
          (prev, index) => prev.add(
            index,
            SlotStateNotDealt(slotIndex: index, slotName: titles[index]),
          ),
        );

        emit(
          state.copyWith(
            currentLayoutName: event.newLayout,
            currentLayout: layout,
            slotStates: slotData,
            slotNames: titles,
          ),
        );
      }
    });

    on<DealCards>((event, emit) async {
      verbose("on<DealCards>");
      final dr = sl<DeckRepository>();

      verbose("  awaiting shuffleDeck()");
      await dr.shuffleDeck();

      verbose(
        "  awaiting the take of ${state.currentLayout.numCards} from the dealtCardQueue",
      );
      final cards = await dr.dealtCardQueue.take(state.currentLayout.numCards);
      verbose("  received $cards from the dealtCardQueue");

      final newStates = state.currentLayout.numCards.range().fold(
        const SWStates.empty(),
        (prev, index) => prev.add(
          index,
          SlotStateDealt(
            slotIndex: index,
            slotName: state.slotNames[index],
            faceUp: false,
            card: cards[index],
          ),
        ),
      );

      emit(state.copyWith(slotStates: newStates));
    });

    on<SlotWidgetFlipFaceEvent>(
      (event, emit) => _changeDealtState(
        index: event.index,
        changer: (s) => s.copyWith(faceUp: !s.faceUp),
      )?.also((c) => emit(state.copyWith(slotStates: c))),
    );

    on<SlotWidgetFaceUpEvent>(
      (event, emit) => _changeDealtState(
        index: event.index,
        changer: (s) => s.copyWith(faceUp: true),
      )?.also((c) => emit(state.copyWith(slotStates: c))),
    );

    on<SlotWidgetFaceDownEvent>(
      (event, emit) => _changeDealtState(
        index: event.index,
        changer: (s) => s.copyWith(faceUp: false),
      )?.also((c) => emit(state.copyWith(slotStates: c))),
    );

    add(LayoutStarting());
  }

  SWStates? _changeDealtState({
    required int index,
    required SlotStateDealt Function(SlotStateDealt) changer,
  }) {
    SWStates? retVal;

    if (state.slotStates[index] case SlotStateDealt d) {
      final newState = changer(d);

      retVal = state.slotStates.update(index, (ps) => newState);
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
