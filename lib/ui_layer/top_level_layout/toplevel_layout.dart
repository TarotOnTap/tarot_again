// // ignore_for_file: invalid_use_of_internal_member
// // ignore_for_file: implementation_imports
// //

// import 'package:tarot_again/util/flutter_util.dart';
// import 'package:tarot_again/reactives/signals_manager.dart';

// import '../sidebar_layout/sidebar_layout.dart';
// import 'main_navigation_rail.dart';
// import 'top_menu_bar.dart';
// import '../ui_layer.dart';

// import 'cards_stage_layout.dart';

// import 'package:tarot_again/util/util.dart';

// // import 'package:flutter/src/widgets/_window.dart';

// // import 'package:anyhow/anyhow.dart';

// import 'main_scaffold.dart';

// @immutable
// class TopLevelLayout extends StatelessWidget with Logging {
//   const TopLevelLayout({super.key});

//   @override
//   Widget build(BuildContext context) {
//     verbose("Building TopLevelLayout");

//     return MainScaffold(
//       // child: Column(
//       //   children: [
//       //     TopMenuBar(),
//       //     Expanded(
//       //       child: Row(
//       //         children: [
//       //           MainNavigationRail(),
//       //           const VerticalDivider(thickness: 1, width: 1),
//       //           SignalBuilder(builder: (context) { Navigator.popAndPushNamed(context, sl<SignalsManager>().topLevelDisplay.value.name, )}),
//       //           Expanded(
//       //             child: Row(
//       //               children: <Widget>[
//       //                 Flexible(child: CommandButtons()),
//       //                 Expanded(flex: 3, child: CardsStageLayout()),
//       //                 Expanded(flex: 1, child: SidebarLayout()),
//       //               ],
//       //             ),
//       //           ),
//       //         ],
//       //       ),
//       //     ),
//       //   ],
//       // ),
//     );
//   }
// }
