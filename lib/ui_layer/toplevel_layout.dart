import 'package:flutter/material.dart';

import 'cards_stage_layout.dart';
import 'command_buttons.dart';

class TopLevelLayout extends StatelessWidget {
  const TopLevelLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(flex: 1, child: CommandButtons()),
        Expanded(flex: 3, child: CardsStageLayout()),
      ],
    );
  }
}
