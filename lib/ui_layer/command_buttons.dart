import 'package:choice/choice.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:tarot_again/blocs/blocs.dart';
import 'package:tarot_again/data_layer/data_layer.dart';
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
    return Column(
      children: <Widget>[
        Text(groupLabel),
        Gap(10),
        Column(
          children: buttonInfos.fold(
            [],
            (prev, item) =>
                prev +
                [
                  ElevatedButton(
                    onPressed: () => handlerBloc.add(item.$2),
                    child: Text(
                      item.$1,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
          ),
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

    final LayoutState layoutBlocState = watchBloc((LayoutBloc b) => b).data!;
    verbose("build: layoutBlocState is $layoutBlocState");

    Widget returnWidget;

    // String? selectedLayout = layoutBlocState.currentLayoutName;
    RandomGenerators? selectedRandomGenerator;

    final randomGeneratorNames =
        RandomGenerators.values
            .map((item) => item.name.toNoCase().toCapitalCase())
            .toList();

    // final data = layoutBloc.state;

    final displayNames = [...layoutBlocState.layoutNames];

    switch (layoutBlocState) {
      case LayoutInitial(layoutNames: var ln):
        verbose("  case Initial");
        verbose("  layoutNames is $ln");

      // case ChangeLayoutState(
      //   currentLayoutName: var sl,
      //   currentLayout: var tl,
      //   layoutNames: var ln,
      // ):
      //   verbose("  case ChangeLayoutState");
      //   verbose("  layoutNames is $ln");

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
            ("Deal cards for layout", BulkCardDealCards(5)),
            // ("Deal 10 cards", BulkCardDealCards(10)),
          ],
        ),
        Gap(30),
        PromptedChoice<String>.single(
          title: "Select a layout",
          clearable: true,
          value: layoutBlocState.currentLayoutName,
          // this changes after setNewLayout is called
          onChanged: (String? value) {
            if (value != null) {
              verbose("  onChanged: value is $value");
              sl<LayoutBloc>().add(LayoutEvent.setNewLayout(newLayout: value));
              // selectedLayout = value;
            }
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
        Gap(5),
        PromptedChoice<RandomGenerators>.single(
          title: "Select a source of randomness",
          clearable: true,
          value: selectedRandomGenerator,
          onChanged: (RandomGenerators? value) {
            if (value != null) {
              sl<AsyncRandoms>().setRandomSource(value);
              selectedRandomGenerator = value;
            }
          },
          itemCount: RandomGenerators.values.length,
          itemBuilder:
              (state, index) => ChoiceChip(
                selected: state.selected(RandomGenerators.values[index]),
                onSelected: state.onSelected(RandomGenerators.values[index]),
                label: Text(randomGeneratorNames[index]),
              ),
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
