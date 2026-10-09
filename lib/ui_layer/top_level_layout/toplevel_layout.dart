// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: implementation_imports
//

// import 'dart:ui';

// import 'package:toastification/toastification.dart';

import 'package:flutter/src/widgets/_window.dart';
import 'package:tarot_again/util/flutter_util.dart';

import '../sidebar_layout/sidebar_layout.dart';
import 'main_navigation_rail.dart';
import 'top_menu_bar.dart';
import '../ui_layer.dart';
// import '../preview_wrapper_widget.dart';
import 'cards_stage_layout.dart';

// import 'main_scaffold.dart';

@immutable
class TopLevelLayout extends StatelessWidget {
  const TopLevelLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cloud Tarot"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          TopMenuBar(),
          Expanded(
            child: Row(
              children: [
                MainNavigationRail(),
                const VerticalDivider(thickness: 1, width: 1),
                Expanded(
                  child: Row(
                    children: <Widget>[
                      Flexible(child: CommandButtons()),
                      Expanded(flex: 3, child: CardsStageLayout()),
                      Expanded(flex: 1, child: SidebarLayout()),
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
