// import 'package:flutter/material.dart';
// import 'package:tarot_again/ui_layer/card_widget/position_slot_widget.dart';
// import 'package:tarot_again/util/util.dart';
//
// @immutable
// class LinearLayoutWidget extends StatelessWidget with Logging {
//   final HorizontalLinear layoutDetails;
//
//   const LinearLayoutWidget({super.key, required this.layoutDetails});
//
//   @override
//   Widget build(BuildContext context) {
//     verbose("LinearLayoutWidget.build method");
//
//     return Watch(
//       (context) => Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: layoutDetails.slotNames
//             .mapIndexed(
//               (int index, String slotName) => PositionSlotWidget(
//                 key: ComputedsManager.slotKeys.value[index],
//                 slotIndex: index,
//                 slotName: slotName,
//               ),
//             )
//             .toList(),
//       ),
//       debugLabel: "LinearLayoutWidget",
//     );
//   }
// }
