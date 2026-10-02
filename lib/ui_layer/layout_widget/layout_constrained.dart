import 'package:align_positioned/align_positioned.dart';
import 'package:flutter/material.dart';
import 'package:tarot_again/ui_layer/card_widget/card_widget.dart';
import 'package:tarot_again/util/util.dart';

// class LayoutBackground({super.key}) extends StatelessWidget with Logging {
//   @override
//   Widget build(BuildContext context) {
//     return Center(child: Container(color: Theme.of(context).focusColor));
//   }
// }

class LayoutConstrained extends StatelessWidget with Logging {
  const LayoutConstrained({super.key, required this.layout});

  final NewTarotLayout layout;

  Widget _buildFromPosition({
    required PositionRepresentation pos,
    required int index,
    required double cardWidth,
    required double cardHeight,
  }) {
    return AlignPositioned.expand(
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
      childWidth: cardWidth,
      childHeight: cardHeight,
      minChildWidth: pos.minChildWidth,
      minChildHeight: pos.minChildHeight,
      maxChildWidth: pos.maxChildWidth,
      maxChildHeight: pos.maxChildHeight,
      childWidthRatio: pos.childWidthRatio,
      childHeightRatio: pos.childHeightRatio,
      minChildWidthRatio: pos.minChildWidthRatio,
      minChildHeightRatio: pos.minChildHeightRatio,
      maxChildWidthRatio: pos.maxChildWidthRatio,
      // maxChildHeightRatio: 0.9, // ratio of child height to container height // pos.maxChildHeightRatio,
      rotateDegrees: pos.rotateDegrees,
      // Matrix4Transform? matrix4Transform, // TODO: write a converter
      wins: pos.wins ?? Wins.min,
      touch: pos.touch ?? Touch.inside,
      child: PositionSlotWidget(
        key: ComputedsManager.slotKeys.value[index],
        slotName: pos.name,
        slotIndex: pos.positionIndex ?? index,
        width: cardWidth,
        height: cardHeight,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final layoutOrder = layout.positions.sortedBy((pos) => pos.zIndex ?? 0);

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        verbose("LayoutConstrained.build: constraints are $constraints");
        final double cardWidth = constraints.maxWidth / 10.0;
        final double cardHeight = constraints.maxHeight / 10.0;
        return Center(
          child: SizedBox(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            child: Stack(
              children: [
                // LayoutBackground(),
                for (var (int index, PositionRepresentation pos)
                    in layoutOrder.indexed)
                  _buildFromPosition(
                    cardWidth: cardWidth,
                    cardHeight: cardHeight,
                    pos: pos,
                    index: index,
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
