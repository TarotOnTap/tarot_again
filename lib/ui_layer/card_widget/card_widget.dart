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
class CardWidget extends StatelessWidget {
  final int index;
  final SlotWidgetStateDealt swState;

  const CardWidget({super.key, required this.index, required this.swState});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap:
          () => context.read<LayoutBloc>().add(
            SlotWidgetFlipFaceEvent(index: index),
          ),
      onSecondaryTap:
          () => toastification.show(
            title: Text("onSecondaryTap handler"),
            style: ToastificationStyle.flat,
            autoCloseDuration: const Duration(seconds: 3),
            description: RichText(
              text: const TextSpan(text: 'received a secondary tap. '),
            ),
          ),
      child: BlocBuilder<BulkCardControlBloc, BulkCardControlState>(
        builder:
            (context, bcState) => RotatedBox(
              quarterTurns:
                  bcState.reversalsAllowed &&
                          switch (swState.card) {
                            DeckCard dc => dc.reversed,
                            _ => false,
                          }
                      ? 2
                      : 0,
              child: Container(
                width: 70,
                height: 120,
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(border: Border.all(width: 2)),
                alignment: Alignment.center,
                child: switch (swState) {
                  SlotWidgetStateDealt sd => switch (sd.card) {
                    DeckCard dc => DeckCardWidget(card: dc),
                    _ => Placeholder(child: Text("Card is not a DeckCard")),
                  },
                },
              ),
            ),
      ),
    );
  }
}
