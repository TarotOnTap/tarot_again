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
  final DealtCard card;
  final SlotWidgetBloc slotBloc;

  const CardWidget({super.key, required this.card, required this.slotBloc});

  @override
  Widget build(BuildContext context) {
    final what = watchBloc((BulkCardControlBloc b) => b);
    final slotStream = watchBloc(null, bloc: slotBloc);

    final BulkCardControlState data = what.data!;
    final SlotWidgetState slotData = slotStream.data!;

    if (slotData is SlotWidgetStateDealt) {
      bool doReverse = false;

      if (card case DeckCard(reversed: var r)) {
        doReverse = data.reversalsAllowed && r;
      }

      // TODO: set up a card back widget - probably displayed here, but not necessarily
      // TODO: the faceUp and faceDown logic need to happen somewhere, probably
      // at this level. Need to add BulkCardBloc at the top in order to have access
      // to reversalsAllowed and the global faceUp choice.
      return GestureDetector(
        onDoubleTap: () => slotBloc.add(SlotWidgetFaceUpEvent()),
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
                slotData.faceUp || data.everybodyFaceUp
                    ? switch (card) {
                      DeckCard() => DeckCardWidget(card: card as DeckCard),
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
