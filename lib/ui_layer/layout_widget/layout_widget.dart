import 'package:flutter/material.dart';
import 'package:tarot_again/blocs/blocs.dart';
import 'package:tarot_again/ui_layer/card_widget/card_widget.dart';
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

  void setSlotBlocs(LayoutStateSlotsAssigned state) {
    IList<SlotWidgetBloc> localBlocs = const IList<SlotWidgetBloc>.empty();
    IList<String> localTitles = const IList<String>.empty();

    for (var index in state.currentLayout.numCards.range()) {
      localBlocs = localBlocs.add(
        SlotWidgetBloc(slotKey: state.slotKeys[index]),
      );
      localTitles = switch (state.currentLayout) {
        HorizontalLinear(slotNames: var slotNames) => slotNames,
        _ => [for (var item in localBlocs) ""],
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    final LayoutState state = watchBloc((LayoutBloc b) => b).data!;

    Widget result;

    switch (state) {
      case LayoutInitial():
        result = Column(
          children: <Widget>[
            Text("Choose a layout using the selector to the left"),
            Text("choices are:"),
            for (var name in state.layoutNames) Text("  $name"),
          ],
        );
      case LayoutStateSlotsAssigned slState:
        verbose("LayoutStateSlotsAssigned state");
      case LayoutStateCardsAssigned slState:
        verbose("LayoutStateCardsAssigned state");
    }

    final layoutType = switch (state) {
      LayoutInitial() => Column(
        children: <Widget>[
          Text("Choose a layout using the selector to the left"),
          Text("choices are:"),
          for (var name in state.layoutNames) Text("  $name"),
        ],
      ),
      LayoutStateSlotsAssigned() => LayoutSlotsWidget(parentWidgetState: this),
      LayoutStateCardsAssigned() => LayoutSlotsWidget(parentWidgetState: this),
    };

    return layoutType;
  }
}
