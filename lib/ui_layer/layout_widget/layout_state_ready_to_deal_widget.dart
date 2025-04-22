import 'package:flutter/material.dart';
import 'package:tarot_again/blocs/blocs.dart';
import 'package:tarot_again/ui_layer/card_widget/card_widget.dart'; // import 'package:tarot_again/ui_layer/layout_widget/null_layout_widget.dart';
import 'package:tarot_again/util/util.dart';

import 'grid_layout_widget.dart';
import 'layout_widget.dart';
import 'linear_layout_widget.dart';
import 'null_layout_widget.dart';

@immutable
class LayoutSlotsWidget extends WatchingStatefulWidget with Logging {
  // this widget gets called twice as the layout state changes. The first time,
  // all-new SlotWidgets get created and have blocs assigned.
  // the second time through, we don't need to do anything but recreate the layout
  // with the SlotWidgets intact.
  final LayoutWidgetState parentWidgetState;

  const LayoutSlotsWidget({super.key, required this.parentWidgetState});

  @override
  State<LayoutSlotsWidget> createState() => LayoutSlotsWidgetState();
}

class LayoutSlotsWidgetState extends State<LayoutSlotsWidget> {
  KeyIterable slots = const KeyIterable.empty();
  IList<PositionSlotWidget> slotWidgets =
      const IList<PositionSlotWidget>.empty();
  int numberOfSlots = 0;
  LayoutState? currentState;

  @override
  initState() {
    super.initState();
  }

  // void createSlots(state) => setState(() {
  //   // do we really need to create something new? These checks make sure we're not
  //   // doing ourselves a mischief
  //   if (widget.newLayout) {
  //     if (currentState != state) {
  //       if (currentState case LayoutStateSlotsAssigned cs) {
  //         if (cs.slotKeys.isNotEmpty) {
  //           if (cs.slotKeys.length != state.slotKeys.length) {}
  //         }
  //
  //         slots = state.slotKeys;
  //       }
  //
  //       if (slots.isEmpty && numberOfSlots == 0) {}
  //     }
  //   }
  // });

  @override
  Widget build(BuildContext context) {
    final LayoutState layoutState = watchBloc((LayoutBloc b) => b).data!;

    Widget returnVal = const Placeholder(child: Text("LayoutSlotsWidget"));

    returnVal = switch (layoutState) {
      LayoutInitial() => NullLayoutWidget(),
      LayoutStateSlotsAssigned(currentLayout: var currentLayout) =>
        switch (currentLayout) {
          HorizontalLinear hl => LinearLayoutWidget(
            layoutDetails: hl,
            parentWidgetState: widget.parentWidgetState,
          ),
          SimpleGrid sg => GridLayoutWidget(
            layoutDetails: sg,
            parentWidgetState: widget.parentWidgetState,
          ),
        },
    };

    return returnVal;
  }
}

//
// @immutable
// class LayoutSlotsWidget extends WatchingWidget with Logging {
//   // passing state as a parameter prevents us from having to watch the
//   // layout bloc for changes. If our parent needs us to change, we will - we don't
//   // have to watch out for that.
//   final LayoutState state;
//
//   LayoutSlotsWidget({super.key, required this.state});
//
//   @override
//   Widget build(BuildContext context) {
//     // TODO this is the place where the actual layout happens, using one of the layout
//     // TODO widgets. Do the layout, then give a big "Deal Cards" button or some other
//     // TODO mechanism to fill the slot widgets with dealt cards.
//     return switch (state.currentLayout) {
//       HorizontalLinear hl => LinearLayoutWidget(state: state, layout: hl),
//       SimpleGrid sg => GridLayoutWidget(state: state),
//       NullLayout nl => NullLayoutWidget(),
//     };
//   }
// }
