import 'package:flutter/material.dart';
import 'package:tarot_again/util/util.dart';

class CardsStageLayout extends WatchingWidget {
  const CardsStageLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Placeholder(child: Text("Not Yet Implemented"));
    // final AsyncSnapshot<BulkCardControlState> _bccState = watchStream(
    //   ((BulkCardControlBloc bcc) => bcc.stream),
    //   initialValue: BulkCardControlState(),
    // );
    //
    // Widget result;
    //
    // if (_bccState.hasData) {
    //   final dt = _bccState.data!;
    //
    //   IList<Widget> kids = const IList<Widget>.empty();
    //
    //   dt.positions.flatMap((CardPositions positions) {
    //     for (var item in positions) {
    //       kids.add(CardWidget(item));
    //     }
    //   });
    //
    //   Stack(children: <Widget>[for (var cw in dt.)
    // }
    //
    // return Stack(children: <Widget>[CardWidget(cwBloc: cards[0])]);
  }
}
