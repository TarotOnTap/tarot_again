import 'package:injectable/injectable.dart';
import 'package:tarot_again/util/util.dart';

import 'register_singletons.config.dart';

final services = GetIt.instance;

@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: true, // default
)
void configureServices() => services.init();

// register all of our singletons with GetIt, right up front.
Future<void> registerSingletons() async {
  // need to have called Settings.init() before we can use it here.
  // currently handled in main();
  sl.registerSingleton<Settings>(Settings());
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
