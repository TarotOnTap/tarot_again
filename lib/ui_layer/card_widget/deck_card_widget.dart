import 'package:flutter/material.dart';
import 'package:tarot_again/data_layer/data_layer.dart';
import 'package:tarot_again/util/util.dart';

import 'tc_major_arcana_widget.dart';
import 'tc_minor_arcana_widget.dart';

@immutable
class DeckCardWidget extends StatelessWidget with Logging {
  final DeckCard card;

  const DeckCardWidget({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    // This bit below can be removed in production. It just makes sure we always
    // have something to return.
    Widget returnWidget = Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[Text("Deck"), Text("Card"), Text("Widget")],
    );

    returnWidget = switch (card.tcCard) {
      TCMajorArcanaModel majorModel => TCMajorArcanaWidget(
        assetName: majorModel.assetName,
        card: majorModel,
      ),
      TCMinorArcanaModel minorModel => TCMinorArcanaWidget(
        card: minorModel,
        assetName: minorModel.assetName,
      ),
      DeckInitial() => Column(children: [Text("Deck"), Text("Initial")]),
      DeckEmpty() => Column(children: [Text("Deck"), Text("Empty")]),
    };

    return returnWidget;
  }
}
