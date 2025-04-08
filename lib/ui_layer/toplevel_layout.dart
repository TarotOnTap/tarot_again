import 'package:flutter/material.dart';

import 'cards_stage_layout.dart';
import 'command_buttons.dart';

class ToplevelLayout extends StatelessWidget {
  const ToplevelLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[CommandButtons(), CardsStageLayout()]);
  }
}
