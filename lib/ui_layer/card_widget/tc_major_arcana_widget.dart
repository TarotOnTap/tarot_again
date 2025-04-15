import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:tarot_again/data_layer/data_layer.dart';
import 'package:tarot_again/util/util.dart';

class TCMajorArcanaWidget extends StatelessWidget with Logging {
  final TCMajorArcanaModel card;
  final String assetName;

  const TCMajorArcanaWidget({
    super.key,
    required this.card,
    required this.assetName,
  });

  @override
  Widget build(BuildContext context) {
    Widget returnWidget = Placeholder(child: Text("TCMajorArcanaWidget"));

    returnWidget = Image.asset(
      assetName,
      errorBuilder: (
        BuildContext context,
        Object error,
        StackTrace? stacktrace,
      ) {
        final List<Widget> names = [
          for (var item in card.card.name.split(" ")) Text(item),
        ];

        final List<Widget> columnChildren = [];

        for (var item in names) {
          columnChildren.add(item);
          columnChildren.add(Gap(5));
        }

        columnChildren.add(
          Expanded(flex: 4, child: Text(card.card.romanNumber)),
        );

        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: columnChildren,
        );
      },
    );

    return returnWidget;
  }
}
