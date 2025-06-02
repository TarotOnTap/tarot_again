import 'package:tarot_again/util/util.dart';

final Signal<TarotLayout> tarotLayout = signal<TarotLayout>(
  TarotLayout.nullLayout(),
  debugLabel: "tarotLayout",
);

final FutureSignal<IMap<String, TarotLayout>> tarotLayoutsByName = futureSignal(
  () async => await sl<LayoutManager>().fetchLayouts(),
  debugLabel: "tarotLayoutsByName",
  dependencies: [allAssetPaths],
);

final Computed<IList<String>> layoutNames = computed(
  () => switch (tarotLayoutsByName.value) {
    AsyncData data => data.value.keys.toIList(),
    _ => const IList<String>.empty(),
  },
  debugLabel: "layoutNames",
);

final Computed<IList<String>> layoutDisplayNames = computed(
  () => switch (tarotLayoutsByName.value) {
    AsyncData data => data.value.values.also((vv) => vv.sort()),
    /* map((TarotLayout l) => l.displayName).toIList(), */
    _ => const IList<String>.empty(),
  },
  debugLabel: "layoutDisplayNames",
);

final Computed<LayoutAssetCache> layoutsByDisplayName = computed(() {
  LayoutAssetCache retVal = const LayoutAssetCache.empty();

  Iterable<String> keys = <String>[];
  Iterable<TarotLayout> values = <TarotLayout>[];

  switch (tarotLayoutsByName.value) {
    case AsyncData data:
      keys = data.value.values.map((TarotLayout l) => l.displayName);
      values = data.value.values;
    case _:
      ;
  }

  retVal = LayoutAssetCache.fromIterables(keys, values);

  return retVal;
}, debugLabel: "layoutsByDisplayName");

void initializeLayoutReactives() {
  for (var signal in [
    layoutNames,
    layoutDisplayNames,
    layoutsByDisplayName,
    tarotLayout,
    tarotLayoutsByName,
  ]) {
    var _ = (signal as ReadonlySignal<dynamic>).value;
  }
}
