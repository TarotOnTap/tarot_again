import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:tarot_again/ui_layer/ui_layer.dart';
import 'package:tarot_again/util/flutter_util.dart';
import 'package:tarot_again/util/util.dart';

@immutable
class GridLayoutWidget extends StatelessWidget with Logging {
  final SimpleGrid layoutDetails;

  const GridLayoutWidget({super.key, required this.layoutDetails});

  @override
  Widget build(BuildContext context) => SignalBuilder(
    builder: (context) => LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        sl<SignalsManager>().cardWidth.value = constraints.maxWidth / 8.0;
        sl<SignalsManager>().cardHeight.value =
            sl<SignalsManager>().cardWidth.value * 1.6;

        final int numCards = switch (sl<SignalsManager>().tarotLayout.value) {
          // HorizontalLinear(:final numCards) => numCards,
          SimpleGrid(:final numCards) => numCards,
          NullLayout() => 0,
          NewTarotLayout(:final positions) => positions.length,
        };

        int numColumns =
            (constraints.maxWidth / sl<SignalsManager>().cardWidth.value)
                .toInt();

        int numRows = numCards ~/ numColumns + 1;

        return SingleChildScrollView(
          child: LayoutGrid(
            columnSizes: repeat(numColumns, [
              sl<SignalsManager>().cardWidth.value.px,
            ]),
            rowSizes: repeat(numRows, [
              sl<SignalsManager>().cardHeight.value.px,
            ]),
            columnGap: 10.0,
            rowGap: 10,
            autoPlacement: AutoPlacement.rowDense,
            children: layoutDetails.numCards.range
                .map(
                  (index) => GridPlacement(
                    child: Center(
                      child: PositionSlotWidget(
                        key: sl<ComputedsManager>().slotKeys.value[index],
                        slotIndex: index,
                        slotName: "slot $index",
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        );
      },
    ),
  );
}
