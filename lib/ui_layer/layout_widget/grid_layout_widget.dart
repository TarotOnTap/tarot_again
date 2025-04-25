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
        (context, lwState) => GridView.builder(
          itemCount: lwState.slotWidgetStates.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 8,
          ),
          itemBuilder:
              (BuildContext context, int index) =>
                  PositionSlotWidget(index: index),
        ),
  );
}
