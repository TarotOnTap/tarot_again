// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: implementation_imports
//

// import 'package:flutter/src/widgets/_window.dart';
import "package:material_ui/material_ui.dart";
import 'package:tarot_again/util/logging.dart';

// import 'main_navigation_rail.dart';
// import 'top_menu_bar.dart';

// import '../sidebar_layout/sidebar_layout.dart';

// import '../ui_layer.dart';
// import 'cards_stage_layout.dart';

@immutable
class MainScaffold extends StatelessWidget with Logging {
  final Widget child;

  const MainScaffold({
    super.key,
    required this.child,
    // required this.windowController,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cloud Tarot"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: child,
    );
  }
}
