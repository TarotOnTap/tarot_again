import 'package:tarot_again/blocs/blocs.dart';
import 'package:tarot_again/data_layer/data_layer.dart';
import 'package:tarot_again/ui_layer/ui_layer.dart';
import 'package:tarot_again/util/util.dart';

@immutable
class GridLayoutWidget extends StatelessWidget with Logging {
  final SimpleGrid layoutDetails;

  const GridLayoutWidget({super.key, required this.layoutDetails});

  @override
  Widget build(BuildContext context) {
    verbose("GridLayoutWidget.build");

    return context.findAncestorStateOfType<LayoutWidgetState>()?.let((lwState) {
          return GridView.builder(
            itemCount: lwState.slotBlocs.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 8,
            ),
            itemBuilder:
                (BuildContext context, int index) =>
                    BlocProvider<SlotWidgetBloc>(
                      create: (_) => lwState.slotBlocs[index],
                      child: PositionSlotWidget(),
                    ),
          );
        }) ??
        Placeholder(child: Text("GridLayoutWidget"));
  }
}
