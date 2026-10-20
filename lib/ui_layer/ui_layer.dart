import 'package:tarot_again/util/flutter_util.dart';
import 'package:tarot_again/util/util.dart';

import 'top_level_layout/top_level_layout.dart';
import 'journal_editor/journal_editor.dart';
import 'layout_editor/layout_editor.dart';
import 'settings_editor/settings_editor.dart';

export 'top_level_layout/top_level_layout.dart';
export 'journal_editor/journal_editor.dart';
export 'layout_editor/layout_editor.dart';
export 'settings_editor/settings_editor.dart';
export 'card_widget/card_widget.dart';
export 'layout_widget/layout_widget.dart';
export 'top_level_layout/command_buttons.dart';

enum DestinationPaths({
  required final Widget Function() implementor,
  required final Widget icon,
  required final Widget selectedIcon,
  required final Widget label,
}) with Logging {
  cardsStageLayout(
    implementor: CardsStageLayout.new,
    icon: Icon(Icons.home_outlined),
    selectedIcon: Icon(Icons.home),
    label: Text("Cards"),
  ),

  journalEditor(
    implementor: JournalEditor.new,
    icon: Icon(Icons.book_outlined),
    selectedIcon: Icon(Icons.book),
    label: Text("Journal Editor"),
  ),

  layoutEditor(
    implementor: LayoutEditor.new,
    icon: Icon(Icons.design_services_outlined),
    selectedIcon: Icon(Icons.design_services),
    label: Text("Layout Editor"),
  ),

  settingsEditor(
    implementor: SettingsEditor.new,
    icon: Icon(Icons.settings_outlined),
    selectedIcon: Icon(Icons.settings),
    label: Text("Settings"),
  );

  Widget _iconButton(BuildContext context, Widget icon) {
    verbose("DestinationPaths.$name: _iconButton; ${toString()}");
    return IconButton(
      onPressed: () {
        verbose("journal button pushed");

        sl<SignalsManager>().scaffoldChildWidget.value = this;

        // context.go(path);
      },
      icon: Badge(child: icon),
    );
  }

  NavigationRailDestination destinationBuilder(BuildContext context) {
    verbose("DestinationPaths.$name: destinationBuilder; ${toString()}");
    return NavigationRailDestination(
      icon: _iconButton(context, icon),
      selectedIcon: _iconButton(context, selectedIcon),
      label: label,
    );
  }
}
