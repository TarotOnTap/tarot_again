import 'package:flutter/material.dart';
import 'package:tarot_again/data_layer/data_layer.dart';
import 'package:tarot_again/ui_layer/ui_layer.dart';
import 'package:tarot_again/util/util.dart';

import 'layout_widget.dart';

@immutable
class LinearLayoutWidget extends WatchingWidget with Logging {
  final HorizontalLinear layoutDetails;
  final LayoutWidgetState parentWidgetState;

  const LinearLayoutWidget({
    super.key,
    required this.layoutDetails,
    required this.parentWidgetState,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        for (var bloc in parentWidgetState.slotBlocs)
          PositionSlotWidget(bloc: bloc),
      ],
    );
  }
}
