import 'package:tarot_again/data_layer/data_layer.dart';
import 'package:tarot_again/data_layer/repositories/types.dart';
import 'package:tarot_again/util/util.dart';

typedef LayoutCache = IMap<String, LayoutMapRecord>;

class LayoutRepository extends SingletonRepository {
  LayoutCache layouts = LayoutCache({});

  Future<void> cacheLayouts() async {
    LayoutProvider lp = LayoutProvider();

    for (var layout in Assets.layouts.tarotLayouts.values) {
      TarotLayout l = await lp.loadLayout(layout);

      var pieceList = layout.split("/");
      String assetFileName = pieceList.last;
      String assetName = assetFileName.split('.')[0];
      // assetName is the map key

      String displayName = assetName.splitMapJoin(
        "_",
        onMatch: (match) => " ",
        onNonMatch:
            (String piece) =>
                piece.substring(0, 1).toUpperCase() + piece.substring(1),
      );

      layouts = layouts.add(
        assetName,
        LayoutMapRecord(displayName: displayName, assetPath: layout, layout: l),
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
  }

  LayoutRepository._() {
    unawaited(cacheLayouts());
  }

  factory LayoutRepository() {
    if (!sl.isRegistered<LayoutRepository>()) {
      return sl.registerSingleton<LayoutRepository>(LayoutRepository._());
    }

    return sl<LayoutRepository>();
  }

  Iterable<String> get listLayouts =>
      layouts.keys; // like for a listview, or other display element

  Iterable<String> get layoutDisplayNames => [
    for (var item in layouts.values) item.displayName,
  ];

  TarotLayout getLayoutByLayoutName(String name) =>
      layouts.get(name)?.layout ??
      TarotLayout.nullLayout(displayName: "No Such Layout");

  TarotLayout getLayoutByDisplayName(String displayName) {
    TarotLayout result = TarotLayout.nullLayout(displayName: "No Such Layout");

    for (var item in layouts.entries) {
      if (item.value.displayName == displayName) {
        result = item.value.layout;
        break;
      }
    }

    return result;
  }
}
