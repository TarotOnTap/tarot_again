import 'package:flutter/material.dart';
import 'package:tarot_again/util/util.dart';
import 'package:toastification/toastification.dart';

import 'card_widget.dart';

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
  // final int index;
  final SlotState slotState;

  PositionSlotWidget({
    super.key,
    // required this.index,
    required this.slotState,
  }) {
    verbose("PositionSlotWidget constructor; slotState is $slotState");
  }

  @override
  Widget build(BuildContext context) => SizedBox(
    width: 88,
    height: 170,
    child: Container(
      foregroundDecoration: BoxDecoration(
        border: Border.all(width: 1.0),
        borderRadius: BorderRadius.all(Radius.circular(2.0)),
      ),

      child: Watch(
        (context) => Column(
          children: <Widget>[
            Text(slotState.slotName.value),
            Expanded(
              child: GestureDetector(
                onDoubleTap: () =>
                    slotState.faceUp.value = !slotState.faceUp.value,
                onSecondaryTap: () => toastification.show(
                  title: Text("onSecondaryTap handler"),
                  style: ToastificationStyle.flat,
                  autoCloseDuration: const Duration(seconds: 3),
                  description: RichText(
                    text: const TextSpan(text: 'received a secondary tap. '),
                  ),
                ),
                child: switch (slotState.isDealt) {
                  false => NoCardDealt(),
                  true => Watch(
                    (context) =>
                        sl<Reactives>().allCardsFaceUp.value ||
                            slotState.faceUp.value
                        ? CardWidget(slotState: slotState)
                        : CardColorBack(),
                  ),
                },
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
