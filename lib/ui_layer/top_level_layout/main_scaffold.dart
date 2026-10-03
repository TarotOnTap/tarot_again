import "package:material_ui/material_ui.dart";
import 'package:tarot_again/util/logging.dart';

import 'main_navigation_rail.dart';
import 'top_menu_bar.dart';

@immutable
class MainScaffold extends StatelessWidget with Logging {
  final Widget child;

  const MainScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cloud Tarot"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          verbose("MainScaffold.build: constraints are $constraints");

          return Column(
            children: [
              TopMenuBar(),
              Expanded(
                child: Row(
                  children: [
                    MainNavigationRail(),
                    const VerticalDivider(thickness: 1, width: 1),
                    Expanded(child: child),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
