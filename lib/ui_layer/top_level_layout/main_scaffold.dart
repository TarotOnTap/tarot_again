import "package:material_ui/material_ui.dart";
import 'package:tarot_again/util/logging.dart';

import 'main_navigation_rail.dart';
import 'top_menu_bar.dart';

import 'package:tarot_again/util/util.dart';

@immutable
class MainScaffold extends StatelessWidget with Logging {
  final String title;

  const MainScaffold({super.key, this.title = "Cloud Tarot"});

  @override
  Widget build(BuildContext context) {
    verbose(
      "MainScaffold.build: scaffoldChildWidget is ${sl<SignalsManager>().scaffoldChildWidget.value}",
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SafeArea(
        child: Column(
          children: [
            TopMenuBar(),
            Expanded(
              child: Row(
                children: [
                  MainNavigationRail(),
                  const VerticalDivider(thickness: 1, width: 1),
                  Expanded(
                    child: SignalBuilder(
                      builder: (BuildContext context) => sl<SignalsManager>()
                          .scaffoldChildWidget
                          .value
                          .implementor(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
