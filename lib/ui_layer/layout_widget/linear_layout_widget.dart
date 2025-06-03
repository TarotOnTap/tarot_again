import 'package:flutter/material.dart';
import 'package:tarot_again/ui_layer/card_widget/position_slot_widget.dart';
import 'package:tarot_again/util/util.dart';

@immutable
class LinearLayoutWidget extends StatelessWidget with Logging {
  final HorizontalLinear layoutDetails;

  const LinearLayoutWidget({super.key, required this.layoutDetails});

  @override
  Widget build(BuildContext context) {
    verbose("LinearLayoutWidget.build method");

    // final SignalsManager sm = sl<SignalsManager>();
    // final ComputedsManager cm = sl<ComputedsManager>();

    verbose(
      "  SessionManager.cardSlots.value is ${ComputedsManager.cardSlots}",
    );
    verbose(
      "  SessionManager.cardSlots.value.length is ${ComputedsManager.cardSlots.value.length}",
    );

    return Watch(
      (context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: ComputedsManager.cardSlots.value
            .map((slotState) => PositionSlotWidget(slotState: slotState))
            .toList(),
      ),
      debugLabel: "LinearLayoutWidget",
    );
  }
}
