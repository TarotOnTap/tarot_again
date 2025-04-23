import 'package:tarot_again/data_layer/data_layer.dart';
import 'package:tarot_again/data_layer/repositories/types.dart';
import 'package:tarot_again/util/util.dart';

typedef LayoutCache = IMap<String, LayoutMapRecord>;

class LayoutRepository extends SingletonRepository with Logging {
  LayoutCache layouts = LayoutCache({});

  IList<String> layoutDisplayNames = const IList<String>.empty();

  Future<void> cacheLayouts() async {
    verbose("cacheLayouts");

    LayoutProvider lp = LayoutProvider();

    for (var layout in Assets.layouts.tarotLayouts.values) {
      verbose("  layout is $layout");

      TarotLayout l = await lp.loadLayout(layout);
      verbose("  loadedLayout = $l");

      var pieceList = layout.split("/");
      String assetFileName = pieceList.last;
      String assetName = assetFileName.split('.')[0];
      // assetName is the map key
      verbose("  assetName is $assetName");
      //
      // String displayName = assetName.splitMapJoin(
      //   "_",
      //   onMatch: (match) => " ",
      //   onNonMatch:
      //       (String piece) =>
      //           piece.substring(0, 1).toUpperCase() + piece.substring(1),
      // );
      // verbose("  displayName is $displayName");

      layouts = layouts.add(
        assetName,
        LayoutMapRecord(
          displayName: l.displayName,
          assetPath: layout,
          layout: l,
        ),
      );
    }

    layouts = layouts.add(
      "empty_layout",
      LayoutMapRecord(
        displayName: "Empty Layout",
        assetPath: "",
        layout: TarotLayout.nullLayout(),
      ),
    );

    verbose("  setting layoutDisplayNames");
    layoutDisplayNames = layouts.values.fold(
      const IList<String>.empty(),
      (prev, item) => prev.add(item.displayName).toIList(),
    );

    // sl<LayoutBloc>().add(SetLayoutNames(newLayoutNames: layoutDisplayNames));
  }

  LayoutRepository._() {
    // unawaited(cacheLayouts());
  }

  factory LayoutRepository() {
    if (!sl.isRegistered<LayoutRepository>()) {
      return sl.registerSingleton<LayoutRepository>(LayoutRepository._());
    }

    return sl<LayoutRepository>();
  }

  Iterable<String> get listLayouts =>
      layouts.keys; // like for a listview, or other display element

  TarotLayout getLayoutByLayoutName(String name) =>
      layouts.get(name)?.layout ??
      TarotLayout.nullLayout(displayName: "No Such Layout");

  TarotLayout getLayoutByDisplayName(String displayName) =>
      layouts.entries
          .firstWhere(
            (item) => item.value.displayName == displayName,
            orElse:
                () => MapEntry<String, LayoutMapRecord>(
                  "nullLayout",
                  nullLayoutMapRecord,
                ),
          )
          .value
          .layout;
}
