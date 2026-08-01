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
      onPressed: callback,
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
    // final LayoutManager lm = sl<LayoutManager>();
    verbose('CommandButtons.build');
    verbose('  getting session manager from GetIt using sl');
    final SessionManager sm = sl<SessionManager>();
    verbose('  session manager is $sm');

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
          onPressed: sm.freshSpread,
          child: Text("Lay out fresh cards"),
        ),
      ],
    );
  }
}
