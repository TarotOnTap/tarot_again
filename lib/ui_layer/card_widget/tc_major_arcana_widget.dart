import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:tarot_again/util/util.dart';

class TCMajorArcanaWidget extends StatefulWidget {
  final TarotDeckCards card;

  // final TCModelAssets? assets;
  final String assetName;

  const TCMajorArcanaWidget({
    super.key,
    required this.card,
    required this.assetName,
    // this.assets,
  });

  @override
  State<TCMajorArcanaWidget> createState() => _TCMajorArcanaWidgetState();
}

class _TCMajorArcanaWidgetState extends State<TCMajorArcanaWidget>
    with Logging {
  TCModelAssets? assets;

  @override
  void initState() {
    super.initState();

    // sl<DeckRepository>().loadCardAssets(widget.card, setCardAssets);
  }

  // callback for loadCardAssets
  void setCardAssets(TCModelAssets? newAssets) {
    final lg = bufferedVerbose("TCMajorArcanaWidgetState.setCardAssets()");
    lg.addln("  newAssets is '$newAssets'");
    if (assets == null && newAssets != null) {
      lg.addln("  setting assets to newAssets");
      setState(() => assets = newAssets);
    } else {
      lg.addln("  not setting new assets.");
    }

    lg.commit();
  }

  @override
  Widget build(BuildContext context) {
    final lg = bufferedVerbose("TCMajorArcanaWidget.build()");
    // lg.addln("  assetName is '$assetName'");
    lg.addln("  card is ${widget.card}");
    lg.addln("  assets is $assets");
    Widget returnWidget = Placeholder(child: Text("TCMajorArcanaWidget"));

    final theme = TextTheme.of(context);

    final imageAsset = assets?.image;
    lg.addln("  imageAsset is $imageAsset");
    lg.commit();

    if (imageAsset != null) {
      returnWidget = imageAsset.image(
        errorBuilder:
            (BuildContext context, Object error, StackTrace? stacktrace) {
              final List<Widget> names = [
                for (var item in widget.card.displayName.split(" "))
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
                    widget.card.romanNumber.name.toUpperCase(),
                    style: theme.titleSmall,
                  ),
                ),
              );

              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: columnChildren,
              );
            },
      );
    }

    return returnWidget;
  }
}
