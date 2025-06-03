import 'package:flutter/material.dart';
import 'package:tarot_again/util/util.dart';

import 'grid_layout_widget.dart';
import 'linear_layout_widget.dart';

class LayoutWidget extends StatelessWidget with Logging {
  const LayoutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Watch(
      (context) => switch (SignalsManager.tarotLayout.value) {
        HorizontalLinear hl => LinearLayoutWidget(layoutDetails: hl),
        SimpleGrid sg => GridLayoutWidget(layoutDetails: sg),
        NullLayout _ => Placeholder(child: Text("No layout selected")),
      },
    );
  }
}
