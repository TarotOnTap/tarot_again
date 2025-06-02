import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:tarot_again/util/util.dart';

class PlaintextMajorArcanaWidget extends StatelessWidget with Logging {
  final TarotDeckCards card;

  PlaintextMajorArcanaWidget({super.key, required this.card});

  @override
  Widget build(BuildContext context) => Watch((context) {
    // watch is only watching for changes in our theme, here
    final theme = TextTheme.of(context);

    final List<Widget> names = [
      for (var item in card.displayName.split(" "))
        Text(item, style: theme.titleSmall),
    ];

    final List<Widget> columnChildren = [];

    for (var item in names) {
      columnChildren.add(item);
      columnChildren.add(Gap(5));
    }

    columnChildren.add(
      Expanded(
        flex: 4,
        child: Text(
          card.romanNumber.name.toUpperCase(),
          style: theme.titleSmall,
        ),
      ),
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: columnChildren,
    );
  });
}

class TCMajorArcanaWidget extends StatelessWidget with Logging {
  final SlotState slotState;

  const TCMajorArcanaWidget({super.key, required this.slotState});

  @override
  Widget build(BuildContext context) => Watch((context) {
    final lg = bufferedVerbose("TCMajorArcanaWidget.build()");
    lg.addln("  card is ${slotState.deckCard.value}");
    lg.addln("  assets is ${slotState.assets.value}");
    Widget returnWidget = Placeholder(child: Text("TCMajorArcanaWidget"));

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
                  PlaintextMajorArcanaWidget(card: card),
        );
      } else {
        returnWidget = PlaintextMajorArcanaWidget(card: card);
      }
    }

    return returnWidget;
  });
}
