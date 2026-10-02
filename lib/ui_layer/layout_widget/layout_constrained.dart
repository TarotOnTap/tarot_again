import 'package:align_positioned/align_positioned.dart';
import 'package:flutter/material.dart';
import 'package:tarot_again/ui_layer/card_widget/card_widget.dart';
import 'package:tarot_again/util/util.dart';

class LayoutConstrained extends StatelessWidget with Logging {
  const LayoutConstrained({super.key, required this.layout});

  final NewTarotLayout layout;

  Widget _buildFromPosition({
    required PositionRepresentation pos,
    required int index,
  }) {
    verbose(
      "_buildFromPosition: building for position ${pos.name} at index $index with pos\n$pos",
    );
    final newAligned = AlignPositioned.expand(
      alignment: pos.alignment,
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
      childWidth: SignalsManager.cardWidth.value,
      childHeight: SignalsManager.cardHeight.value,
      // minChildWidth: pos.minChildWidth,
      // minChildHeight: pos.minChildHeight,
      // maxChildWidth: pos.maxChildWidth,
      // maxChildHeight: pos.maxChildHeight,
      // childWidthRatio: pos.childWidthRatio,
      // childHeightRatio: pos.childHeightRatio,
      // minChildWidthRatio: pos.minChildWidthRatio,
      // minChildHeightRatio: pos.minChildHeightRatio,
      // maxChildWidthRatio: pos.maxChildWidthRatio,
      // maxChildHeightRatio: 0.9, // ratio of child height to container height // pos.maxChildHeightRatio,
      rotateDegrees: pos.rotateDegrees,
      // Matrix4Transform? matrix4Transform, // TODO: write a converter
      wins: pos.wins ?? Wins.min,
      touch: pos.touch ?? Touch.inside,
      child: PositionSlotWidget(
        key: ComputedsManager.slotKeys.value[index],
        slotName: pos.name,
        slotIndex: pos.positionIndex ?? index,
      ),
    );

    return newAligned;
  }

  @override
  Widget build(BuildContext context) {
    final layoutOrder = layout.positions.sortedBy((pos) => pos.zIndex ?? 0);

    return Center(
      child: Stack(
        children: [
          // LayoutBackground(),
          for (var (int index, PositionRepresentation pos)
              in layoutOrder.indexed)
            _buildFromPosition(pos: pos, index: index),
        ],
      ),
    );
  }
}
