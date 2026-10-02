import 'package:align_positioned/align_positioned.dart';
import 'package:flutter/material.dart';
import 'package:tarot_again/ui_layer/layout_widget/layout_widget.dart';
import 'package:tarot_again/ui_layer/layout_widget/layout_background.dart';
import 'package:tarot_again/util/util.dart';

@immutable
class CardsStageLayout extends StatelessWidget with Logging {
  const CardsStageLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        verbose("CardStateLayout.build: constraints are $constraints");

        SignalsManager.cardWidth.value = constraints.maxWidth / 6;
        SignalsManager.cardHeight.value = SignalsManager.cardWidth.value * 1.6;
        verbose(
          "CardStateLayout.build: cardWidth is ${SignalsManager.cardWidth.value}, cardHeight is ${SignalsManager.cardHeight.value}",
        );

        return SizedBox(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          child: Stack(
            children: <Widget>[
              Center(child: LayoutBackground()),
              Center(child: LayoutWidget()),
              AlignPositioned(
                alignment: Alignment.topLeft,
                dx: 5,
                dy: 5,
                touch: Touch.inside,
                child: SignalBuilder(
                  builder: (context) => Text(
                    SignalsManager.tarotLayout.value.displayName,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
