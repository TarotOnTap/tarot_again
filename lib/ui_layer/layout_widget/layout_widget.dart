import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:tarot_again/util/util.dart';

import 'grid_layout_widget.dart';
import 'layout_constrained.dart';

class LayoutWidget extends StatelessWidget with Logging {
  @Preview(name: 'LayoutWidget')
  const LayoutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Watch(
      (context) => switch (SignalsManager.tarotLayout.value!) {
        // HorizontalLinear hl => LinearLayoutWidget(layoutDetails: hl),
        SimpleGrid sg => GridLayoutWidget(layoutDetails: sg),
        NullLayout _ => Placeholder(child: Text("No layout selected")),
        // StackLayout _ => Placeholder(child: Text("Stack Layout")),
        // ComplexLayout _ => Placeholder(child: Text("Complex Layout")),
        NewTarotLayout nt => LayoutConstrained(layout: nt),
      },
    );
  }
}
