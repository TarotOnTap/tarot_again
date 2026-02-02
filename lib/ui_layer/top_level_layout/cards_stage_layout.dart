import 'package:align_positioned/align_positioned.dart';
import 'package:flutter/material.dart';
import 'package:tarot_again/ui_layer/flame_system/flame_system.dart';
import 'package:tarot_again/util/util.dart';

@immutable
class CardsStageLayout extends StatelessWidget with Logging {
  const CardsStageLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        // Center(child: LayoutWidget()),
        Center(child: FlameSystemWidget()),
        AlignPositioned(
          alignment: Alignment.topLeft,
          dx: 5,
          dy: 5,
          touch: Touch.inside,
          child: Watch(
            (context) => Text(
              SignalsManager.tarotLayout.value.displayName,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
        ),
      ],
    );
  }
}
