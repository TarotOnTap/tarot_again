import 'package:tarot_again/util/util.dart';

import 'app_settings.dart';
import 'hive_cache.dart';

@singleton
class AppSettings with Logging {
  AppSettings() {
    verbose('AppSettings().');
  }

  /// async create method
  /// We only need the Hive instance here because we depend on Hive being
  /// initialized before we can run.
  @FactoryMethod(preResolve: true)
  static Future<AppSettings> create(HiveService hive) async {
    Logging.staticVerbose("AppSettings.create()");

    final appSettings = AppSettings();
    Logging.staticVerbose("  awaiting Settings.init");
    await Settings.init(cacheProvider: HiveCache());
    await firstRunSettings();
    return appSettings;
  }

  bool get isInitialized => Settings.isInitialized;

  void clearCache() => Settings.clearCache();

  bool? containsKey(cacheKey) => Settings.containsKey(cacheKey);

  void ensureCacheProvider() => Settings.ensureCacheProvider();

  T? getValue<T>(cacheKey, defaultValue) =>
      Settings.getValue<T>(cacheKey, defaultValue: defaultValue);

  Future<void> setValue<T>(String cacheKey, T value, bool notify) =>
      Settings.setValue<T>(cacheKey, value, notify: notify);
}
