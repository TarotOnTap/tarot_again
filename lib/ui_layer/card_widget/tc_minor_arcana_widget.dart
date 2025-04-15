import 'package:flutter/material.dart';
import 'package:tarot_again/data_layer/data_layer.dart';
import 'package:tarot_again/util/util.dart';

class TCMinorArcanaWidget extends StatelessWidget with Logging {
  final TCMinorArcanaModel card;
  final String assetName;

  const TCMinorArcanaWidget({
    super.key,
    required this.card,
    required this.assetName,
  });

  String _initialUpper(String input) =>
      input.substring(0, 1).toUpperCase() + input.substring(1);

  @override
  Widget build(BuildContext context) {
    Widget returnWidget = Placeholder(child: Text("TCMajorArcanaWidget"));

    returnWidget = Image.asset(
      assetName,
      errorBuilder: (BuildContext context,
          Object error,
          StackTrace? stacktrace,) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(_initialUpper(card.pips.name)),
            Text("of"),
            Text(_initialUpper(card.suit.name)),
          ],
        );
      },
    );

    return returnWidget;
  }
}
