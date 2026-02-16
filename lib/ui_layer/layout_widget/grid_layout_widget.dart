import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:tarot_again/ui_layer/ui_layer.dart';
import 'package:tarot_again/util/flutter_util.dart';
import 'package:tarot_again/util/util.dart';

@immutable
class GridLayoutWidget extends StatelessWidget with Logging {
  final SimpleGrid layoutDetails;

  const GridLayoutWidget({super.key, required this.layoutDetails});

  @override
  Widget build(BuildContext context) => Watch(
    (context) => LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final int numCards = switch (SignalsManager.tarotLayout.value) {
          // HorizontalLinear(:final numCards) => numCards,
          SimpleGrid(:final numCards) => numCards,
          NullLayout() => 0,
          NewTarotLayout(:final positions) => positions.length,
        };

        int numColumns = (constraints.maxWidth / 110.0).toInt();

        int numRows = numCards ~/ numColumns + 1;

        verbose("GridLayoutWidget.builder");
        verbose("  numColumns is $numColumns; numRows is $numRows");

        return SingleChildScrollView(
          child: LayoutGrid(
            columnSizes: repeat(numColumns, [100.px]),
            rowSizes: repeat(numRows, [160.px]),
            columnGap: 10.0,
            rowGap: 10,
            autoPlacement: AutoPlacement.rowDense,
            children: layoutDetails.numCards.range
                .map(
                  (index) => GridPlacement(
                    child: Center(
                      child: PositionSlotWidget(
                        key: ComputedsManager.slotKeys.value[index],
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
