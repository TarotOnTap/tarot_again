import 'package:flutter/material.dart';
import 'package:tarot_again/blocs/blocs.dart';
import 'package:tarot_again/data_layer/data_layer.dart';
import 'package:tarot_again/util/util.dart';

import 'layout_state_ready_to_deal_widget.dart';

class LayoutWidget extends StatefulWidget {
  const LayoutWidget({super.key});

  @override
  State<LayoutWidget> createState() => LayoutWidgetState();
}

class LayoutWidgetState extends State<LayoutWidget> with Logging {
  IList<SlotWidgetBloc> slotBlocs = const IList<SlotWidgetBloc>.empty();
  IList<String> slotTitles = const IList<String>.empty();
  IList<DealtCard> dealtCards = const IList<DealtCard>.empty();

  // TarotLayout? layout;

  // void setLayout(newLayout) => setState(() {
  //   verbose("  setLayout called; setting state to $newLayout");
  //   layout = newLayout;
  // });

  Future<void> dealCards() async {
    verbose("dealCards called.");

    context.read<DeckRepository>().also((deckRepository) {
      verbose("  deckRepository is $deckRepository");

      context.read<LayoutBloc>().state.currentLayout.also((layout) async {
        await deckRepository.shuffleDeck();
        final cards = await deckRepository.dealtCardQueue.take(layout.numCards);

        dealtCards = IList<DealtCard>(cards);
        verbose("  dealtCards is $dealtCards");

        for (var (bloc, card) in slotBlocs.zip(dealtCards)) {
          bloc.add(SlotWidgetSetCardEvent(card));
        }
      });
    });
  }

  Future<void> setSlotBlocs() async =>
      context.read<LayoutBloc>().state.also((LayoutState state) async {
        verbose("  setSlotBlocs. layout state is $state");
        verbose("  closing existing blocs, ${slotBlocs.length} of them.");
        for (var bloc in slotBlocs) {
          await bloc.close();
        }

        IList<String> localTitles;
        IList<SlotWidgetBloc> localBlocs;

        localTitles =
            switch (state.currentLayout) {
              HorizontalLinear(slotNames: var slotNames) => slotNames,
              _ => state.currentLayout.numCards.range().map((_) => ""),
            }.toIList();

        verbose("  creating localBlocs");

        localBlocs = state.currentLayout.numCards.range().fold(
          const IList<SlotWidgetBloc>.empty(),
          (prev, elem) => prev.add(
            SlotWidgetBloc(slotIndex: elem, slotName: localTitles[elem]),
          ),
        );

        setState(() {
          verbose("  setting slotBlocs and slotTitles");
          slotBlocs = localBlocs;
          slotTitles = localTitles;

          verbose("  slotTitles is $slotTitles");
          verbose("  slotBlocs is $slotBlocs");
        });
      });

  @override
  Widget build(BuildContext context) {
    verbose("  build method");
    // use a BlocConsumer to allow us to reset our slots on state change
    return BlocConsumer<LayoutBloc, LayoutState>(
      listener: (context, state) async {
        verbose(
          "  BlocConsumer<LayoutBloc, LayoutState> listener in LayoutWidget:",
        );
        verbose("    state is $state");
        await setSlotBlocs();
      },
      builder: (context, lsState) => LayoutSlotsWidget(),
    );
  }
}
