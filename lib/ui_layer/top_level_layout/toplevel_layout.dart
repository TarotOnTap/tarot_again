import 'package:tarot_again/util/flutter_util.dart';

import '../sidebar_layout/sidebar_layout.dart';
import '../ui_layer.dart';
import 'cards_stage_layout.dart';
import 'main_scaffold.dart';

@Preview(name: 'Top Level Layout')
Widget topLevelLayoutPreview() => const TopLevelLayout();

@immutable
class const TopLevelLayout({super.key}) extends StatelessWidget {
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
