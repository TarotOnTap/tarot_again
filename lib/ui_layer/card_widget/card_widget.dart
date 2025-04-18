import 'package:flutter/material.dart';
import 'package:tarot_again/blocs/blocs.dart';
import 'package:tarot_again/data_layer/data_layer.dart';
import 'package:tarot_again/util/util.dart';
import 'package:toastification/toastification.dart';

import 'card_widget.dart';
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
  final PositionSlotWidgetState parentState;

  const CardWidget({super.key, required this.parentState});

  @override
  Widget build(BuildContext context) {
    final bcData = watchBloc((BulkCardControlBloc b) => b).data!;
    // final slotStream = watchBloc(null, bloc: slotBloc);

    // final BulkCardControlState data = what.data!;
    // final SlotWidgetState slotData = slotStream.data!;

    final dc = parentState.dealtCard;
    if (dc != null) {
      bool doReverse = false;

      if (dc case DeckCard(reversed: var r)) {
        doReverse = bcData.reversalsAllowed && r;
      }

      // at this level. Need to add BulkCardBloc at the top in order to have access
      // to reversalsAllowed and the global faceUp choice.
      return GestureDetector(
        onDoubleTap: () => parentState.flipFace(),
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
            child:
                parentState.faceUp || bcData.everybodyFaceUp
                    ? switch (dc) {
                      DeckCard() => DeckCardWidget(card: dc),
                      DeckEmpty() => DeckEmptyWidget(),
                      DeckInitial() => DeckInitialWidget(),
                    }
                    : CardBack(),
          ),
        ),
      );
    } else {
      return Placeholder(
        child: Column(
          children: [Text("CardWidget"), Text("shouldn't reach here")],
        ),
      );
    }
  }
}
