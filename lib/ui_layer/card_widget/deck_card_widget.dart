// import 'package:flutter/material.dart';
// // import 'package:tarot_again/data_layer/data_layer.dart';
// import 'package:tarot_again/util/util.dart';
//
// import 'tc_arcana_widget.dart';
// import 'tc_minor_arcana_widget.dart';
//
// @immutable
// class DeckCardWidget extends StatelessWidget with Logging {
//   final SlotState slotState;
//
//   const DeckCardWidget({super.key, required this.slotState});
//
//   @override
//   Widget build(BuildContext context) => Watch(
//     (context) => switch (slotState.deckCard.value.arcana) {
//       Arcana.major => TCMajorArcanaWidget(slotState: slotState),
//       Arcana.minor => TCMinorArcanaWidget(slotState: slotState),
//       Arcana.none => Center(child: Text("? ? ?")),
//     },
//     debugLabel: "DeckCardWidget",
//   );
// }
