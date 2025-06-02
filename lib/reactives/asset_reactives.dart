import 'package:tarot_again/util/util.dart';

final FutureSignal<IList<String>> allAssetPaths = futureSignal(
  () async => (await sl<AssetManager>().getAllAssetPaths()).toIList(),
  debugLabel: "allAssetPaths",
);

final Computed<IList<String>> deckAssetPaths = computed(
  () => switch (allAssetPaths.value) {
    AsyncData data =>
      data.value
          .where(
            (path) =>
                path.contains("decks/${sl<Reactives>().deckType.value.name}"),
          )
          .toIList(),
    _ => const IList<String>.empty(),
  },
  debugLabel: "deckAssetPaths",
);

final Computed<IList<String>> tarotLayoutAssetPaths = computed(
  () => switch (allAssetPaths.value) {
    AsyncData data =>
      data.value.where((path) => path.contains("assets/layouts")).toIList(),
    _ => const IList<String>.empty(),
  },
  debugLabel: "layoutAssetPaths",
);

void initializeAssetReactives() {
  var _ = allAssetPaths.value;
  var _ = deckAssetPaths.value;
  var _ = tarotLayoutAssetPaths.value;
}
