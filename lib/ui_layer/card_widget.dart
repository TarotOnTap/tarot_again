import 'package:flutter/material.dart';
import 'package:tarot_again/blocs/blocs.dart';
import 'package:tarot_again/util/util.dart';

class CardWidget extends WatchingWidget {
  final BulkCardControlBloc bccBloc;
  final CardWidgetBloc cwBloc;

  const CardWidget({super.key, required this.bccBloc, required this.cwBloc});

  @override
  Widget build(BuildContext context) {
    final AsyncSnapshot<BulkCardControlState> _bccState = watchStream(
      null,
      target: bccBloc.stream,
      initialValue: BulkCardControlState(),
    );
    AsyncSnapshot<CardWidgetState> _cwState = watchStream(
      null,
      target: cwBloc.stream,
      initialValue: CardWidgetState(),
    );

    Widget? bcData;
    Widget? cwData;

    if (_bccState.hasData) {
      StringBuffer bcstr = StringBuffer();

      final BulkCardControlState data = _bccState.data as BulkCardControlState;
      bcstr.write("bccState:");

      bcstr.writeln(" ValidBulkCardControlState");
      bcstr.writeln("  deckName: ${data.deckName}");
      bcstr.writeln("  everybodyFaceUp: ${data.everybodyFaceUp}");
      bcstr.writeln("  reversalsAllowed: ${data.reversalsAllowed}");

      bcstr.writeln(" ");

      bcData = Text(bcstr.toString());
    }

    if (_cwState.hasData) {
      StringBuffer cwstr = StringBuffer();
      final CardWidgetState data = _cwState.data as CardWidgetState;
      cwstr.write("_cwState:");

      cwstr.writeln(" ValidCardWidgetState");
      cwstr.writeln("  card: ${cwBloc.card}");
      cwstr.writeln("  faceUp: ${data.faceUp}");
      cwstr.writeln("  reversed: ${data.reversed}");

      cwData = Text(cwstr.toString());
    }

    return Column(
      children: [if (bcData != null) bcData, if (cwData != null) cwData],
    );
  }
}
