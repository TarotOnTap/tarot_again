import 'package:flutter/material.dart';
import 'package:tarot_again/blocs/blocs.dart';
import 'package:tarot_again/data_layer/data_layer.dart';
import 'package:tarot_again/ui_layer/card_widget/card_widget.dart';
import 'package:tarot_again/util/util.dart';

import 'layout_state_ready_to_deal_widget.dart';

class LayoutWidget extends WatchingStatefulWidget {
  const LayoutWidget({super.key});

  @override
  State<LayoutWidget> createState() => LayoutWidgetState();
}

class LayoutWidgetState extends State<LayoutWidget> with Logging {
  IList<SlotWidgetBloc> slotBlocs = const IList<SlotWidgetBloc>.empty();
  IList<String> slotTitles = const IList<String>.empty();

  TarotLayout? layout;

  void setLayout(newLayout) => setState(() => layout = newLayout);

  void setSlotBlocs(LayoutState state) async {
    // clean up the list of blocs, releasing resources &c.
    for (var bloc in slotBlocs) {
      await bloc.close();
    }

    IList<SlotWidgetBloc> localBlocs = const IList<SlotWidgetBloc>.empty();
    IList<String> localTitles = const IList<String>.empty();

    localTitles =
        switch (state.currentLayout) {
          HorizontalLinear(slotNames: var slotNames) => slotNames,
          _ => [for (var item in localBlocs) ""],
        }.toList().lock;

    for (var index in state.currentLayout.numCards.range()) {
      localBlocs = localBlocs.add(
        SlotWidgetBloc(slotIndex: index, slotName: localTitles[index]),
      );
    }

    setState(() {
      slotBlocs = localBlocs;
      slotTitles = localTitles;
    });
  }

  @override
  Widget build(BuildContext context) {
    // use a BlocConsumer to allow us to reset our slots on state change
    return BlocConsumer<LayoutBloc, LayoutState>(
      // listenWhen:
      //     (prev, current) => prev.currentLayout != current.currentLayout,
      listener: (context, state) => setSlotBlocs(state),
      builder:
          (context, lsState) => LayoutSlotsWidget(
            children: <Widget>[
              for (var bloc in slotBlocs)
                BlocProvider<SlotWidgetBloc>(
                  create: (_) => bloc,
                  child: PositionSlotWidget(),
                ),
            ],
          ),
    );
  }
}
