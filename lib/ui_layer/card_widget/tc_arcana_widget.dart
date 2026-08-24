import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:gap/gap.dart';
import 'package:tarot_again/util/util.dart';

class PlaintextArcanaWidget extends StatelessWidget with Logging {
  final TarotDeckCards card;
  final Iterable<String> names;

  PlaintextArcanaWidget({super.key, required this.card, required this.names});

  @override
  Widget build(BuildContext context) => Watch((context) {
    // watch is only watching for changes in our theme, here
    final theme = TextTheme.of(context);

    // final List<Widget> names = [
    //   for (var item in card.displayName.split(" "))
    //     Text(item, style: theme.titleSmall),
    // ];

    final List<Widget> columnChildren = [];

    for (var item in names) {
      columnChildren.add(Text(item, style: theme.titleSmall));
      columnChildren.add(Gap(5));
    }

    if (card.romanNumber != RomanNumerals.none) {
      columnChildren.add(
        Expanded(
          flex: 4,
          child: Text(
            card.romanNumber != RomanNumerals.none
                ? card.romanNumber.name.toUpperCase()
                : " ",
            style: theme.titleSmall,
          ),
        ),
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: columnChildren,
    );
  }, debugLabel: "PlaintextMajorArcanaWidget");
}

class TCArcanaWidget extends StatelessWidget with Logging {
  final SlotState slotState;

  const TCArcanaWidget({super.key, required this.slotState});

  @override
  Widget build(BuildContext context) => Watch((context) {
    final card = slotState.deckCard;

    Iterable<String> names = switch (card.arcana) {
      Arcana.major => card.displayName.split(" "),
      Arcana.minor => [card.pips.name, "of", card.suit.name],
      Arcana.none => [],
    };

    Widget returnWidget = PlaintextArcanaWidget(
      card: slotState.deckCard,
      names: names,
    );

    returnWidget = switch (slotState.assets.image) {
      Some<AssetGenImage>(value: final asset) => asset.image(
        errorBuilder: (
          BuildContext context,
          Object error,
          StackTrace? stacktrace,
        ) => returnWidget,
      ),
      None() => PlaintextArcanaWidget(card: slotState.deckCard, names: names),
    };

    return returnWidget;
  });
}
