import 'package:tarot_again/util/util.dart';

// register all of our singletons with GetIt, right up front.
void registerSingletons() {
  sl.registerSingleton<Reactives>(Reactives());
  sl.registerSingleton<AsyncRandoms>(AsyncRandoms());
  sl.registerSingleton<AssetManager>(AssetManager());
  // sl.registerSingleton<CardAssetsProvider>(CardAssetsProvider());
  sl.registerSingleton<LayoutManager>(LayoutManager());
  sl.registerSingleton<StandardDeckProvider>(StandardDeckProvider());
  sl.registerSingleton<AssetRepository>(AssetRepository());
  // sl.registerSingleton<LayoutManager>(LayoutManager());
  sl.registerSingleton<SessionManager>(SessionManager());
}
