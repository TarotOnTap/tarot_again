import 'package:flutter/material.dart';
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

class PositionSlotWidget extends WatchingStatefulWidget with Logging {
  final String positionTitle;

  const PositionSlotWidget({super.key, required this.positionTitle});

  @override
  State<PositionSlotWidget> createState() => PositionSlotWidgetState();
}

class PositionSlotWidgetState extends State<PositionSlotWidget> {
  DealtCard? dealtCard;
  bool faceUp = false;

  void setDealtCard(DealtCard newCard) => setState(() => dealtCard = newCard);

  void setFaceUp() => setState(() => faceUp = true);

  void setFaceDown() => setState(() => faceUp = false);

  void flipFace() => setState(() => faceUp = !faceUp);

  @override
  Widget build(BuildContext context) {
    // final bcData =
    //     watchBloc((BulkCardControlBloc b) => b).data! as BulkCardControlState;
    //
    return SizedBox(
      width: 80,
      height: 150,
      child: Column(
        children: <Widget>[
          Text(widget.positionTitle),
          Expanded(
            child: switch (dealtCard) {
              null => NoCardDealt(),
              DealtCard dc => CardWidget(parentState: this),
            },
          ),
        ],
      ),
    );
    return const Placeholder();
  }
}
