import 'package:tarot_again/blocs/blocs.dart';
import 'package:tarot_again/data_layer/data_layer.dart';
import 'package:tarot_again/util/util.dart';

class AssetRepository {
  late final AssetProvider assetProvider;
  late final BulkCardControlBloc bccBloc;

  String deckChoice = "";
  String deckType = "";

  Iterable<String> deckAssets = [];

  AssetRepository._() {
    assetProvider = sl<AssetProvider>();
    bccBloc = sl<BulkCardControlBloc>();

    deckChoice = bccBloc.state.deckChoice.name;
    deckType = bccBloc.state.deckType.name;

    bccBloc.stream.listen(_bccChangeHandler);
  }

  void _bccChangeHandler(BulkCardControlState newState) {
    if (newState.deckChoice.name != deckChoice ||
        newState.deckType.name != deckType) {
      deckChoice = newState.deckChoice.name;
      deckType = newState.deckType.name;
    }
  }

  factory AssetRepository() {
    if (!sl.isRegistered<AssetRepository>()) {
      sl.registerSingleton<AssetRepository>(AssetRepository._());
    }

    return sl<AssetRepository>();
  }

  Future<void> loadAssetsForCard({
    required int index,
    required TarotDeckCards card,
  }) async {
    final bccBloc = sl<BulkCardControlBloc>();

    final layoutBloc = sl<LayoutBloc>();

    await sl<AssetProvider>().loadAssetsForCard(card);
  }
}
