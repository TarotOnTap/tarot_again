import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:tarot_again/blocs/blocs.dart';
import 'package:tarot_again/data_layer/data_layer.dart'; // show AssetPathMap, BaseProvider;
import 'package:tarot_again/util/event_bus.dart';
import 'package:tarot_again/util/util.dart';

class AssetProvider extends BaseProvider with Logging {
  final _allAssets = AsyncMemoizer<IList<String>>();

  Iterable<String> deckAssets = [];

  final ValueNotifier<String> deckType = ValueNotifier<String>("standardTarot");
  final ValueNotifier<String> deckName = ValueNotifier<String>("RWS");

  AssetProvider._() {
    deckType.addListener(_rebuildAssets);
    deckName.addListener(_rebuildAssets);

    receiveEvents<SetDeckTypeEvent>(
      onData: (SetDeckTypeEvent t) {
        deckType.value = t.deckType;
      },
    );
    receiveEvents<SetDeckNameEvent>(
      onData: (SetDeckNameEvent t) => deckName.value = t.deckName,
    );

    _rebuildAssets();
  }

  void _rebuildAssets() async {
    String deckString = "decks/$deckType/$deckName";

    deckAssets = (await allAssets).where(
      (String assetName) => assetName.contains(deckString),
    );
  }

  factory AssetProvider() {
    if (!sl.isRegistered<AssetProvider>()) {
      return sl.registerSingleton<AssetProvider>(AssetProvider._());
    }

    return sl<AssetProvider>();
  }

  Future<IList<String>> get allAssets async => _allAssets.runOnce(() async {
    verbose('mapAssets');
    AssetManifest assetManifest = await AssetManifest.loadFromAssetBundle(
      rootBundle,
    );

    return assetManifest.listAssets().toIList();
  });

  Future<String> loadMarkdownAsset(String assetPath) async {
    String? result;

    try {
      result = await rootBundle.loadString(assetPath);
    } catch (e, s) {
      verbose("AssetProvider.loadMarkdownAsset raised error $e\n\n$s");
    }

    return result ?? "";
  }

  Future<TCModelAssets?> loadAssetsForCard(TarotDeckCards card) async {
    final bccBloc = sl<BulkCardControlBloc>();

    verbose("AssetProvider.loadAssetsForCard");
    verbose(
      "  deckType: ${bccBloc.state.deckType}; deckName: ${bccBloc.state.deckChoice}; card: $card",
    );
    TCModelAssets? retVal;

    String deckString =
        "decks/${bccBloc.state.deckType.name}/${bccBloc.state.deckChoice.name}";

    final lg = bufferedVerbose(
      "  beginning to process asset strings for this card",
    );

    Iterable<String> deckAssets = (await allAssets).where(
      (String assetName) => assetName.contains(deckString),
    );

    // first, find all of the assets associated with the given card in the deck in the deckType
    Iterable<String> cardAssets = (await allAssets)
        .where((String assetName) => assetName.contains(deckString))
        .where((String assetName) => assetName.contains(card.name));

    verbose("  cardAssets is $cardAssets");

    if (cardAssets.isNotEmpty) {
      retVal = TCModelAssets();

      for (var asset in cardAssets) {
        final assetPathParts = asset.split("/");

        final String assetName = assetPathParts.last;
        final String assetKind = assetPathParts[assetPathParts.length - 1];

        final IList<String> info = assetName.split(".").toIList();
        final String fileType = info[1];

        switch (assetKind) {
          case "descriptions":
            String description = await loadMarkdownAsset(asset);
            retVal = retVal?.copyWith(description: description);

          case "reversedMeanings":
            String reversed = await loadMarkdownAsset(asset);
            retVal = retVal?.copyWith(reversedMeaning: reversed);

          case "uprightMeanings":
            String upright = await loadMarkdownAsset(asset);
            retVal = retVal?.copyWith(uprightMeaning: upright);

          case "images":
            if (["jpg", "jpeg", "png", "gif"].contains(fileType)) {
              AssetGenImage image = AssetGenImage(asset);
              retVal = retVal?.copyWith(image: image);
            }
        }
      }
    }

    return retVal;
  }

  Future<IList<String>> findTarotLayouts() async {
    verbose("AssetProvider.findTarotLayouts()");
    verbose("  allAssets is ${await allAssets}");

    final tempAssets = await allAssets;
    final tempLayouts =
        tempAssets
            .where(
              (String assetName) => assetName.contains("layouts/tarot_layouts"),
            )
            .toIList();
    verbose("  tempLayouts is $tempLayouts");

    return tempLayouts;
  }
}
