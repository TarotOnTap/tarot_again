import 'package:flutter/material.dart';
import 'package:tarot_again/blocs/blocs.dart';
import 'package:tarot_again/data_layer/data_layer.dart';
import 'package:tarot_again/util/util.dart';
import 'package:toastification/toastification.dart';

import 'deck_card_widget.dart';

part 'deck_empty_widget.dart';
part 'deck_initial_widget.dart';

class CardWidget extends WatchingStatefulWidget {
  final DealtCard card;

  const CardWidget({super.key, required this.card});

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  bool faceUp = false;

  void setFaceUp() => setState(() => faceUp = true);

  void unSetFaceUp() => setState(() => faceUp = false);

  void flipFaceUp() => setState(() => faceUp = !faceUp);

  @override
  Widget build(BuildContext context) {
    final what = watchBloc((BulkCardControlBloc b) => b);

    final BulkCardControlState data = what.data!;

    bool doReverse = false;

    if (widget.card case DeckCard(reversed: var r)) {
      doReverse = data.reversalsAllowed && r;
    }

    // TODO: set up a card back widget - probably displayed here, but not necessarily
    // TODO: the faceUp and faceDown logic need to happen somewhere, probably
    // at this level. Need to add BulkCardBloc at the top in order to have access
    // to reversalsAllowed and the global faceUp choice.
    return GestureDetector(
      onDoubleTap: () => flipFaceUp(),
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
          width: 80,
          height: 150,
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(border: Border.all(width: 2)),
          alignment: Alignment.center,
          child: switch (widget.card) {
            DeckCard() => DeckCardWidget(card: widget.card as DeckCard),
            DeckEmpty() => DeckEmptyWidget(),
            DeckInitial() => DeckInitialWidget(),
          },
        ),
      ),
    );
  }
}
