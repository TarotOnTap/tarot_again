import 'package:flutter/material.dart';
import 'package:tarot_again/blocs/blocs.dart';
import 'package:tarot_again/ui_layer/card_widget/card_widget.dart';
import 'package:tarot_again/util/util.dart';

@immutable
class NoCardDealt extends StatelessWidget {
  const NoCardDealt({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: 70, height: 120, child: Center(child: Text("?")));
  }
}

class PositionSlotWidget extends WatchingWidget {
  final String positionTitle;
  final SlotWidgetBloc slotBloc;

  const PositionSlotWidget({
    super.key,
    required this.positionTitle,
    required this.slotBloc,
  });

  @override
  Widget build(BuildContext context) {
    final blocWatch = watchBloc(null, bloc: slotBloc);

    final SlotWidgetState blocData = blocWatch.data!;

    return SizedBox(
      width: 80,
      height: 150,
      child: Column(
        children: <Widget>[
          Text(positionTitle),
          Expanded(
            child: switch (blocData) {
              SlotWidgetStateNotDealt nd => NoCardDealt(),
              SlotWidgetStateDealt dealt => CardWidget(
                card: blocData.card,
                slotBloc: slotBloc,
              ),
            },
          ),
        ],
      ),
    );
  }
}
