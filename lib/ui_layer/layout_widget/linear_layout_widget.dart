import 'package:flutter/material.dart';
import 'package:tarot_again/blocs/blocs.dart';
import 'package:tarot_again/data_layer/data_layer.dart';
import 'package:tarot_again/ui_layer/card_widget/position_slot_widget.dart';
import 'package:tarot_again/util/util.dart';

@immutable
class LinearLayoutWidget extends StatelessWidget with Logging {
  final HorizontalLinear layoutDetails;

  const LinearLayoutWidget({super.key, required this.layoutDetails});

  @override
  Widget build(BuildContext context) {
    verbose("build method");

    return BlocBuilder<LayoutBloc, LayoutState>(
      builder:
          (context, lwState) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              for (var index in lwState.currentLayout.numCards.range())
                PositionSlotWidget(index: index),
            ],
          ),
    );
  }
}
