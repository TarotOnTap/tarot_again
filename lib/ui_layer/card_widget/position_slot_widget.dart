import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart' show Some, None;
// import 'package:go_router/go_router.dart';
import 'package:tarot_again/util/util.dart';
import 'package:toastification/toastification.dart';

import '../card_detail_popup/detail_popup_main.dart';
import 'card_widget.dart';
import 'no_card_dealt_widget.dart';

@immutable
class SelectSlotWidget extends StatelessWidget with Logging {
  final SlotState slotState;

  SelectSlotWidget({super.key, required this.slotState});

  @override
  Widget build(BuildContext context) {
    if (slotState.deckCard == TarotDeckCards.noneCard) {
      return NoCardDealt();
    }

    return SignalBuilder(
      builder: (context) {
        if (SignalsManager.allCardsFaceUp.value ||
            slotState.showingFace == ShowingFaceEnum.front) {
          return CardWidget(slotState: slotState);
        } else {
          // verbose("  returning CardColorBack()");
          return CardColorBack();
        }
      },
    );
  }
}

class PositionSlotWidget extends StatefulWidget {
  final String slotName;
  final int slotIndex;

  const PositionSlotWidget({
    super.key,
    required this.slotName,
    required this.slotIndex,
  });

  @override
  State<PositionSlotWidget> createState() => PositionSlotWidgetState();
}

class PositionSlotWidgetState extends State<PositionSlotWidget> {
  late SlotState slotState;

  @override
  void initState() {
    super.initState();

    slotState = SlotState(
      slotName: widget.slotName,
      slotIndex: widget.slotIndex,
    );
  }

  Future<void> setCard(TarotDeckCards card) async {
    if (card == TarotDeckCards.noneCard) {
      setState(
        () => slotState = SlotState(
          slotIndex: slotState.slotIndex,
          slotName: slotState.slotName,
        ),
      );
    } else {
      final assets = await sl<AssetManager>().loadAssetsForCard(card);
      final reversed = await sl<AsyncRandoms>().getNextInt(rangeHigh: 1);
      final ReversalEnum reversal = reversed == 0
          ? ReversalEnum.upright
          : ReversalEnum.reversed;

      setState(
        () => slotState = slotState.copyWith(
          deckCard: card,
          assets: assets,
          reversal: reversal,
        ),
      );
    }
  }

  void setFaceUp(ShowingFaceEnum showingFace) => setState(
    () => slotState = slotState.copyWith(showingFace: ShowingFaceEnum.front),
  );

  void setFaceDown(ShowingFaceEnum showingFace) =>
      setState(() => slotState = slotState.copyWith(showingFace: .back));

  void flipFaceUp() => setState(
    () => slotState = slotState.copyWith(
      showingFace: slotState.showingFace == ShowingFaceEnum.front
          ? ShowingFaceEnum.back
          : ShowingFaceEnum.front,
    ),
  );

  void setReversal(ReversalEnum reversal) =>
      setState(() => slotState = slotState.copyWith(reversal: reversal));

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (BuildContext context, BoxConstraints constraints) {
      // SizedBox(
      // width: 88,
      // height: 170,
      return Container(
        width: constraints.maxWidth,
        height: constraints.maxHeight,
        foregroundDecoration: BoxDecoration(
          border: Border.all(width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(2.0)),
        ),

        child: Column(
          children: <Widget>[
            Text(widget.slotName),

            Expanded(
              child: GestureDetector(
                onLongPress: () => switch (slotState.assets.description) {
                  Some<String>(value: final String description) =>
                    toastification.show(
                      title: Text("Description"),
                      style: ToastificationStyle.flat,
                      autoCloseDuration: const Duration(seconds: 10),
                      description: RichText(text: TextSpan(text: description)),
                    ),
                  None() => toastification.show(
                    title: Text("Description"),
                    style: ToastificationStyle.flat,
                    autoCloseDuration: const Duration(seconds: 10),
                    description: RichText(
                      text: const TextSpan(text: 'no description'),
                    ),
                  ),
                },
                onTap: () => Navigator.of(context)
                    .push(DetailPopupMain<void>(slotIndex: widget.slotIndex)),
                onDoubleTap: () => setFaceUp(ShowingFaceEnum.front),
                onSecondaryTap: () => toastification.show(
                  title: Text("onSecondaryTap handler"),
                  style: ToastificationStyle.flat,
                  autoCloseDuration: const Duration(seconds: 3),
                  description: RichText(
                    text: const TextSpan(text: 'received a secondary tap. '),
                  ),
                ),
                child: SelectSlotWidget(slotState: slotState),
              ),
            ),
          ],
        ),
      );
    },
  );
}
