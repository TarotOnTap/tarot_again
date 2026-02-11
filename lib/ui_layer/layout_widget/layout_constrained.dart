import 'package:align_positioned/align_positioned.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:tarot_again/ui_layer/card_widget/card_widget.dart';
import 'package:tarot_again/util/util.dart';

class LayoutBackground extends StatelessWidget with Logging {
  const LayoutBackground({super.key, required this.parentSize});

  final BoxConstraints parentSize;

  @override
  Widget build(BuildContext context) {
    return Container(constraints: parentSize, color: Colors.blue);
  }
}

class LayoutConstrained extends StatelessWidget with Logging {
  @Preview(name: 'LayoutConstrained')
  const LayoutConstrained({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Stack(
          children: [
            LayoutBackground(parentSize: constraints),
            AlignPositioned.expand(
              alignment: Alignment.centerLeft,
              moveByContainerWidth: 0.25,
              moveByChildWidth: -0.5,
              child: PositionSlotWidget(slotName: "Slot 0", slotIndex: 0),
            ),
            AlignPositioned.expand(
              alignment: Alignment.centerLeft,
              moveByContainerWidth: 0.5,
              moveByChildWidth: -0.5,
              child: PositionSlotWidget(slotName: "Slot 1", slotIndex: 1),
            ),
            AlignPositioned.expand(
              alignment: Alignment.centerLeft,
              moveByContainerWidth: 0.75,
              moveByChildWidth: -0.5,
              child: PositionSlotWidget(slotName: "Slot 2", slotIndex: 2),
            ),
          ],
        );
      },
    );
  }
}
