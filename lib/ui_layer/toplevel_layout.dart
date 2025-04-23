import 'package:flutter/material.dart';
import 'package:tarot_again/blocs/blocs.dart';
import 'package:tarot_again/data_layer/data_layer.dart';

import 'cards_stage_layout.dart';
import 'ui_layer.dart';

class TopLevelLayout extends StatelessWidget {
  const TopLevelLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<BulkCardControlBloc>(
          create: (BuildContext context) => BulkCardControlBloc(),
        ),
        BlocProvider<LayoutBloc>(
          create: (BuildContext context) => LayoutBloc(),
        ),
      ],
      child: MultiRepositoryProvider(
        providers: [
          RepositoryProvider<AsyncRandoms>(
            create: (BuildContext context) => AsyncRandoms(),
          ),
        ],
        child: Row(
          children: <Widget>[
            Expanded(flex: 1, child: CommandButtons()),
            Expanded(flex: 3, child: CardsStageLayout()),
          ],
        ),
      ),
    );
  }
}
