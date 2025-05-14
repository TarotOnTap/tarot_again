import 'package:tarot_again/data_layer/data_layer.dart';
import 'package:tarot_again/data_layer/repositories/types.dart';
import 'package:tarot_again/util/util.dart';

// typedef LayoutCache = IMap<String, LayoutMapRecord>;

// final assets = Symbol("assets");

class LayoutRepository extends SingletonRepository with Logging {
  late final AssetProvider assetProvider;
  late final LayoutProvider layoutProvider;

  IList<String> layoutDisplayNames = const IList<String>.empty();

  LayoutRepository._() {
    assetProvider = AssetProvider();

    layoutProvider = LayoutProvider();

    // layoutDisplayNames = IList<String>(ap.assetMap["layouts"].keys);
  }

  factory LayoutRepository() {
    if (!sl.isRegistered<LayoutRepository>()) {
      return sl.registerSingleton<LayoutRepository>(LayoutRepository._());
    }

    return sl<LayoutRepository>();
  }

  // Iterable<String> get listLayouts => layoutDisplayNames;

  Future<void> loadLayouts() async {
    verbose("LayoutRepository.loadLayouts()");
    final layoutDisplayPaths = await assetProvider.tarotLayouts.value;
    verbose("  layoutDisplayPaths is $layoutDisplayPaths");

    for (var path in layoutDisplayPaths) {
      await layoutProvider.loadLayout(path);
    }

    layoutDisplayNames =
        layoutProvider.assetCache.values
            .map((item) => item.displayName)
            .toIList();
  }

  TarotLayout getLayoutByLayoutName(String name) =>
      layoutProvider.assetCache.get(name) ??
      TarotLayout.nullLayout(displayName: "No Such Layout");

  TarotLayout getLayoutByDisplayName(String displayName) =>
      layoutProvider.assetCache.entries
          .firstWhere(
            (item) => item.value.displayName == displayName,
            orElse:
                () => MapEntry<String, TarotLayout>(
                  "nullLayout",
                  TarotLayout.nullLayout(),
                ),
          )
          .value;
}
