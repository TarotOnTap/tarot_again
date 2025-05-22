import 'package:tarot_again/data_layer/data_layer.dart';
import 'package:tarot_again/managers/session_manager/session_manager.dart';
import 'package:watch_it/watch_it.dart';

// register all of our singletons with GetIt, right up front.
void registerSingletons() {
  sl.registerSingleton<AsyncRandoms>(AsyncRandoms());
  sl.registerSingleton<AssetProvider>(AssetProvider());
  sl.registerSingleton<CardAssetsProvider>(CardAssetsProvider());
  sl.registerSingleton<LayoutProvider>(LayoutProvider());
  sl.registerSingleton<StandardDeckProvider>(StandardDeckProvider());
  sl.registerSingleton<AssetRepository>(AssetRepository());
  // sl.registerSingleton<DeckManager>(DeckManager());
  sl.registerSingleton<LayoutRepository>(LayoutRepository());
  sl.registerSingleton<SessionManager>(SessionManager());
  // sl.registerSingleton<BulkCardControlBloc>(BulkCardControlBloc());0.
  // sl.registerSingleton<LayoutBloc>(LayoutBloc());
  // sl.registerSingleton<SettingsBloc>(SettingsBloc());
}
