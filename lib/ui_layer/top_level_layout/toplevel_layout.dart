// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: implementation_imports
//

import 'package:tarot_again/util/flutter_util.dart';

import '../sidebar_layout/sidebar_layout.dart';
import 'main_navigation_rail.dart';
import 'top_menu_bar.dart';
import '../ui_layer.dart';

import 'cards_stage_layout.dart';

import 'package:tarot_again/util/util.dart';

import 'package:flutter/src/widgets/_window.dart';

import 'package:anyhow/anyhow.dart';

import 'main_scaffold.dart';

@immutable
class TopLevelLayout extends StatelessWidget with Logging {
  const TopLevelLayout({super.key, required this.windowController});

  final WindowController windowController;

  @override
  Widget build(BuildContext context) {
    verbose("Building TopLevelLayout");

    return MainScaffold(
      windowController: windowController,
      child: Column(
        children: [
          guard(() => TopMenuBar())
              .context("TopLevelLayout.build: TopMenuBar")
              .unwrap(),
          Expanded(
            child: Row(
              children: [
                guard(
                  () => MainNavigationRail(windowController: windowController),
                ).context("TopLevelLayout.build: MainNavigationRail").unwrap(),
                const VerticalDivider(thickness: 1, width: 1),
                Expanded(
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        child: guard(() => CommandButtons())
                            .context("TopLevelLayout.build: CommandButtons")
                            .unwrap(),
                      ),
                      Expanded(
                        flex: 3,
                        child: guard(() => CardsStageLayout())
                            .context("TopLevelLayout.build: CarsStageLayout")
                            .unwrap(),
                      ),
                      Expanded(
                        flex: 1,
                        child: guard(() => SidebarLayout())
                            .context("TopLevelLayout.build: SidebarLayout")
                            .unwrap(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
