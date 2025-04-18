import 'package:choice/choice.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:tarot_again/blocs/blocs.dart';
import 'package:tarot_again/data_layer/data_layer.dart';
import 'package:tarot_again/util/util.dart';

@immutable
class CommandButton extends StatelessWidget {
  final String buttonLabel;
  final Bloc handlerBloc;
  final BlocWidgetEvent event;
  final TextStyle? style;

  const CommandButton({
    super.key,
    required this.buttonLabel,
    required this.handlerBloc,
    required this.event,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => handlerBloc.add(event),
      child: Text(buttonLabel, style: style),
    );
  }
}

@immutable
class CommandButtonGroup extends StatelessWidget with Logging {
  final String groupLabel;
  final Iterable<(String, Bloc, BlocWidgetEvent, TextStyle?)> buttons;

  const CommandButtonGroup({
    super.key,
    required this.groupLabel,
    required this.buttons,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(groupLabel),
        Gap(10),
        Column(
          children:
              buttons
                  .fold(
                    const IList<CommandButton>.empty(),
                    (prev, elem) => prev.add(
                      CommandButton(
                        buttonLabel: elem.$1,
                        handlerBloc: elem.$2,
                        event: elem.$3,
                        style: elem.$4,
                      ),
                    ),
                  )
                  .toList(),
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

    final LayoutState layoutBlocState =
        watchBloc((LayoutBloc b) => b).data! as LayoutState;
    final BulkCardControlBloc bcBloc = sl<BulkCardControlBloc>();
    final layoutBloc = sl<LayoutBloc>();

    verbose("build: layoutBlocState is $layoutBlocState");

    RandomGenerators? selectedRandomGenerator;

    final randomGeneratorNames =
        RandomGenerators.values
            .map((item) => item.name.toNoCase().toCapitalCase())
            .toList();

    // final data = layoutBloc.state;

    final displayNames = [...layoutBlocState.layoutNames];
    //
    // switch (layoutBlocState) {
    //   case LayoutInitial(layoutNames: var ln):
    //     verbose("  case Initial");
    //     verbose("  layoutNames is $ln");
    //
    //   // case ChangeLayoutState(
    //   //   currentLayoutName: var sl,
    //   //   currentLayout: var tl,
    //   //   layoutNames: var ln,
    //   // ):
    //   //   verbose("  case ChangeLayoutState");
    //   //   verbose("  layoutNames is $ln");
    //
    //   case LayoutStateReadyToDeal(layoutNames: var ln):
    //     verbose("  case LayoutStateReadyToDeal");
    //     verbose("  layoutNames is $ln");
    //
    //   case LayoutStateDealt(layoutNames: var ln):
    //     verbose("  case LayoutStateDealt");
    //     verbose("  layoutNames is $ln");
    // }

    return Column(
      children: <Widget>[
        CommandButtonGroup(
          groupLabel: "Bulk Command",
          // handlerBloc: sl<BulkCardControlBloc>(),
          buttons: [
            ("Allow reversals", bcBloc, AllowReversals(), null),
            ("Disallow reversals", bcBloc, DisallowReversals(), null),
            ("FaceUp on", bcBloc, TurnEverybodyFaceUpOn(), null),
            ("FaceUp off", bcBloc, TurnEverybodyFaceUpOff(), null),
            ("Deal cards for layout", layoutBloc, DealCards(), null),
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
          itemCount: layoutBlocState.layoutNames.length,
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
