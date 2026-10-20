import 'package:align_positioned/align_positioned.dart';
import 'package:material_ui/material_ui.dart';
import 'package:tarot_again/ui_layer/layout_widget/layout_widget.dart';
import 'package:tarot_again/ui_layer/layout_widget/layout_background.dart';
import 'package:tarot_again/util/util.dart';

import '../sidebar_layout/sidebar_layout.dart';
import 'command_buttons.dart';

@immutable
class CardsStageLayout extends StatelessWidget with Logging {
  const CardsStageLayout({super.key});

  Widget _buildCardsState(BuildContext context, BoxConstraints constraints) =>
      SizedBox(
        width: constraints.maxWidth,
        height: constraints.maxHeight,
        child: Stack(
          children: <Widget>[
            Center(child: LayoutBackground()),
            Center(child: LayoutWidget()),
            AlignPositioned(
              alignment: Alignment.topLeft,
              dx: 5,
              dy: 5,
              touch: Touch.inside,
              child: SignalBuilder(
                builder: (context) => Text(
                  sl<SignalsManager>().tarotLayout.value.displayName,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    verbose("Building CardsStageLayout");

    return LayoutBuilder(
      builder: (context, constraints) {
        verbose("CardStageLayout.build builder: constraints are $constraints");

        sl<SignalsManager>().cardWidth.value = constraints.maxWidth / 6;
        sl<SignalsManager>().cardHeight.value =
            sl<SignalsManager>().cardWidth.value * 1.6;

        return Expanded(
          child: Row(
            children: <Widget>[
              Flexible(child: CommandButtons()),
              Expanded(flex: 3, child: _buildCardsState(context, constraints)),
              Expanded(flex: 1, child: SidebarLayout()),
            ],
          ),
        );
      },
    );
  }
}
