import 'package:tarot_again/util/flutter_util.dart';

import '../sidebar_layout/sidebar_layout.dart';
import '../ui_layer.dart';
import 'cards_stage_layout.dart';
import 'main_scaffold.dart';

@immutable
class TopLevelLayout extends StatelessWidget {
  const TopLevelLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      child: Row(
        children: <Widget>[
          Flexible(child: CommandButtons()),
          Expanded(flex: 3, child: CardsStageLayout()),
          Expanded(flex: 1, child: SidebarLayout()),
        ],
      ),
    );
  }
}
