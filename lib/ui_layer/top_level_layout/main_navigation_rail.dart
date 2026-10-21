import 'package:flutter_lucide/flutter_lucide.dart';

import 'package:tarot_again/util/flutter_util.dart';
import 'package:tarot_again/util/util.dart';

import 'package:tarot_again/ui_layer/ui_layer.dart';

/// Create a navigation interface along the left side of the top-level layout.
class MainNavigationRail extends StatefulWidget {
  const MainNavigationRail({super.key});

  @override
  State<MainNavigationRail> createState() => _MainNavigationRailState();
}

class _MainNavigationRailState extends State<MainNavigationRail> with Logging {
  int _selectedIndex = 1;
  NavigationRailLabelType labelType = NavigationRailLabelType.all;
  bool showLeading = false;
  bool showTrailing = false;
  double groupAlignment = -1.0;

  List<Widget> _layoutOptions(BuildContext context) => sl<ComputedsManager>()
      .layoutDisplayNames
      .value
      .map(
        (e) => SimpleDialogOption(
          onPressed: () => Navigator.pop(context, e),
          child: Text(e),
        ),
      )
      .toList();

  Future<TarotLayout?> _tarotSelectionDialog(BuildContext context) async {
    final result = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Select a layout option:'),
          children: _layoutOptions(context),
        );
      },
    );

    if (result != null) {
      return sl<LayoutManager>().getLayoutByDisplayName(result);
    }

    return null;
  }

  List<Widget> _randomSourceOptions(BuildContext context) {
    return List<Widget>.generate(
      RandomGenerators.values.length,
      (int index) => SimpleDialogOption(
        onPressed: () => Navigator.pop(context, RandomGenerators.values[index]),
        child: Text(RandomGenerators.values[index].displayName),
      ),
    );
  }

  Future<RandomGenerators?> _randomSourceDialogBuilder(
    BuildContext context,
  ) async {
    final result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Select a layout option:'),
          children: _randomSourceOptions(context),
        );
      },
    );

    return result;
  }

  // Widget _navigatorIconButton(
  //   BuildContext context,
  //   Icon icon,
  //   DestinationPaths destination,
  // ) {
  //   return IconButton(
  //     onPressed: () {
  //       verbose("journal button pushed");

  //       context.go(destination.path);
  //     },
  //     icon: Badge(child: icon),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    verbose("Building MainNavigationRail");

    return NavigationRail(
      selectedIndex: _selectedIndex,
      groupAlignment: groupAlignment,
      onDestinationSelected: (int index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      labelType: labelType,
      destinations: <NavigationRailDestination>[
        for (final destination in DestinationPaths.values)
          destination.destinationBuilder(context),

        NavigationRailDestination(
          icon: SizedBox(width: 0, height: 0),
          selectedIcon: SizedBox(width: 0, height: 0),
          label: Divider(height: 5, thickness: 2, color: Colors.black),
        ),

        NavigationRailDestination(
          icon: IconButton(
            onPressed: () async {
              verbose("tarot layouts button pushed");
              final result = await _tarotSelectionDialog(context);

              verbose("  result was $result");

              if (result != null) {
                sl<SignalsManager>().tarotLayout.value = result;
              }
            },
            icon: Badge(
              label: SignalBuilder(
                builder: (BuildContext context) =>
                    Text(sl<SignalsManager>().tarotLayout.value.displayName),
              ),
              child: Icon(Icons.dashboard_customize_outlined),
            ),
            selectedIcon: Badge(
              label: SignalBuilder(
                builder: (BuildContext context) =>
                    Text(sl<SignalsManager>().tarotLayout.value.displayName),
              ),
              child: Icon(Icons.dashboard_customize),
            ),
          ),
          label: Text('Layouts'),
        ),
        NavigationRailDestination(
          icon: IconButton(
            onPressed: () async {
              final result = await _randomSourceDialogBuilder(context);

              if (result != null) {
                sl<SignalsManager>().currentRandomGenerator.value = result;
              }
            },
            icon: Badge(
              label: SignalBuilder(
                builder: (BuildContext context) => Text(
                  sl<SignalsManager>().currentRandomGenerator.value.displayName,
                ),
              ),
              child: Icon(LucideIcons.dices),
            ),
          ),
          selectedIcon: IconButton(
            onPressed: () async {
              final result = await _randomSourceDialogBuilder(context);

              if (result != null) {
                sl<SignalsManager>().currentRandomGenerator.value = result;
              }
            },
            icon: Badge(
              label: SignalBuilder(
                builder: (BuildContext context) => Text(
                  sl<SignalsManager>().currentRandomGenerator.value.displayName,
                ),
              ),
              child: Icon(LucideIcons.dices),
            ),
          ),
          label: Text("Randomness"),
        ),
      ],
    );
  }
}
