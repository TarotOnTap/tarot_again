import 'package:flutter/material.dart';
// import 'package:tarot_again/data_layer/data_layer.dart';
import 'package:tarot_again/util/util.dart';

import 'tc_major_arcana_widget.dart';
import 'tc_minor_arcana_widget.dart';

@immutable
class DeckCardWidget extends StatelessWidget with Logging {
  final SlotState slotState;

  const DeckCardWidget({super.key, required this.slotState});

  @override
  Widget build(BuildContext context) {
    Widget retVal = Placeholder(
      child: Text("DeckCardWidget: $slotState shouldn't ever get here"),
    );

    if (slotState.isDealt) {
      final card = slotState.deckCard.value!;

      Watch(
        (context) => switch (card.arcana) {
          Arcana.major => TCMajorArcanaWidget(slotState: slotState),
          Arcana.minor => TCMinorArcanaWidget(slotState: slotState),
        },
      );
    }
    return retVal;
  }
}
