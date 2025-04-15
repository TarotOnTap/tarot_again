import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tarot_again/blocs/blocs.dart';
import 'package:tarot_again/data_layer/data_layer.dart';
import 'package:tarot_again/util/util.dart';

import 'deck_card_widget.dart';

part 'deck_empty_widget.dart';
part 'deck_initial_widget.dart';

final Matrix4 _upright = Matrix4.identity();
final Matrix4 _reversed = Matrix4.rotationZ(pi / 3);

// extension WatchBloc<BlocType extends BlocBase, BlocStateType> on WatchingWidget {
// AsyncSnapshot<R> watchStream<T extends Object, R>(
//     Stream<R> Function(T)? select, {
//       T? target,
//       R? initialValue,
//       bool preserveState = true,
//       String? instanceName,
//       GetIt? getIt,
//     }) {

AsyncSnapshot<BlocStateType>
watchBloc<BlocType extends BlocBase, BlocStateType>(
  BlocType Function(BlocType)? select, {
  BlocType? bloc,
  BlocStateType? initialState,
  bool preserveState = true,
  String? instanceName,
  GetIt? getIt,
}) {
  BlocType targetBloc;

  if (select != null) {
    targetBloc = di<BlocType>();
  } else {
    targetBloc = bloc!;
  }

  return watchStream(
    null,
    target: targetBloc,
    initialValue: initialState ?? targetBloc.state,
    preserveState: preserveState,
    instanceName: instanceName,
    getIt: getIt,
  );
}
// }
//
// extension StatfulWatchBloc<BlocType extends BlocBase, BlocStateType> on WatchingStatefulWidget {
//   watchBloc({
//     required BlocType bloc,
//     BlocStateType? initialState,
//     bool preserveState = true,
//     String? instanceName,
//     GetIt? getIt,
//   }) => watchStream(
//       null,
//       target: bloc,
//       initialValue: initialState ?? bloc.state,
//       preserveState: preserveState,
//       instanceName: instanceName,
//       getIt: getIt,
//     );
// }

class CardWidget extends WatchingStatefulWidget {
  final DealtCard card;

  const CardWidget({super.key, required this.card});

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  bool faceUp = false;

  // bool reversed = false;

  void setFaceUp() => setState(() => faceUp = true);

  void unSetFaceUp() => setState(() => faceUp = false);

  void flipFaceUp() => setState(() => faceUp = !faceUp);

  @override
  Widget build(BuildContext context) {
    final what = watchBloc((BulkCardControlBloc b) => b);

    // BulkCardControlBloc bcBloc = sl<BulkCardControlBloc>();
    //
    // BulkCardControlState bcState = bcBloc.state;
    //
    // final AsyncSnapshot<BulkCardControlState> bccState = watchBloc(bcBloc)
    //
    // final AsyncSnapshot<BulkCardControlState> bccState = watchStream(
    //   ((BulkCardControlBloc bcc) => bcc.stream),
    //   initialValue: bcState,
    // );

    final BulkCardControlState data = what.data!;

    Matrix4 reversalType = _upright;

    if (widget.card case DeckCard(reversed: var r)) {
      reversalType = (data.reversalsAllowed && r) ? _reversed : _upright;
    }

    // Widget returnWidget = switch (widget.card) {
    //   DeckCard() => DeckCardWidget(card: widget.card as DeckCard),
    //   DeckEmpty() => DeckEmptyWidget(),
    //   DeckInitial() => DeckInitialWidget(),
    // };

    // TODO: the faceUp and faceDown logic need to happen somewhere, probably
    // at this level. Need to add BulkCardBloc at the top in order to have access
    // to reversalsAllowed and the global faceUp choice.
    return Container(
      width: 80,
      height: 150,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(border: Border.all(width: 2)),
      alignment: Alignment.center,
      transform: reversalType,
      child: switch (widget.card) {
        DeckCard() => DeckCardWidget(card: widget.card as DeckCard),
        DeckEmpty() => DeckEmptyWidget(),
        DeckInitial() => DeckInitialWidget(),
      },
    );
  }
}

@immutable
class CardWidgetOld extends WatchingWidget with Logging {
  final DealtCard dealtCard;
  final CardWidgetBloc cardBloc;

  CardWidgetOld({super.key, required this.dealtCard, required this.cardBloc}) {
    verbose("CardWidget constructor");
    verbose("  dealtCard: $dealtCard");
  }

  @override
  Widget build(BuildContext context) {
    verbose("build method");

    BulkCardControlBloc bcBloc = sl<BulkCardControlBloc>();

    BulkCardControlState bcState = bcBloc.state;

    final AsyncSnapshot<BulkCardControlState> bccState = watchStream(
      ((BulkCardControlBloc bcc) => bcc.stream),
      initialValue: bcState,
    );

    final AsyncSnapshot<CardWidgetState> cwState = watchStream(
      null,
      target: cardBloc.stream,
      initialValue: cardBloc.state,
    );

    CardWidgetState dt = cardBloc.state;
    verbose("  cardBloc.state.faceUp: ${dt.faceUp}");
    verbose("  cardBloc.state.reversed: ${dt.reversed}");

    Widget returnWidget = switch (dt.card) {
      DeckCard() => DeckCardWidget(card: dt.card as DeckCard),
      DeckEmpty() => DeckEmptyWidget(),
      DeckInitial() => DeckInitialWidget(),
    };

    // TODO: the faceUp and faceDown logic need to happen somewhere, probably
    // at this level. Need to add BulkCardBloc at the top in order to have access
    // to reversalsAllowed and the global faceUp choice.
    return Container(
      width: 80,
      height: 150,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(border: Border.all(width: 2)),
      alignment: Alignment.center,
      transform: dt.reversed ? _reversed : _upright,
      child: returnWidget,
    );
  }
}
