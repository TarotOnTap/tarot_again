import 'package:tarot_again/util/util.dart';

// register all of our singletons with GetIt, right up front.
Future<void> registerSingletons() async {
  sl.registerSingleton<SignalsManager>(SignalsManager());
  sl.registerSingleton<ComputedsManager>(ComputedsManager());
  sl.registerSingleton<EffectsManager>(EffectsManager());

  sl.registerSingleton<AsyncRandoms>(AsyncRandoms());

  sl.registerSingleton<AssetManager>(AssetManager());
  await sl<AssetManager>().postInit();

  sl.registerSingleton<LayoutManager>(LayoutManager());
  sl.registerSingleton<StandardDeckProvider>(StandardDeckProvider());
  sl.registerSingleton<AssetRepository>(AssetRepository());

  sl.registerSingleton<SessionManager>(SessionManager());
}
