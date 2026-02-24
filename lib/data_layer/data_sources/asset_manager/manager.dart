import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hashlib/hashlib.dart';
import 'package:hivez_flutter/hivez_flutter.dart';
import 'package:json_repair_flutter/json_repair_flutter.dart';
import 'package:tarot_again/util/util.dart';

export 'types.dart';

typedef JsonMap = IMap<String, dynamic>;

@singleton
class AssetManager with Logging {
  AssetManager(this.appSettings) {
    // to be clear - we only need HiveService to
    // ensure that the Hive db is all set up and ready to go. We don't actually
    // interact with it through the service interface, but instead through the
    // good offices of the Hivez package.
    verbose("AssetManager.AssetManager()");
  }

  final AppSettings appSettings;

  @FactoryMethod(preResolve: true)
  static Future<AssetManager> create(
    HiveService hiveService,
    AppSettings appSettings,
  ) async {
    Logging.staticVerbose('AssetManager.create');
    Logging.staticVerbose('  HiveService is $hiveService');
    Logging.staticVerbose('  AppSettings is $appSettings');
    AssetManager retVal = AssetManager(appSettings);

    Logging.staticVerbose('  awaiting getAllAssetPaths');
    final assetPaths = await getAllAssetPaths();

    Logging.staticVerbose('  awaiting fetchLayouts');
    final layoutsByName = await retVal.fetchLayouts();

    // initialize all of our fixed assets, here, in one go
    Logging.staticVerbose('  batching for SignalsManager');
    batch(() {
      SignalsManager.allAssetPaths.value = assetPaths;
      SignalsManager.tarotLayoutsByName.value = layoutsByName;
    });
    Logging.staticVerbose('  finished AssetManager.create()');
    return retVal;
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

    // adding new functionality:
    // what I want to do is check to see if the version of tarotLayouts.json on
    // disk is *newer* than the json layouts stored in hive.
    // A way to do that, I think, is to compare hashes of the asset on disk with
    // a hash stored in the Settings object; if they differ, then:
    //   convert the layout json file to objects, as usual
    //   save the objects to hive and set the hash stored in Settings to the new
    //   hash.
    verbose("  getting hash of layouts file");

    IMap<String, TarotLayout> retVal = const IMap<String, TarotLayout>.empty();
    final existingLayoutsBox = Box<String, TarotLayout>("tarotLayouts");
    await existingLayoutsBox.ensureInitialized();

    String layoutsJson = await rootBundle.loadString(
      "assets/tarotLayouts.json",
    );

    verbose("  layoutsJson is $layoutsJson");
    final layoutJsonHash = sha3_512sum(layoutsJson);
    verbose("  layoutJsonHash is $layoutJsonHash");

    final oldHash = Settings.getValue<String>("tarotLayoutsHash");
    verbose("  oldHash is $oldHash");

    if (oldHash != layoutJsonHash) {
      if (layoutsJson.isNotEmpty) {
        verbose("  trying repairJson");
        final decodedData = repairJson(
          layoutsJson,
          logging: true,
          skipDecodeAttempt: true,
        );
        verbose("  repairJson returned $decodedData");

        final LayoutList? allLayouts;

        verbose("  trying LayoutList.fromJson()");
        try {
          allLayouts = LayoutList.fromJson(decodedData['data']);
          verbose("  success! allLayouts is $allLayouts");
          verbose("  converting to map");

          for (var item in allLayouts.layouts) {
            retVal = retVal.add(item.name, item);
          }

          verbose('  retVal has keys: ${retVal.keys}');

          final bock = retVal.unlock;
          verbose(' retVal.unlock has runtime type ${bock.runtimeType}');

          await existingLayoutsBox.putAll(retVal.unlock);
        } catch (e, _) {
          error("  Failure! LayoutList.fromJson raised error $e");
        }
      } else {
        verbose("  importing existing layouts from hive box 'tarotLayouts");
        verbose("  existingLayoutsBox is $existingLayoutsBox");

        // a box is essentially a map, and this map is going to have the type
        // Map<String, TarotLayout> - as that is the way it was created!
        retVal = (await existingLayoutsBox.toMap()).lock;
      }
    }

    // close the box, deallocate the resources, etc. etc.
    await existingLayoutsBox.closeBox();

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
