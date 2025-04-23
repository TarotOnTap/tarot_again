import 'package:flutter/material.dart';
import 'package:tarot_again/blocs/blocs.dart';
import 'package:tarot_again/data_layer/data_layer.dart';
import 'package:tarot_again/util/util.dart';

import 'grid_layout_widget.dart';
import 'linear_layout_widget.dart';

@immutable
class LayoutSlotsWidget extends StatelessWidget with Logging {
  const LayoutSlotsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LayoutBloc, LayoutState>(
      builder:
          (BuildContext context, LayoutState state) => switch (state
              .currentLayout) {
            HorizontalLinear hl => LinearLayoutWidget(layoutDetails: hl),
            SimpleGrid sg => GridLayoutWidget(layoutDetails: sg),
            NullLayout nl => Placeholder(child: Text("No layout selected")),
          },
    );
  }
}
