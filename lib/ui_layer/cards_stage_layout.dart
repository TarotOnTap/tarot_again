import 'package:align_positioned/align_positioned.dart';
import 'package:flutter/material.dart';
import 'package:tarot_again/blocs/blocs.dart';
import 'package:tarot_again/util/util.dart';

import 'layout_widget/layout_widget.dart';

@immutable
class CardsStageLayout extends WatchingWidget with Logging {
  const CardsStageLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Center(child: LayoutWidget()),
        AlignPositioned(
          alignment: Alignment.topLeft,
          dx: 5,
          dy: 5,
          touch: Touch.inside,
          child: Text(
            sl<LayoutBloc>().state.currentLayoutName,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
      ],
    );
  }
}
