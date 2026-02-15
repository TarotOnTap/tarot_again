import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:fpdart/fpdart.dart';
import 'package:json_repair_flutter/json_repair_flutter.dart';
import 'package:tarot_again/util/util.dart';

export 'types.dart';

typedef JsonMap = IMap<String, dynamic>;

class AssetManager with Logging implements PostInit {
  AssetManager() {
    log("AssetManager.AssetManager");
  }

  @override
  Future<void> postInit() async {
    final assetPaths = await getAllAssetPaths();
    final layoutsByName = await fetchLayouts();

    // initialize all of our fixed assets, here, in one go
    batch(() {
      SignalsManager.allAssetPaths.value = assetPaths;
      SignalsManager.tarotLayoutsByName.value = layoutsByName;
    });
  }

  static Future<Iterable<String>> getAllAssetPaths() async {
    log("AssetManager.getAllAssetPaths");
    AssetManifest? assetManifest;
    var assetPaths = <String>[];

    try {
      assetManifest = await AssetManifest.loadFromAssetBundle(rootBundle);
      log("  assetManifest is $assetManifest");
      assetPaths = assetManifest.listAssets();
    } catch (e, s) {
      log("  loadFromAssetBundle raised error $e");
      assetPaths = [e.toString(), s.toString()];
    }

    return assetPaths;
  }

  TaskEither<FlutterError, String> _loadTarotLayoutsJson() =>
      TaskEither<FlutterError, String>.tryCatch(() async {
        return await rootBundle.loadString("assets/tarotLayouts.json");
      }, (e, s) => e as FlutterError);

  Either<FormatException, JsonMap> _parseTarotLayoutsJson(String json) =>
      Either<FormatException, JsonMap>.tryCatch(
        () => IMap<String, dynamic>(jsonDecode(json)),
        (e, s) => e as FormatException,
      );

  Future<IMap<String, TarotLayout>> fetchLayouts() async {
    /// This function loads a json file at assets/tarotLayouts.json that describes all of the different
    /// tarotLayouts available, captured as a single object where each key represents a different pascalCase layout name
    /// and the contents of each key are a json-encoded TarotLayout.  This is simple to read and the function
    /// requires no inputs to achieve its results.
    verbose("LayoutProvider.fetchLayouts");

    IMap<String, TarotLayout> retVal = const IMap<String, TarotLayout>.empty();

    String layoutsJson = await rootBundle.loadString(
      "assets/tarotLayouts.json",
    );
    verbose("  layoutsJson is $layoutsJson");

    if (layoutsJson.isNotEmpty) {
      // KEEP the comments below, they document the former effort to safely retrieve
      // our asset. Dart documentation tells that errors derived from Error are not meant
      // to be caught; they represent a programming error.
      // try {
      //   // try to load our asset file from the fixed location given
      //   layoutsJson = await rootBundle.loadString("assets/tarotLayouts.json");
      // } catch (e, _) {
      //   // if that fails, log an error
      //   log("fetchLayouts raised error $e");
      //
      //   return retVal; // return an empty map
      // }

      verbose("  trying repairJson");
      final decodedData = repairJson(
        layoutsJson,
        logging: true,
        skipDecodeAttempt: true,
      );
      verbose("  repairJson returned $decodedData");
      // const encoder = JsonEncoder.withIndent('  ');
      // verbose(encoder.convert(decodedData));

      final LayoutList? allLayouts;

      verbose("  trying LayoutList.fromJson()");
      try {
        allLayouts = LayoutList.fromJson(decodedData['data']);
        verbose("  success! allLayouts is $allLayouts");
        verbose("  converting to map");

        for (var item in allLayouts.layouts) {
          retVal = retVal.add(item.name, item);
        }
      } catch (e, _) {
        error("  Failure! LayoutList.fromJson raised error $e");
      }
    }

    return retVal;

    //   try {
    //     verbose("  trying jsonDecode:");
    //
    //     final decoded = jsonDecode(decodedData);
    //     verbose("  jsonDecode returned $decoded");
    //
    //     try {
    //       verbose("  trying LayoutList.fromJson on decoded");
    //
    //       final allLayouts = LayoutList.fromJson(decoded);
    //       verbose(
    //         '  Success! allLayouts has ${allLayouts.layouts.length} entries.',
    //       );
    //     } catch (e, _) {
    //       error("  Failure! Error decoding layout list: $e");
    //       // error("  layout list json is $decoded");
    //     }
    //
    //     // TODO: I've verified that jsonDecode works for my current layout
    //     // json input. The returned item is a list? or an iterable, so:
    //     // convert that to an IList, and then map down it to create layouts.
    //     // the code below no longer works, because it's expecting an IMap rather than
    //     // an IList; fix that up and we should be good to go.
    //
    //     for (var item in decoded) {
    //       verbose("  item is $item");
    //
    //       if (item["layoutType"] == "NewTarotLayout") {
    //         final schema = JsonSchema.create(NewTarotLayout.jsonSchema);
    //         verbose(" json schema is $schema");
    //
    //         final validation = schema.validate(
    //           item,
    //           parseJson: true,
    //           validateFormats: true,
    //         );
    //         verbose(" validation is $validation");
    //       }
    //
    //       try {
    //         final TarotLayout layout = TarotLayout.fromJson(item);
    //         verbose("  layout is $layout");
    //         retVal = retVal.add(layout.name, layout);
    //         verbose("  item added to retVal");
    //       } catch (e, _) {
    //         error("  error decoding layout: $e");
    //         error("  layout json is $item");
    //       }
    //     }
    //     // retVal = IList<IMap<String, dynamic>>(decoded)
    //     //     .map<IMap<String, TarotLayout>>(
    //     //       (key, value) => MapEntry<String, TarotLayout>(
    //     //         key,
    //     //         TarotLayout.fromJson(value),
    //     //       ),
    //     //     );
    //   } catch (e, _) {
    //     verbose("error decoding json: $e");
    //   }
    // }

    // and return a map that uses the same keys as our json file input, but has TarotLayout objects as values
    return retVal;
  }

  Future<Option<String>> loadMarkdownAsset(String assetPath) async =>
      TaskOption<String>.tryCatch(
        () async => await rootBundle.loadString(assetPath),
      ).run();

  Future<Option<String>> tryLoadMarkdownAsset(
    Iterable<String> assetPaths,
    String kind,
  ) async {
    return assetPaths
        .where((asset) => assetKind(asset) == kind)
        .firstOrNull
        .letWithElse(
          (asset) => loadMarkdownAsset(asset),
          orElse: Option<String>.none(),
        );
  }

  Option<AssetGenImage> tryImageAsset(
    Iterable<String> assetPaths,
    String kind,
  ) => assetPaths
      .where((asset) => assetKind(asset) == kind)
      .firstOrNull
      .letWithElse(
        (assetPath) => Option<AssetGenImage>.of(AssetGenImage(assetPath)),
        orElse: Option<AssetGenImage>.none(),
      );

  String assetKind(String assetPath) =>
      assetPath.split("/").let((it) => it[it.length - 2]);

  Future<TCModelAssets> loadAssetsForCard(TarotDeckCards card) async {
    log("AssetProvider.loadAssetsForCard");

    if (card == TarotDeckCards.noneCard) {
      return (
        description: Option<String>.none(),
        uprightMeaning: Option<String>.none(),
        reversedMeaning: Option<String>.none(),
        image: Option<AssetGenImage>.none(),
      );
    }

    return ComputedsManager.deckAssetPaths.value
        .where((String assetName) => assetName.contains(card.name))
        .let(
          (cardAssets) async => switch (cardAssets.isEmpty) {
            true => (
              description: Option<String>.none(),
              uprightMeaning: Option<String>.none(),
              reversedMeaning: Option<String>.none(),
              image: Option<AssetGenImage>.none(),
            ),
            false => (
              description: await tryLoadMarkdownAsset(
                cardAssets,
                "descriptions",
              ),
              uprightMeaning: await tryLoadMarkdownAsset(
                cardAssets,
                "uprightMeanings",
              ),
              reversedMeaning: await tryLoadMarkdownAsset(
                cardAssets,
                "reversedMeanings",
              ),
              image: tryImageAsset(cardAssets, "images"),
            ),
          },
        );
  }
}
