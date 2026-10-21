// import 'package:flutter/widget_previews.dart';
import 'package:material_ui/material_ui.dart';
import 'package:gap/gap.dart';
import 'package:tarot_again/util/util.dart';

// import 'package:flutter_quill/flutter_quill.dart';

@immutable
class CommandButtonGroup extends StatelessWidget {
  final String groupLabel;
  final Iterable<(String, TextStyle?, VoidCallback)> buttons;

  const CommandButtonGroup({
    super.key,
    required this.groupLabel,
    required this.buttons,
  });

  const CommandButtonGroup.preview({
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
              ElevatedButton(
                onPressed: callback,
                child: Text(label, style: style),
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
    final SessionManager sm = sl<SessionManager>();

    return Column(
      children: <Widget>[
        Expanded(
          child: CommandButtonGroup(
            groupLabel: "Bulk Command",
            buttons: [
              ("Allow reversals", null, sm.allowReversals),
              ("Disallow reversals", null, sm.disallowReversals),
              ("FaceUp on", null, sm.turnAllCardsFaceUp),
              ("FaceUp off", null, sm.turnAllCardsFaceDown),
            ],
          ),
        ),
        Gap(10.0),
        ElevatedButton(
          onPressed: () async => sm.dealCards(),

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
