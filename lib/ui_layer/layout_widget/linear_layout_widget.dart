import 'package:flutter/material.dart';
// import 'package:signals/signals_flutter.dart';
import 'package:tarot_again/ui_layer/card_widget/position_slot_widget.dart';
import 'package:tarot_again/util/util.dart';

@immutable
class LinearLayoutWidget extends StatelessWidget with Logging {
  final HorizontalLinear layoutDetails;

  const LinearLayoutWidget({super.key, required this.layoutDetails});

  @override
  Widget build(BuildContext context) {
    verbose("build method");

    return Watch(
      (context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: sl<SessionManager>().tarotLayout.value.numCards
            .repeat((index) => PositionSlotWidget(index: index))
            .cast<Widget>()
            .toList(),
        // <Widget>[
        //   for (var index
        //       in sl<LayoutRepository>().tarotLayout.value.numCards.range())
        //     PositionSlotWidget(index: index),
        // ],
      ),
    );
  }
}
