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

    return context.findAncestorStateOfType<LayoutWidgetState>()?.let((lwState) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              for (var bloc in lwState.slotBlocs)
                BlocProvider<SlotWidgetBloc>(
                  create: (_) => bloc,
                  child: PositionSlotWidget(),
                ),
            ],
          );
        }) ??
        Placeholder(child: Text("LinearLayoutWidget failed."));
  }
}
