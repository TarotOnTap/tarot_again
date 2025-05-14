// import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:signals/signals.dart';
import 'package:tarot_again/data_layer/data_layer.dart'; // show AssetPathMap, BaseProvider;
import 'package:tarot_again/util/event_bus.dart';
import 'package:tarot_again/util/util.dart';

class AssetProvider extends BaseProvider with Logging {
  // final _allAssets = AsyncMemoizer<IList<String>>();

  // Iterable<String> deckAssets = [];

  final allAssets = signal<Iterable<String>>([]);

  final deckType = signal<String>("standardTarot");
  final deckName = signal<String>("rws");

  late final Computed<String> deckString;
  late final Computed<Iterable<String>> deckAssets;

  late final Computed<Iterable<String>> tarotLayouts;

  AssetProvider._() {
    deckString = computed(() => "decks/${deckType.value}/${deckName.value}");
    deckAssets = computed(
      () => allAssets.value.where(
        (String assetName) => assetName.contains(deckString.value),
      ),
    );
    tarotLayouts = computed(
      () => allAssets.value.where(
        (String assetName) => assetName.contains("layouts/tarot_layouts"),
      ),
    );

    unawaited(
      _getAllAssets(),
    ); // this will load the manifest and set the value of
    // the allAssets signal when it's finished. No async necessary in that!

    receiveEvents<SetDeckTypeEvent>(
      onData: (SetDeckTypeEvent t) {
        deckType.value = t.deckType;
      },
    );

    receiveEvents<SetDeckNameEvent>(
      onData: (SetDeckNameEvent t) => deckName.value = t.deckName,
    );
  }

  factory AssetProvider() {
    if (!sl.isRegistered<AssetProvider>()) {
      return sl.registerSingleton<AssetProvider>(AssetProvider._());
    }

    return sl<AssetProvider>();
  }

  Future<void> _getAllAssets() async {
    final AssetManifest assetManifest = await AssetManifest.loadFromAssetBundle(
      rootBundle,
    );

    allAssets.value = assetManifest.listAssets();
  }

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
    verbose("AssetProvider.loadAssetsForCard");
    TCModelAssets? retVal;

    // first, find all of the assets associated with the given card in the deck in the deckType
    Iterable<String> cardAssets = deckAssets.value.where(
      (String assetName) => assetName.contains(card.name),
    );

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
}
