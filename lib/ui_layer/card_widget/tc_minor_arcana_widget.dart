import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:tarot_again/util/util.dart';

class PlaintextMinorArcanaWidget extends StatelessWidget with Logging {
  final TarotDeckCards card;

  PlaintextMinorArcanaWidget({super.key, required this.card});

  @override
  Widget build(BuildContext context) => Watch((context) {
    // watch is only watching for changes in our theme, here
    final theme = TextTheme.of(context);

    final List<Widget> names = [
      card.pips.name,
      "of",
      card.suit.name,
    ].map((item) => Text(item, style: theme.titleSmall)).toList();

    final List<Widget> columnChildren = [];

    for (var item in names) {
      columnChildren.add(item);
      columnChildren.add(Gap(5));
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: columnChildren,
    );
  }, debugLabel: "PlaintextMinorArcanaWidget");
}

class TCMinorArcanaWidget extends StatelessWidget with Logging {
  // final TarotDeckCards card;
  final SlotState slotState;

  const TCMinorArcanaWidget({
    super.key,
    required this.slotState,
    // required this.card,
    // required this.assetName,
    // this.assets,
  });

  @override
  Widget build(BuildContext context) => Watch((context) {
    final lg = bufferedVerbose("TCMinorArcanaWidget.build()");
    lg.addln("  card is ${slotState.deckCard.value}");
    lg.addln("  assets is ${slotState.assets.value}");
    Widget returnWidget = Placeholder(child: Text("TCMinorArcanaWidget"));

    if (slotState.isDealt) {
      final card = slotState.deckCard.value!;
      final assets = slotState.assets.value!;

      final imageAsset = assets.image;
      lg.addln("  imageAsset is $imageAsset");
      lg.commit();

      if (imageAsset != null) {
        returnWidget = imageAsset.image(
          errorBuilder:
              (BuildContext context, Object error, StackTrace? stacktrace) =>
                  PlaintextMinorArcanaWidget(card: card),
        );
      } else {
        returnWidget = PlaintextMinorArcanaWidget(card: card);
      }
    }

    return returnWidget;
  });
}
