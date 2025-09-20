import 'package:choice/choice.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:tarot_again/util/util.dart';

@immutable
class CommandButton extends StatelessWidget {
  final String buttonLabel;

  // final BlocWidgetEvent event;
  final TextStyle? textStyle;
  final VoidCallback callback;

  const CommandButton({
    super.key,
    required this.buttonLabel,
    // required this.event,
    this.textStyle,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => callback(),
      child: Text(buttonLabel, style: textStyle),
    );
  }
}

@immutable
class CommandButtonGroup extends StatelessWidget {
  final String groupLabel;
  final Iterable<(String, TextStyle?, VoidCallback)> buttons;

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
            for (var (label, style, callback) in buttons)
              CommandButton(
                buttonLabel: label,
                callback: callback,
                textStyle: style,
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
    final LayoutManager lm = sl<LayoutManager>();
    final SessionManager sm = sl<SessionManager>();

    return Column(
      children: <Widget>[
        CommandButtonGroup(
          groupLabel: "Bulk Command",
          buttons: [
            ("Allow reversals", null, sm.allowReversals),
            ("Disallow reversals", null, sm.disallowReversals),
            ("FaceUp on", null, sm.turnAllCardsFaceUp),
            ("FaceUp off", null, sm.turnAllCardsFaceDown),
          ],
        ),
        ElevatedButton(
          onPressed: () async => await sm.dealCards(),

          child: Text("Deal cards"),
        ),
        ElevatedButton(
          onPressed: () => sm.freshSpread(),
          child: Text("Lay out fresh cards"),
        ),

        Gap(30),
        Watch((context) {
          final tL = SignalsManager.tarotLayout.value;
          verbose("  tarotLayout.value is $tL");

          final lDN = ComputedsManager.layoutDisplayNames.value;
          verbose("  layoutDisplayNames.value is $lDN");

          return PromptedChoice<String>.single(
            title: "Select a layout",
            clearable: true,
            value: tL.displayName,
            // this changes after setNewLayout is called
            onChanged: (String? value) {
              if (value != null) {
                verbose("  onChanged: value is $value");
                lm.setLayoutByDisplayName(value);
              }
            },
            itemCount: lDN.length,
            itemBuilder: (state, i) {
              return ChoiceChip(
                selected: state.selected(lDN[i]),
                onSelected: state.onSelected(lDN[i]),
                label: Text(lDN[i]),
              );
            },
            listBuilder: ChoiceList.createWrapped(
              spacing: 10,
              runSpacing: 10,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            ),
          );
        }, debugLabel: "Layout choice"),
        Gap(5),
        PromptedChoice<String>.single(
          title: "Select a source of randomness",
          clearable: true,
          value: SignalsManager.currentRandomGenerator.value.displayName,
          onChanged: (String? value) {
            if (value != null) {
              sl<AsyncRandoms>().setRandomSource(value);
            }
          },
          itemCount: RandomGenerators.values.length,
          itemBuilder: (state, index) => ChoiceChip(
            selected: state.selected(
              sl<AsyncRandoms>().randomGeneratorNames[index],
            ),
            onSelected: state.onSelected(
              sl<AsyncRandoms>().randomGeneratorNames[index],
            ),
            label: Text(sl<AsyncRandoms>().randomGeneratorNames[index]),
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
