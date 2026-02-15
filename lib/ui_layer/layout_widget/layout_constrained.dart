import 'package:align_positioned/align_positioned.dart';
import 'package:flutter/material.dart';
import 'package:tarot_again/ui_layer/card_widget/card_widget.dart';
import 'package:tarot_again/util/util.dart';

class LayoutBackground extends StatelessWidget with Logging {
  LayoutBackground({super.key, required this.parentSize}) {
    verbose("LayoutBackground created, passed $parentSize");
  }

  final BoxConstraints parentSize;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: parentSize,
      child: Container(color: Colors.blue),
    );
  }
}

class LayoutConstrained extends StatelessWidget with Logging {
  const LayoutConstrained({super.key, required this.layout});

  final NewTarotLayout layout;

  Widget _buildFromPosition(PositionRepresentation pos, int index) {
    return AlignPositioned.expand(
      key: ComputedsManager.slotKeys.value[index],
      alignment: Alignment.topLeft,
      dx: pos.dx,
      dy: pos.dy,
      moveByChildWidth: pos.moveByChildWidth,
      moveByChildHeight: pos.moveByChildHeight,
      moveByContainerWidth: pos.moveByContainerWidth,
      moveByContainerHeight: pos.moveByContainerHeight,

      moveVerticallyByChildWidth: pos.moveVerticallyByChildWidth,
      moveHorizontallyByChildHeight: pos.moveHorizontallyByChildHeight,
      moveVerticallyByContainerWidth: pos.moveVerticallyByContainerWidth,
      moveHorizontallyByContainerHeight: pos.moveHorizontallyByContainerHeight,
      childWidth: pos.childWidth,
      childHeight: pos.childHeight,
      minChildWidth: pos.minChildWidth,
      minChildHeight: pos.minChildHeight,
      maxChildWidth: pos.maxChildWidth,
      maxChildHeight: pos.maxChildHeight,
      childWidthRatio: pos.childWidthRatio,
      childHeightRatio: pos.childHeightRatio,
      minChildWidthRatio: pos.minChildWidthRatio,
      minChildHeightRatio: pos.minChildHeightRatio,
      maxChildWidthRatio: pos.maxChildWidthRatio,
      maxChildHeightRatio: pos.maxChildHeightRatio,
      rotateDegrees: pos.rotateDegrees,
      // Matrix4Transform? matrix4Transform, // TODO: write a converter
      wins: pos.wins ?? Wins.min,
      touch: pos.touch ?? Touch.inside,
      child: PositionSlotWidget(
        slotName: pos.name,
        slotIndex: pos.positionIndex ?? index,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: sort by z-index first, so that lower z-indexes are earlier in the
    // list
    final layoutOrder = layout.positions.sortedBy((pos) => pos.zIndex ?? 0);

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Stack(
          children: [
            LayoutBackground(parentSize: constraints),
            for (var (int index, PositionRepresentation pos)
                in layoutOrder.indexed)
              _buildFromPosition(pos, index),
          ],
        );
      },
    );
  }
}
