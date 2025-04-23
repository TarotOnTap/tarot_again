import 'package:flutter/material.dart';
import 'package:tarot_again/blocs/blocs.dart';
import 'package:tarot_again/data_layer/data_layer.dart';
import 'package:tarot_again/util/util.dart';

import 'grid_layout_widget.dart';
import 'linear_layout_widget.dart';

@immutable
class LayoutSlotsWidget extends StatelessWidget with Logging {
  final List<Widget> children;

  const LayoutSlotsWidget({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LayoutBloc, LayoutState>(
      buildWhen: (prev, state) => prev.currentLayout != state.currentLayout,
      builder:
          (BuildContext context, LayoutState state) => switch (state
              .currentLayout) {
            HorizontalLinear hl => LinearLayoutWidget(
              layoutDetails: hl,
              children: children,
            ),
            SimpleGrid sg => GridLayoutWidget(
              layoutDetails: sg,
              children: children,
            ),
            NullLayout nl => Placeholder(child: Text("No layout selected")),
          },
    );
  }
}
