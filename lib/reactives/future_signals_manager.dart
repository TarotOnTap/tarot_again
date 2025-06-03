// import 'package:tarot_again/util/util.dart';
//
// class FutureSignalsManager {
//   // static final FutureSignal<Iterable<String>> allAssetPaths = futureSignal(
//   //   () => AssetManager.getAllAssetPaths(),
//   //   debugLabel: "allAssetPaths",
//   // );
//
//   // static final FutureSignal<IList<String>> layoutAssetPaths = computedFrom(
//   //   [allAssetPaths],
//   //   (args) async =>
//   //       args[0].value
//   //           ?.where((path) => path.contains("assets/layouts"))
//   //           .toIList() ??
//   //       const IList<String>.empty(),
//   //   debugLabel: "layoutAssetPaths",
//   // );
//
//   // static final FutureSignal<IMap<String, TarotLayout>> tarotLayoutsByName =
//   //     computedFrom(
//   //       [layoutAssetPaths],
//   //       (args) => switch (args[0].value) {
//   //         AsyncData<IList<String>> _ => sl<LayoutManager>().fetchLayouts(),
//   //         _ => Future.value(const IMap<String, TarotLayout>.empty()),
//   //       },
//   //       debugLabel: "tarotLayoutsByName",
//   //     );
//
//   static void ensureFutureSignals() {
//     final toInitialize = <FutureSignal>[
//       FutureSignalsManager.allAssetPaths,
//       FutureSignalsManager.layoutAssetPaths,
//       FutureSignalsManager.tarotLayoutsByName,
//     ];
//
//     for (var fs in toInitialize) {
//       var _ = fs.value;
//     }
//   }
//
//   FutureSignalsManager() {
//     log("FutureSignalsManager.FutureSignalsManager");
//   }
// }
