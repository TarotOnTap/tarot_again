import 'package:choice/choice.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:tarot_again/blocs/blocs.dart';
import 'package:tarot_again/util/util.dart';

@immutable
class CommandButtonGroup extends StatelessWidget with Logging {
  final String groupLabel;
  final List<(String, BlocWidgetEvent)> buttonInfos;
  final Bloc handlerBloc;

  const CommandButtonGroup({
    super.key,
    required this.groupLabel,
    required this.buttonInfos,
    required this.handlerBloc,
  });

  @override
  Widget build(BuildContext context) {
    verbose("In CommandButtonGroup.build");
    verbose("  groupLabel is $groupLabel");
    verbose("  buttonInfos is $buttonInfos");
    verbose("  handleBloc is $handlerBloc");
    // String label;
    // BlocWidgetEvent bwe;
    //
    // BulkCardControlBloc bccBloc = sl<BulkCardControlBloc>();
    // LayoutRepository layoutRepository = sl<LayoutRepository>();
    // LayoutBloc layoutBloc = sl<LayoutBloc>();

    // List<String> layoutNames = layoutRepository.listLayouts.toList();

    return Column(
      children: <Widget>[
        Text(groupLabel),
        Gap(10),
        Column(
          children: <Widget>[
            for (var item in buttonInfos)
              ElevatedButton(
                onPressed: () => handlerBloc.add(item.$2),
                child: Text(item.$1),
              ),
          ],
        ),
      ],
    );
  }
}

class CommandButtons extends WatchingWidget with Logging {
  const CommandButtons({super.key});

  @override
  Widget build(BuildContext context) {
    verbose("In CommandButtons.build");

    LayoutBloc layoutBloc = sl<LayoutBloc>();

    final lrStream = watchStream(
      (LayoutBloc lr) => lr.stream,
      initialValue: layoutBloc.state,
    );

    Widget returnWidget;

    List<String> selectedLayout = <String>["Empty Layout"];

    final data = layoutBloc.state;

    final displayNames = [...data.layoutNames];

    switch (data) {
      case Initial(layoutNames: var ln):
        verbose("  case Initial");
        verbose("  layoutNames is $ln");

      case ChangeLayoutState(
        currentLayoutName: var sl,
        currentLayout: var tl,
        layoutNames: var ln,
      ):
        verbose("  case ChangeLayoutState");
        verbose("  layoutNames is $ln");

      case LayoutStateReadyToDeal(layoutNames: var ln):
        verbose("  case LayoutStateReadyToDeal");
        verbose("  layoutNames is $ln");

      case LayoutStateDealt(layoutNames: var ln):
        verbose("  case LayoutStateDealt");
        verbose("  layoutNames is $ln");
    }

    return Column(
      children: <Widget>[
        CommandButtonGroup(
          groupLabel: "Bulk Command",
          handlerBloc: sl<BulkCardControlBloc>(),
          buttonInfos: [
            ("Allow reversals", AllowReversals()),
            ("Disallow reversals", DisallowReversals()),
            ("FaceUp on", TurnEverybodyFaceUpOn()),
            ("FaceUp off", TurnEverybodyFaceUpOff()),
            ("Deal 5 cards", BulkCardDealCards(5)),
            ("Deal 10 cards", BulkCardDealCards(10)),
          ],
        ),
        Gap(30),
        Choice<String>.prompt(
          title: "Select a layout",
          clearable: true,
          value: selectedLayout,
          onChanged: (List<String> values) {
            layoutBloc.add(LayoutEvent.setNewLayout(newLayout: values[0]));
            selectedLayout = values;
          },
          itemCount: displayNames.length,
          itemBuilder: (state, i) {
            return ChoiceChip(
              selected: state.selected(displayNames[i]),
              onSelected: state.onSelected(displayNames[i]),
              label: Text(displayNames[i]),
            );
          },
          listBuilder: ChoiceList.createWrapped(
            spacing: 10,
            runSpacing: 10,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
          ),
        ),
      ],
    );
  }
}
