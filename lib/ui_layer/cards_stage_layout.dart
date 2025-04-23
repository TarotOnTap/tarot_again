import 'package:align_positioned/align_positioned.dart';
import 'package:flutter/material.dart';
import 'package:tarot_again/blocs/blocs.dart';
import 'package:tarot_again/ui_layer/toplevel_layout.dart';
import 'package:tarot_again/util/util.dart';

import 'layout_widget/layout_widget.dart';

@immutable
class CardsStageLayout extends StatelessWidget with Logging {
  const CardsStageLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LayoutBloc, LayoutState>(
      buildWhen:
          (prev, state) => prev.currentLayoutName != state.currentLayoutName,
      builder:
          (context, lsState) => Stack(
            children: <Widget>[
              Center(
                child: LayoutWidget(
                  key: context.read<GlobalKeyStore>().layoutWidgetKey,
                ),
              ),
              AlignPositioned(
                alignment: Alignment.topLeft,
                dx: 5,
                dy: 5,
                touch: Touch.inside,
                child: Text(
                  lsState.currentLayoutName,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
            ],
          ),
    );
  }
}
