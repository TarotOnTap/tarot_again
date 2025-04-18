import 'package:flutter/material.dart';
import 'package:tarot_again/blocs/blocs.dart';
import 'package:tarot_again/data_layer/data_layer.dart';
import 'package:tarot_again/ui_layer/card_widget/card_widget.dart';
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
      // TODO is this state really necessary? I don't know what to do with it
      // ChangeLayoutState() => Placeholder(
      //   child: Column(
      //     children: [Text("LayoutWidget"), Text("ChangeLayoutState")],
      //   ),
      // ),
      LayoutStateReadyToDeal() => LayoutStateReadyToDealWidget(),
      // TODO is this state really necessary? The child layout widgets actually handle dealt cards
      // TODO by monitoring BulkCardControlBloc
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
  LayoutStateReadyToDealWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO this is the place where the actual layout happens, using one of the layout
    // TODO widgets. Do the layout, then give a big "Deal Cards" button or some other
    // TODO mechanism to fill the slot widgets with dealt cards.
    final layoutState = sl<LayoutBloc>().state;

    return switch (layoutState.currentLayout) {
      HorizontalLinear() => LinearLayoutWidget(),
      SimpleGrid() => GridLayoutWidget(),
      NullLayout() => NullLayoutWidget(),
    };
  }
}

@immutable
class LinearLayoutWidget extends WatchingWidget with Logging {
  LinearLayoutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final layoutInfo = sl<LayoutBloc>().state;
    final HorizontalLinear layout =
        layoutInfo.currentLayout as HorizontalLinear;

    final keys = layout.slots.fold([], (prev, elem) {
      final k = UniqueKey();
      return prev + [(k, elem, SlotWidgetBloc(slotKey: k))];
    });

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        for (var (k, p, s) in keys)
          PositionSlotWidget(key: k, positionTitle: p, slotBloc: s),
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
