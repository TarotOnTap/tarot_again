import 'package:flutter_layout_grid/flutter_layout_grid.dart';
// import 'package:tarot_again/data_layer/data_layer.dart';
import 'package:tarot_again/managers/session_manager/session_manager.dart';
import 'package:tarot_again/ui_layer/ui_layer.dart';
import 'package:tarot_again/util/util.dart';

@immutable
class GridLayoutWidget extends StatelessWidget with Logging {
  final SimpleGrid layoutDetails;

  const GridLayoutWidget({super.key, required this.layoutDetails});

  @override
  Widget build(BuildContext context) => Watch(
    (context) => LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final int numCards = sl<SessionManager>().tarotLayout.value.numCards;

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
            children: numCards
                .repeat(
                  (index) => GridPlacement(
                    child: Center(child: PositionSlotWidget(index: index)),
                  ),
                )
                .cast<Widget>()
                .toList(),
            // [
            //       for (var index in numCards.range())
            //         GridPlacement(
            //           child: Center(child: PositionSlotWidget(index: index)),
            //         ),
            //     ],
          ),
        );
      },
    ),
  );
}
