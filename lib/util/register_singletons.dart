import 'package:tarot_again/data_layer/data_layer.dart';
import 'package:tarot_again/managers/session_manager/session_manager.dart';
import 'package:watch_it/watch_it.dart';

// register all of our singletons with GetIt, right up front.
void registerSingletons() {
  sl.registerLazySingleton<AsyncRandoms>(AsyncRandoms.new);
  sl.registerLazySingleton<AssetProvider>(AssetProvider.new);
  sl.registerLazySingleton<CardAssetsProvider>(CardAssetsProvider.new);
  sl.registerLazySingleton<LayoutProvider>(LayoutProvider.new);
  sl.registerLazySingleton<StandardDeckProvider>(StandardDeckProvider.new);
  sl.registerLazySingleton<AssetRepository>(AssetRepository.new);
  // sl.registerLazySingleton<DeckManager>(DeckManager.new);
  sl.registerLazySingleton<LayoutRepository>(LayoutRepository.new);
  sl.registerLazySingleton<SessionManager>(SessionManager.new);
  // sl.registerSingleton<BulkCardControlBloc>(BulkCardControlBloc());0.
  // sl.registerSingleton<LayoutBloc>(LayoutBloc());
  // sl.registerSingleton<SettingsBloc>(SettingsBloc());
}
