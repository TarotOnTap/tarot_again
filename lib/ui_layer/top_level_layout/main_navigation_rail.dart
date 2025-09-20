import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:tarot_again/ui_layer/ui_layer.dart';
import 'package:tarot_again/util/util.dart';

class MainNavigationRail extends StatefulWidget {
  const MainNavigationRail({super.key});

  @override
  State<MainNavigationRail> createState() => _MainNavigationRailState();
}

class _MainNavigationRailState extends State<MainNavigationRail> {
  int _selectedIndex = 0;
  NavigationRailLabelType labelType = NavigationRailLabelType.all;
  bool showLeading = false;
  bool showTrailing = false;
  double groupAlignment = -1.0;

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      selectedIndex: _selectedIndex,
      groupAlignment: groupAlignment,
      onDestinationSelected: (int index) {
        setState(() {
          _selectedIndex = index;

          switch (_selectedIndex) {
            case 3:
              Navigator.of(context).push(RandomSourcePopupMain());
            case _:
              ;
          }
        });
      },
      labelType: labelType,
      leading: showLeading
          ? FloatingActionButton(
              elevation: 0,
              onPressed: () {
                // Add your onPressed code here!
              },
              child: const Icon(Icons.add),
            )
          : const SizedBox(),
      trailing: showTrailing
          ? IconButton(
              onPressed: () {
                // Add your onPressed code here!
              },
              icon: const Icon(Icons.more_horiz_rounded),
            )
          : const SizedBox(),
      destinations: <NavigationRailDestination>[
        NavigationRailDestination(
          icon: Icon(Icons.favorite_border),
          selectedIcon: Icon(Icons.favorite),
          label: Text('First'),
        ),
        NavigationRailDestination(
          icon: Badge(child: Icon(Icons.bookmark_border)),
          selectedIcon: Badge(child: Icon(Icons.book)),
          label: Text('Second'),
        ),
        NavigationRailDestination(
          icon: Badge(label: Text('4'), child: Icon(Icons.star_border)),
          selectedIcon: Badge(label: Text('4'), child: Icon(Icons.star)),
          label: Text('Third'),
        ),
        NavigationRailDestination(
          icon: Badge(
            label: Watch(
              (BuildContext context) =>
                  Text(SignalsManager.currentRandomGenerator.value.displayName),
            ),
            child: Icon(LucideIcons.dices),
          ),
          selectedIcon: Badge(
            label: Watch(
              (BuildContext context) =>
                  Text(SignalsManager.currentRandomGenerator.value.displayName),
            ),
            child: Icon(LucideIcons.dices, color: Colors.green),
          ),
          label: Text("Randomness"),
        ),
      ],
      //         ),
      //         const VerticalDivider(thickness: 1, width: 1),
      //         // This is the main content.
      //         Expanded(
      //           child: Column(
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             children: <Widget>[
      //               Text('selectedIndex: $_selectedIndex'),
      //               const SizedBox(height: 20),
      //               Text('Label type: ${labelType.name}'),
      //               const SizedBox(height: 10),
      //               SegmentedButton<NavigationRailLabelType>(
      //                 segments: const <ButtonSegment<NavigationRailLabelType>>[
      //                   ButtonSegment<NavigationRailLabelType>(
      //                     value: NavigationRailLabelType.none,
      //                     label: Text('None'),
      //                   ),
      //                   ButtonSegment<NavigationRailLabelType>(
      //                     value: NavigationRailLabelType.selected,
      //                     label: Text('Selected'),
      //                   ),
      //                   ButtonSegment<NavigationRailLabelType>(
      //                     value: NavigationRailLabelType.all,
      //                     label: Text('All'),
      //                   ),
      //                 ],
      //                 selected: <NavigationRailLabelType>{labelType},
      //                 onSelectionChanged:
      //                     (Set<NavigationRailLabelType> newSelection) {
      //                       setState(() {
      //                         labelType = newSelection.first;
      //                       });
      //                     },
      //               ),
      //               const SizedBox(height: 20),
      //               Text('Group alignment: $groupAlignment'),
      //               const SizedBox(height: 10),
      //               SegmentedButton<double>(
      //                 segments: const <ButtonSegment<double>>[
      //                   ButtonSegment<double>(value: -1.0, label: Text('Top')),
      //                   ButtonSegment<double>(value: 0.0, label: Text('Center')),
      //                   ButtonSegment<double>(value: 1.0, label: Text('Bottom')),
      //                 ],
      //                 selected: <double>{groupAlignment},
      //                 onSelectionChanged: (Set<double> newSelection) {
      //                   setState(() {
      //                     groupAlignment = newSelection.first;
      //                   });
      //                 },
      //               ),
      //               const SizedBox(height: 20),
      //               SwitchListTile(
      //                 title: Text(showLeading ? 'Hide Leading' : 'Show Leading'),
      //                 value: showLeading,
      //                 onChanged: (bool value) {
      //                   setState(() {
      //                     showLeading = value;
      //                   });
      //                 },
      //               ),
      //               SwitchListTile(
      //                 title: Text(
      //                   showTrailing ? 'Hide Trailing' : 'Show Trailing',
      //                 ),
      //                 value: showTrailing,
      //                 onChanged: (bool value) {
      //                   setState(() {
      //                     showTrailing = value;
      //                   });
      //                 },
      //               ),
      //             ],
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
    );
  }
}
