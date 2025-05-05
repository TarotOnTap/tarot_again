import 'package:flutter/material.dart';
import 'package:tarot_again/data_layer/data_layer.dart';
import 'package:tarot_again/util/util.dart';

class TCMinorArcanaWidget extends StatelessWidget with Logging {
  final TCMinorArcanaModel card;
  final String assetName;
  final TCModelAssets? assets;

  const TCMinorArcanaWidget({
    super.key,
    required this.card,
    required this.assetName,
    this.assets,
  });

  String _initialUpper(String input) =>
      input.substring(0, 1).toUpperCase() + input.substring(1);

  @override
  Widget build(BuildContext context) {
    verbose("in build function");
    verbose("  assetName is '$assetName'");
    Widget returnWidget = Placeholder(child: Text("TCMajorArcanaWidget"));

    final theme = TextTheme.of(context);
    final imageAsset = assets?.image;

    if (imageAsset != null) {
      returnWidget = imageAsset.image(
        errorBuilder: (
          BuildContext context,
          Object error,
          StackTrace? stacktrace,
        ) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(_initialUpper(card.pips.name), style: theme.titleSmall),
              Text("of"),
              Text(_initialUpper(card.suit.name), style: theme.titleSmall),
            ],
          );
        },
      );
    }

    return returnWidget;
  }
}
