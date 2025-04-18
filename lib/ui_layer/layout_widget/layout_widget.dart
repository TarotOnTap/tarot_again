import 'package:flutter/material.dart';
import 'package:tarot_again/blocs/blocs.dart';
import 'package:tarot_again/data_layer/data_layer.dart';
import 'package:tarot_again/ui_layer/ui_layer.dart';
import 'package:tarot_again/util/util.dart';

@immutable
class LayoutWidget extends WatchingWidget with Logging {
  LayoutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final LayoutState state = watchBloc((LayoutBloc b) => b).data!;

    final layoutType = switch (state) {
      LayoutInitial() => Column(
        children: <Widget>[
          Text("Choose a layout using the selector to the left"),
          Text("choices are:"),
          for (var name in state.layoutNames) Text("  $name"),
        ],
      ),
      LayoutStateReadyToDeal() => LayoutStateReadyToDealWidget(state: state),
      LayoutStateDealt() => Placeholder(
        child: Column(
          children: [Text("LayoutWidget"), Text("ChangeLayoutState")],
        ),
      ),
    };

    return layoutType;
  }
}

@immutable
class LayoutStateReadyToDealWidget extends WatchingWidget with Logging {
  // passing state as a parameter prevents us from having to watch the
  // layout bloc for changes. If our parent needs us to change, we will - we don't
  // have to watch out for that.
  final LayoutStateReadyToDeal state;

  LayoutStateReadyToDealWidget({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    // TODO this is the place where the actual layout happens, using one of the layout
    // TODO widgets. Do the layout, then give a big "Deal Cards" button or some other
    // TODO mechanism to fill the slot widgets with dealt cards.
    return switch (state.currentLayout) {
      HorizontalLinear hl => LinearLayoutWidget(
        slotKeys: state.slotKeys,
        layout: hl,
      ),
      SimpleGrid sg => GridLayoutWidget(),
      NullLayout nl => NullLayoutWidget(),
    };
  }
}

@immutable
class LinearLayoutWidget extends WatchingWidget with Logging {
  final KeyIterable slotKeys;
  final HorizontalLinear layout;

  LinearLayoutWidget({super.key, required this.slotKeys, required this.layout});

  @override
  Widget build(BuildContext context) {
    final slotInfo = IList<SlotKey>(slotKeys).zip(IList<String>(layout.slots));

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        for (var (k, p) in slotInfo)
          PositionSlotWidget(key: k, positionTitle: p),
      ],
    );
  }
}

@immutable
class GridLayoutWidget extends WatchingWidget with Logging {
  GridLayoutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // I don't think we need to watch for changes in layout state. If I do, change
    // to watchBloc.
    final LayoutBloc layoutBloc = sl<LayoutBloc>();

    final TarotLayout layoutSpecifics = layoutBloc.state.currentLayout;

    return Placeholder(child: Text("GridLayoutWidget"));
  }
}

@immutable
class NullLayoutWidget extends WatchingWidget with Logging {
  NullLayoutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // I don't think we need to watch for changes in layout state. If I do, change
    // to watchBloc.
    final LayoutBloc layoutBloc = sl<LayoutBloc>();

    final TarotLayout layoutSpecifics = layoutBloc.state.currentLayout;

    return Placeholder(child: Text("NullLayoutWidget"));
  }
}
