import 'package:flutter/material.dart';
import 'package:tarot_again/blocs/blocs.dart';
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
class PositionSlotWidget extends StatelessWidget with Logging {
  final int index;

  const PositionSlotWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<BulkCardControlBloc, BulkCardControlState>(
        // selector: (state) => (state.everybodyFaceUp, state.reversalsAllowed),
        builder:
            (context, bcState) => SizedBox(
              width: 80,
              height: 150,
              child: Container(
                foregroundDecoration: BoxDecoration(
                  border: Border.all(width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(3.0)),
                ),

                child: BlocSelector<LayoutBloc, LayoutState, SlotWidgetState?>(
                  selector: (state) => state.slotWidgetStates[index],
                  builder:
                      (context, swState) =>
                          swState == null
                              ? Placeholder(
                                child: Text(
                                  "PositionSlotWidget: swState[$index] is null",
                                ),
                              )
                              : Column(
                                children: <Widget>[
                                  Text(swState.slotName),
                                  Expanded(
                                    child: switch (swState) {
                                      SlotWidgetStateNotDealt() =>
                                        NoCardDealt(),
                                      SlotWidgetStateDealt swsd =>
                                        bcState.everybodyFaceUp || swsd.faceUp
                                            ? CardWidget(
                                              index: index,
                                              swState: swsd,
                                            )
                                            : CardBack(),
                                    },
                                  ),
                                ],
                              ),
                ),
              ),
            ),
      );
}
