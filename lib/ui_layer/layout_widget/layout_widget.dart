import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';
// import 'package:tarot_again/blocs/blocs.dart';
// import 'package:tarot_again/data_layer/data_layer.dart';
import 'package:tarot_again/managers/session_manager/session_manager.dart';
import 'package:tarot_again/util/util.dart';

import 'grid_layout_widget.dart';
import 'linear_layout_widget.dart';

class LayoutWidget extends StatelessWidget with Logging {
  const LayoutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Watch(
      (context) => switch (sl<SessionManager>().tarotLayout.value) {
        HorizontalLinear hl => LinearLayoutWidget(layoutDetails: hl),
        SimpleGrid sg => GridLayoutWidget(layoutDetails: sg),
        NullLayout _ => Placeholder(child: Text("No layout selected")),
      },
    );
  }
}
