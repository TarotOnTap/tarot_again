import 'package:flutter/material.dart';
import 'package:tarot_again/blocs/blocs.dart';
import 'package:tarot_again/data_layer/data_layer.dart';
import 'package:tarot_again/ui_layer/card_widget/position_slot_widget.dart';
import 'package:tarot_again/util/util.dart';

import 'layout_widget.dart';

@immutable
class LinearLayoutWidget extends StatelessWidget with Logging {
  final HorizontalLinear layoutDetails;

  const LinearLayoutWidget({super.key, required this.layoutDetails});

  @override
  Widget build(BuildContext context) {
    verbose("build method");

    Widget retWidget = Placeholder(child: Text("LinearLayoutWidget failed."));

    final LayoutWidgetState? lwState =
        context.findAncestorStateOfType<LayoutWidgetState>();
    verbose("  lwState is $lwState");

    final blocs = lwState?.slotBlocs;
    verbose("  blocs is $blocs");

    if (blocs != null) {
      retWidget = Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          for (var bloc in blocs)
            BlocProvider<SlotWidgetBloc>(
              create: (_) => bloc,
              child: PositionSlotWidget(),
            ),
        ],
      );
    }

    return retWidget;
  }
}
