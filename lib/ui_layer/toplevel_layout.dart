import 'package:tarot_again/blocs/blocs.dart';
import 'package:tarot_again/data_layer/data_layer.dart';
import 'package:tarot_again/util/util.dart';

import 'cards_stage_layout.dart';
import 'ui_layer.dart';

class GlobalKeyStore {
  GlobalKey<LayoutWidgetState> layoutWidgetKey = GlobalKey<LayoutWidgetState>();

  GlobalKeyStore._();

  factory GlobalKeyStore() {
    if (!sl.isRegistered<GlobalKeyStore>()) {
      sl.registerSingleton<GlobalKeyStore>(GlobalKeyStore._());
    }

    return sl<GlobalKeyStore>();
  }
}

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
          RepositoryProvider<DeckRepository>(
            create: (BuildContext context) => DeckRepository(),
          ),
          RepositoryProvider<GlobalKeyStore>(
            create: (BuildContext context) => GlobalKeyStore(),
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
