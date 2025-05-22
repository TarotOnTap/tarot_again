import 'package:flutter/material.dart';
import 'package:tarot_again/managers/session_manager/session_manager.dart';
import 'package:tarot_again/util/util.dart';

@immutable
class NoCardDealt extends StatelessWidget {
  const NoCardDealt({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO I think I would prefer to display an icon here to plain text.
    return SizedBox(width: 70, height: 120, child: Center(child: Text("?")));
  }
}

@immutable
class PositionSlotWidget extends StatelessWidget with Logging {
  final int index;

  const PositionSlotWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final SessionManager sm = sl<SessionManager>();
    return Placeholder(child: Text("Please stand by"));
  }
  /* SizedBox( */

  // width: 88,
  // height: 170,
  // child: Container(
  //   foregroundDecoration: BoxDecoration(
  //     border: Border.all(width: 1.0),
  //     borderRadius: BorderRadius.all(Radius.circular(2.0)),
  //   ),
  //
  //   child: Watch((context) =>
  //       builder:
  //           (context, swState) =>
  //               swState == null
  //                   ? Placeholder(
  //                     child: Text(
  //                       "PositionSlotWidget: ${sm.dealtCardSelectors[index].value} is null",
  //                     ),
  //                   )
  //                   : Column(
  //                     children: <Widget>[
  //                       Text(swState.slotName),
  //                       Expanded(
  //                         child: GestureDetector(
  //                           onDoubleTap:
  //                               () => sl<SessionManager>().flipCardFace ,
  //                           onSecondaryTap:
  //                               () => toastification.show(
  //                                 title: Text("onSecondaryTap handler"),
  //                                 style: ToastificationStyle.flat,
  //                                 autoCloseDuration: const Duration(
  //                                   seconds: 3,
  //                                 ),
  //                                 description: RichText(
  //                                   text: const TextSpan(
  //                                     text: 'received a secondary tap. ',
  //                                   ),
  //                                 ),
  //                               ),
  //                           child: switch (swState) {
  //                             SlotStateNotDealt() => NoCardDealt(),
  //                             SlotStateDealt ssd => Watch(
  //                               (context) =>
  //                                   sl<SessionManager>()
  //                                               .allCardsFaceUp
  //                                               .value ||
  //                                           ssd.faceUp
  //                                       // bcState.everybodyFaceUp || ssd.faceUp
  //                                       ? CardWidget(
  //                                         index: index,
  //                                         swState: ssd,
  //                                       )
  //                                       : CardColorBack(),
  //                             ),
  //                           },
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //     ),
  //   ),
  // ),
  //   )};
}
