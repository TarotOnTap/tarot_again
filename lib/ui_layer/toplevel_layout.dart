import 'cards_stage_layout.dart';
import 'sidebar_layout/sidebar_layout.dart';
import 'ui_layer.dart';

class TopLevelLayout extends StatelessWidget {
  const TopLevelLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(flex: 1, child: CommandButtons()),
        Expanded(flex: 2, child: CardsStageLayout()),
        Expanded(flex: 1, child: SidebarLayout()),
      ],
    );
  }
}
