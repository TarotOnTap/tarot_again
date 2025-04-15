import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:tarot_again/blocs/blocs.dart';
import 'package:tarot_again/data_layer/data_layer.dart';
import 'package:tarot_again/util/util.dart';

import 'card_widget/card_widget.dart';

@immutable
class CardsStageLayout extends WatchingWidget with Logging {
  const CardsStageLayout({super.key});

  @override
  Widget build(BuildContext context) {
    // return Placeholder(child: Text("Not Yet Implemented"));
    final bcBloc = sl<BulkCardControlBloc>();

    final AsyncSnapshot<BulkCardControlState> bccState = watchStream(
      ((BulkCardControlBloc bcc) => bcc.stream),
      initialValue: BulkCardControlState(),
    );

    Widget result = Center(
      child: Placeholder(child: Text("Stage Build had no result.")),
    );

    // Iterable<Widget> kids = const IList<Widget>.empty();
    // Iterable<CardWidgetBloc> kidsBlocs = const IList<CardWidgetBloc>.empty();

    verbose("CardStageLayout.build: everything is ready to go.");

    final dt = bcBloc.state;

    int idCount = 0;

    Iterable<DealtCard>? cardsList;

    switch (dt.cards) {
      case Some<Iterable<DealtCard>>(value: var v):
        verbose("  dt.cards is Some");

        // kidsBlocs = v.map(
        //   (DealtCard c) => CardWidgetBloc(id: c.toString(), card: c),
        // );

        // final paramsList = v.zip(kidsBlocs);
        result = Row(
          children: v.fold(
            <Widget>[],
            (prev, elem) => prev + [CardWidget(card: elem)],
            // [CardWidgetOld(dealtCard: elem.$1, cardBloc: elem.$2), Gap(6)],
          ),
        );
      case None():
        verbose("  dt.cards is None");
        result = Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text("No Cards Dealt")],
        );
    }

    return result;
  }
}
