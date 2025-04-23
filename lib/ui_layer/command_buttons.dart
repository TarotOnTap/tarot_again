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
class CommandButtonGroup extends StatelessWidget {
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
          children: [
            for (var (label, bloc, event, style) in buttons)
              CommandButton(
                buttonLabel: label,
                handlerBloc: bloc,
                event: event,
                style: style,
              ),
          ],
        ),
      ],
    );
  }
}

class CommandButtons extends StatelessWidget with Logging {
  const CommandButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CommandButtonGroup(
          groupLabel: "Bulk Command",
          // handlerBloc: sl<BulkCardControlBloc>(),
          buttons: [
            (
              "Allow reversals",
              context.read<BulkCardControlBloc>(),
              AllowReversals(),
              null,
            ),
            (
              "Disallow reversals",
              context.read<BulkCardControlBloc>(),
              DisallowReversals(),
              null,
            ),
            (
              "FaceUp on",
              context.read<BulkCardControlBloc>(),
              TurnEverybodyFaceUpOn(),
              null,
            ),
            (
              "FaceUp off",
              context.read<BulkCardControlBloc>(),
              TurnEverybodyFaceUpOff(),
              null,
            ),
            (
              "Deal cards for layout",
              context.read<LayoutBloc>(),
              DealCards(),
              null,
            ),
          ],
        ),
        Gap(30),
        BlocBuilder<LayoutBloc, LayoutState>(
          buildWhen:
              (LayoutState prev, LayoutState current) =>
                  prev.layoutNames != current.layoutNames,

          builder:
              (BuildContext context, LayoutState layoutState) =>
                  PromptedChoice<String>.single(
                    title: "Select a layout",
                    clearable: true,
                    value: layoutState.currentLayoutName,
                    // this changes after setNewLayout is called
                    onChanged: (String? value) {
                      if (value != null) {
                        verbose("  onChanged: value is $value");
                        context.read<LayoutBloc>().add(
                          LayoutEvent.setNewLayout(newLayout: value),
                        );
                        // selectedLayout = value;
                      }
                    },
                    itemCount: layoutState.layoutNames.length,
                    itemBuilder: (state, i) {
                      return ChoiceChip(
                        selected: state.selected(layoutState.layoutNames[i]),
                        onSelected: state.onSelected(
                          layoutState.layoutNames[i],
                        ),
                        label: Text(layoutState.layoutNames[i]),
                      );
                    },
                    listBuilder: ChoiceList.createWrapped(
                      spacing: 10,
                      runSpacing: 10,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 25,
                      ),
                    ),
                  ),
        ),
        Gap(5),
        PromptedChoice<String>.single(
          title: "Select a source of randomness",
          clearable: true,
          value: context.read<AsyncRandoms>().currentGenerator.displayName,
          onChanged: (String? value) {
            if (value != null) {
              context.read<AsyncRandoms>().setRandomSource(value);
            }
          },
          itemCount: RandomGenerators.values.length,
          itemBuilder:
              (state, index) => ChoiceChip(
                selected: state.selected(
                  context.read<AsyncRandoms>().randomGeneratorNames[index],
                ),
                onSelected: state.onSelected(
                  context.read<AsyncRandoms>().randomGeneratorNames[index],
                ),
                label: Text(
                  context.read<AsyncRandoms>().randomGeneratorNames[index],
                ),
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
