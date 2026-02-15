import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:tarot_again/ui_layer/settings_ui/settings_ui.dart';
import 'package:tarot_again/util/flutter_util.dart';
// import 'package:tarot_again/ui_layer/ui_layer.dart';
import 'package:tarot_again/util/util.dart';

class MainNavigationRail extends StatefulWidget {
  const MainNavigationRail({super.key});

  @override
  State<MainNavigationRail> createState() => _MainNavigationRailState();
}

class _MainNavigationRailState extends State<MainNavigationRail> with Logging {
  int _selectedIndex = 0;
  NavigationRailLabelType labelType = NavigationRailLabelType.all;
  bool showLeading = false;
  bool showTrailing = false;
  double groupAlignment = -1.0;

  Future<void> _appSettingsDialog(BuildContext context) async =>
      await showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          debug("_appSettingsDialog; returning AlertDialog");
          return AlertDialog(content: SettingsUi_Widget());
        },
      );

  Widget _buildTarotLayoutChoiceChip(
    BuildContext context, {
    required Signal<TarotLayout> signal,
    required String key,
  }) => Watch(
    (BuildContext context) => ChoiceChip(
      label: Text(key),
      selected: signal.value.displayName == key,
      onSelected: (bool selected) {
        if (selected) {
          signal.value = sl<LayoutManager>().getLayoutByDisplayName(key);
        }
      },
    ),
  );

  Future<void> _tarotLayoutsDialogBuilder(BuildContext context) => showDialog(
    context: context,
    builder: (BuildContext context) => Watch(
      (BuildContext context) => AlertDialog(
        title: Text(
          "Select a Tarot Layout",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        actions: ComputedsManager.layoutDisplayNames.value
            .map(
              (e) =>
                  _buildTarotLayoutChoiceChip(
                    context,
                    signal: SignalsManager.tarotLayout,
                    key: e,
                  ).also((chip) {
                    verbose("  chip widget created, key is $e");
                  }),
            )
            .toList(),
      ),
    ),
  );

  Future<void> _randomSourceDialogBuilder(BuildContext context) => showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text(
        "Select the source of randomness",
        style: Theme.of(context).textTheme.headlineSmall,
      ),
      actions: List<Widget>.generate(RandomGenerators.values.length, (
        int index,
      ) {
        return Watch(
          (BuildContext context) => ChoiceChip(
            label: Text(RandomGenerators.values[index].displayName),
            selected:
                SignalsManager.currentRandomGenerator.value.index == index,
            onSelected: (bool selected) {
              SignalsManager.currentRandomGenerator.value =
                  RandomGenerators.values[index];
            },
          ),
        );
      }).toList(),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      selectedIndex: _selectedIndex,
      groupAlignment: groupAlignment,
      onDestinationSelected: (int index) {
        setState(() {
          _selectedIndex = index;
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
          icon: IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              debug("Navigation rail destination 0 (settings) onPressed.");
              _appSettingsDialog(context);
            },
          ),
          selectedIcon: Icon(Icons.favorite),
          label: Text('Settings'),
        ),
        NavigationRailDestination(
          icon: Badge(child: Icon(Icons.bookmark_border)),
          selectedIcon: Badge(child: Icon(Icons.book)),
          label: Text('Second'),
        ),
        NavigationRailDestination(
          icon: IconButton(
            onPressed: () {
              _tarotLayoutsDialogBuilder(context);
            },
            icon: Badge(
              label: Watch(
                (BuildContext context) =>
                    Text(SignalsManager.tarotLayout.value.displayName),
              ),
              child: Icon(LucideIcons.layout_dashboard),
            ),
            selectedIcon: Badge(
              label: Watch(
                (BuildContext context) =>
                    Text(SignalsManager.tarotLayout.value.displayName),
              ),
              child: Icon(LucideIcons.layout_dashboard),
            ),
          ),
          label: Text('Layouts'),
        ),
        NavigationRailDestination(
          icon: IconButton(
            onPressed: () {
              _randomSourceDialogBuilder(context);
            },
            icon: Badge(
              label: Watch(
                (BuildContext context) => Text(
                  SignalsManager.currentRandomGenerator.value.displayName,
                ),
              ),
              child: Icon(LucideIcons.dices),
            ),
          ),
          selectedIcon: IconButton(
            onPressed: () {
              _randomSourceDialogBuilder(context);
            },
            icon: Badge(
              label: Watch(
                (BuildContext context) => Text(
                  SignalsManager.currentRandomGenerator.value.displayName,
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
