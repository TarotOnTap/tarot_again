import 'package:flutter/material.dart';
import 'package:tarot_again/data_layer/data_layer.dart';
import 'package:tarot_again/util/util.dart';

import 'layout_widget.dart';

@immutable
class GridLayoutWidget extends WatchingWidget with Logging {
  final SimpleGrid layoutDetails;
  final LayoutWidgetState parentWidgetState;

  const GridLayoutWidget({
    super.key,
    required this.layoutDetails,
    required this.parentWidgetState,
  });

  @override
  Widget build(BuildContext context) {
    // I don't think we need to watch for changes in layout state. If I do, change
    // to watchBloc.
    // final LayoutBloc layoutBloc = sl<LayoutBloc>();
    //
    // final TarotLayout layoutSpecifics = layoutBloc.state.currentLayout;

    return Placeholder(child: Text("GridLayoutWidget"));
  }
}
