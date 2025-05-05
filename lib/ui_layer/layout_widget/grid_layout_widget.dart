import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:tarot_again/blocs/blocs.dart';
import 'package:tarot_again/data_layer/data_layer.dart';
import 'package:tarot_again/ui_layer/ui_layer.dart';
import 'package:tarot_again/util/util.dart';

@immutable
class GridLayoutWidget extends StatelessWidget with Logging {
  final SimpleGrid layoutDetails;

  const GridLayoutWidget({super.key, required this.layoutDetails});

  @override
  Widget build(BuildContext context) => BlocBuilder<LayoutBloc, LayoutState>(
    builder:
        (context, lwState) => LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            int numColumns = (constraints.maxWidth / 110.0).toInt();

            int numRows = lwState.currentLayout.numCards ~/ numColumns + 1;

            verbose("GridLayoutWidget.builder");
            verbose("  numColumns is $numColumns; numRows is $numRows");

            return SingleChildScrollView(
              child: LayoutGrid(
                columnSizes: repeat(numColumns, [100.px]),
                rowSizes: repeat(numRows, [160.px]),
                columnGap: 10.0,
                rowGap: 10,
                autoPlacement: AutoPlacement.rowDense,
                children: [
                  for (var index in lwState.currentLayout.numCards.range())
                    GridPlacement(
                      child: Center(child: PositionSlotWidget(index: index)),
                    ),
                ],
              ),
            );
          },
        ),
  );
}
