import 'package:flutter/material.dart';
import 'package:tarot_again/blocs/blocs.dart';
import 'package:tarot_again/data_layer/data_layer.dart';
import 'package:tarot_again/util/util.dart';
import 'package:toastification/toastification.dart';

import 'deck_card_widget.dart';

export 'position_slot_widget.dart';

part 'deck_empty_widget.dart';
part 'deck_initial_widget.dart';

@immutable
class CardBack extends StatelessWidget {
  const CardBack({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.lime);
  }
}

@immutable
class CardWidget extends WatchingWidget {
  final void Function() flipFace;
  final DeckCard card;
  // final PositionSlotWidgetState parentState;

  const CardWidget({super.key, required this.flipFace, required this.card});

  @override
  Widget build(BuildContext context) {
    final bcData = watchBloc((BulkCardControlBloc b) => b).data!;

    bool doReverse = bcData.reversalsAllowed && card.reversed;

    // at this level. Need to add BulkCardBloc at the top in order to have access
    // to reversalsAllowed and the global faceUp choice.
    return GestureDetector(
      onDoubleTap: flipFace,
      onSecondaryTap:
          () => toastification.show(
            title: Text("onSecondaryTap handler"),
            style: ToastificationStyle.flat,
            autoCloseDuration: const Duration(seconds: 3),
            description: RichText(
              text: const TextSpan(text: 'received a secondary tap. '),
            ),
          ),
      child: RotatedBox(
        quarterTurns: doReverse ? 2 : 0,
        child: Container(
          width: 70,
          height: 120,
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(border: Border.all(width: 2)),
          alignment: Alignment.center,
          child: DeckCardWidget(card: card),
        ),
      ),
    );
  }
}
