import 'package:flutter/material.dart';
import 'package:tarot_again/blocs/blocs.dart';
import 'package:tarot_again/data_layer/data_layer.dart';
import 'package:tarot_again/ui_layer/card_widget/card_widget.dart';
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
class PositionSlotWidget extends WatchingWidget with Logging {
  final SlotWidgetBloc bloc;

  // final String positionTitle;

  const PositionSlotWidget({super.key, required this.bloc});

  void setDealtCard(DealtCard newCard) =>
      bloc.add(SlotWidgetSetCardEvent(newCard));

  void setFaceUp() => bloc.add(SlotWidgetFaceUpEvent());

  void setFaceDown() => bloc.add(SlotWidgetFaceDownEvent());

  void flipFace() => bloc.add(SlotWidgetFlipFaceEvent());

  @override
  Widget build(BuildContext context) {
    final BulkCardControlState bcState =
        watchBloc((BulkCardControlBloc b) => b).data!;

    final SlotWidgetState swState = watchBloc(null, bloc: bloc).data!;

    bool doFaceUp =
        bcState.everybodyFaceUp ||
        switch (swState) {
          SlotWidgetStateNotDealt() => false,
          SlotWidgetStateDealt(faceUp: var faceUp) => faceUp,
        };

    Widget result = SizedBox(
      width: 80,
      height: 150,
      child: Column(
        children: <Widget>[
          Text(swState.slotName),
          Expanded(
            child: switch (swState) {
              SlotWidgetStateNotDealt() => NoCardDealt(),
              SlotWidgetStateDealt(faceUp: var faceUp, card: var card) =>
                doFaceUp
                    ? CardWidget(flipFace: flipFace, card: card as DeckCard)
                    : CardBack(),
            },
          ),
        ],
      ),
    );

    return result;
  }
}
