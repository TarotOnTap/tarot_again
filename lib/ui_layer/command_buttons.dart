import 'package:flutter/material.dart';
import 'package:tarot_again/blocs/blocs.dart';
import 'package:tarot_again/util/util.dart';

@immutable
class CommandButtonGroup extends StatelessWidget {
  final String groupLabel;
  final List<(String, BlocWidgetEvent)> buttonInfos;
  final Bloc _bloc;

  CommandButtonGroup({
    super.key,
    Bloc? bloc,
    required this.groupLabel,
    required this.buttonInfos,
  }) : _bloc = bloc ?? sl<BulkCardControlBloc>();

  @override
  Widget build(BuildContext context) {
    String label;
    BlocWidgetEvent bwe;

    return Column(
      children: <Widget>[
        Text(groupLabel),
        Column(
          children: <Widget>[
            for (var item in buttonInfos)
              ElevatedButton(
                onPressed: () => _bloc.add(item.$2),
                child: Text(item.$1),
              ),
          ],
        ),
      ],
    );
  }
}

class CommandButtons extends StatelessWidget {
  const CommandButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CommandButtonGroup(
          groupLabel: "Bulk Command",
          buttonInfos: [
            ("Allow reversals", AllowReversals()),
            ("Disallow reversals", DisallowReversals()),
            ("FaceUp on", TurnEverybodyFaceUpOn()),
            ("FaceUp off", TurnEverybodyFaceUpOff()),
          ],
        ),
        Text(" "),
        CommandButtonGroup(
          groupLabel: "Card Buttons",
          buttonInfos: [
            ("Card Widget face up", CardWidgetFaceUpEvent()),
            ("Card Widget face down", CardWidgetFaceDownEvent()),
            ("Card Widget flip face", CardWidgetFlipFaceEvent()),
            (
              "Card Widget set reverse",
              CardWidgetSetReverseEvent(reverse: true),
            ),
            (
              "Card Widget unset reverse",
              CardWidgetSetReverseEvent(reverse: false),
            ),
            ("Card Widget flip reverse", CardWidgetFlipReverseEvent()),
          ],
        ),
      ],
    );
  }
}
