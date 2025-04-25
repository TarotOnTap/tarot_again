import 'package:flutter/material.dart';
import 'package:tarot_again/blocs/blocs.dart';
import 'package:tarot_again/data_layer/data_layer.dart';
import 'package:tarot_again/util/util.dart';

import 'grid_layout_widget.dart';
import 'linear_layout_widget.dart';

class LayoutWidget extends StatelessWidget with Logging {
  const LayoutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    verbose("  build method");
    // use a BlocConsumer to allow us to reset our slots on state change
    return BlocBuilder<LayoutBloc, LayoutState>(
      // buildWhen: (prev, state) => prev.currentLayout != state.currentLayout,
      builder:
          (context, lsState) => switch (lsState.currentLayout) {
            HorizontalLinear hl => LinearLayoutWidget(layoutDetails: hl),
            SimpleGrid sg => GridLayoutWidget(layoutDetails: sg),
            NullLayout _ => Placeholder(child: Text("No layout selected")),
          },
    );
  }
}
