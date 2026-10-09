// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: implementation_imports
//

import 'package:flutter/src/widgets/_window.dart';

import 'package:flutter_quill/flutter_quill.dart';

import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:tarot_again/util/flutter_util.dart';
import 'package:tarot_again/util/util.dart';

import '../journal_editor/journal_editor.dart';

// NavigationRailDestination journalEditorWindowDestination(BuildContext context) {
//   Logging.sVerbose("journalEditorWindowDestination called");

//   final WindowRegistry windowRegistry = WindowRegistry.of(context);

//   // final BaseWindowController windowController = WindowScope.of(context);

//   return NavigationRailDestination(
//     icon: IconButton(
//       onPressed: () {
//         Logging.sVerbose("journal button pushed");

//         late final WindowEntry entry;
//         // final WindowController controller;

//         final controller = WindowController.shrinkWrap(
//           delegate: CallbackWindowControllerDelegate(
//             onDestroyed: () => windowRegistry.unregister(entry),
//           ),
//           title: 'Regular',
//         );

//         entry = WindowEntry(
//           controller: controller,
//           builder: (BuildContext context) =>
//               JournalEditor(/* windowController: controller */),
//         );
//         windowRegistry.register(entry);
//       },
//       icon: Badge(child: Icon(Icons.book)),
//     ),
//     selectedIcon: Badge(child: Icon(Icons.book)),
//     label: Text('Journal Editor'),
//   );
// }

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

  void _journalEditorWindowBuilder() {
    verbose("_journalEditorWindowBuilder called");

    verbose("  creating WindowController");
    final windowController = WindowController(
      delegate: CallbackWindowControllerDelegate(
        onDestroyed: () {
          verbose("Unregistering journal editor window entry");
        },
      ),
      size: const Size(700, 500),
    );

    verbose("  creating JournalEditor");
    runWidget(
      Window(
        controller: windowController,
        child: MaterialApp(
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            // GlobalCupertinoLocalizations.delegate,
            // GlobalWidgetsLocalizations.delegate,
            FlutterQuillLocalizations.delegate,
          ],
          home: JournalEditor(),
        ),
      ),
    );
  }

  Widget _buildTarotLayoutChoiceChip(
    BuildContext context, {
    required HivezPersistedSignal<TarotLayout> signal,
    required String key,
  }) => SignalBuilder(
    builder: (BuildContext context) => ChoiceChip(
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
    builder: (BuildContext context) => SignalBuilder(
      builder: (BuildContext context) => AlertDialog.adaptive(
        title: Text(
          "Select a Tarot Layout",
          // style: Theme.of(context).textTheme.headlineSmall,
        ),
        content: Wrap(
          spacing: 5.0,
          children: sl<ComputedsManager>().layoutDisplayNames.value
              .map(
                (e) => _buildTarotLayoutChoiceChip(
                  context,
                  signal: sl<SignalsManager>().tarotLayout,
                  key: e,
                ),
              )
              .toList(),
        ),

        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ],
      ),
    ),
  );

  Future<void> _randomSourceDialogBuilder(BuildContext context) => showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog.adaptive(
      title: Text(
        "Select the source of randomness",
        style: Theme.of(context).textTheme.headlineSmall,
      ),
      content: Wrap(
        spacing: 5.0,
        children: List<Widget>.generate(
          RandomGenerators.values.length,
          (int index) => SignalBuilder(
            builder: (BuildContext context) => ChoiceChip(
              label: Text(RandomGenerators.values[index].displayName),
              selected:
                  sl<SignalsManager>().currentRandomGenerator.value.index ==
                  index,
              onSelected: (bool selected) {
                sl<SignalsManager>().currentRandomGenerator.value =
                    RandomGenerators.values[index];
                // Navigator.of(context).pop();
              },
            ),
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, 'OK'),
          child: const Text('OK'),
        ),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    // final WindowRegistry windowRegistry = WindowRegistry.of(context);

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
        NavigationRailDestination(
          icon: IconButton(
            onPressed: () {
              verbose("journal button pushed");

              _journalEditorWindowBuilder();
            },
            icon: Badge(child: Icon(Icons.book)),
          ),
          selectedIcon: Badge(child: Icon(Icons.book)),
          label: Text('Journal Editor'),
        ),
        NavigationRailDestination(
          icon: IconButton(
            onPressed: () {
              verbose("tarot layouts button pushed");
              _tarotLayoutsDialogBuilder(context);
            },
            icon: Badge(
              label: SignalBuilder(
                builder: (BuildContext context) =>
                    Text(sl<SignalsManager>().tarotLayout.value.displayName),
              ),
              child: Icon(LucideIcons.layout_dashboard),
            ),
            selectedIcon: Badge(
              label: SignalBuilder(
                builder: (BuildContext context) =>
                    Text(sl<SignalsManager>().tarotLayout.value.displayName),
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
              label: SignalBuilder(
                builder: (BuildContext context) => Text(
                  sl<SignalsManager>().currentRandomGenerator.value.displayName,
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
