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
  Widget build(BuildContext context) => switch (card.tcCard) {
    TCMajorArcanaModel majorModel => TCMajorArcanaWidget(
      assetName: majorModel.assetReference,
      card: majorModel,
    ),
    TCMinorArcanaModel minorModel => TCMinorArcanaWidget(
      card: minorModel,
      assetName: minorModel.assetReference,
    ),
    DeckInitial() => Column(children: [Text("Deck"), Text("Initial")]),
    DeckEmpty() => Column(children: [Text("Deck"), Text("Empty")]),
  };
}
