import 'package:tarot_again/util/util.dart';

/// An abstract class defining the persistence adapter contract for [PersistedSignal].
///
/// Implement this interface to bind `PersistedSignal` to your storage engine of
/// choice, such as local files, SQLite, SharedPreferences, Hive, or indexedDB.
///
/// ### Example: Custom Shared Preferences Store (Flutter)
/// ```dart
/// import 'package:shared_preferences/shared_preferences.dart';
/// import 'package:signals/signals.dart';
///
/// class SharedPreferencesStore implements SignalsKeyValueStore {
///   final SharedPreferences prefs;
///   SharedPreferencesStore(this.prefs);
///
///   @override
///   Future<String?> getItem(String key) async {
///     return prefs.getString(key);
///   }
///
///   @override
///   Future<void> setItem(String key, String value) async {
///     await prefs.setString(key, value);
///   }
///
///   @override
///   Future<void> removeItem(String key) async {
///     await prefs.remove(key);
///   }
/// }
/// ```
///
/// @link https://dartsignals.dev/utilities/persisted
abstract class IHivezSignalsKeyValueStore {
  /// Sets an item in the store.
  Future<void> setItem<T>(Object key, T? value);

  /// Gets an item from the store.
  Future<T?> getItem<T>(Object key);

  /// Removes an item from the store.
  Future<void> removeItem(Object key);

  /// The default store to be used if no store is provided.
  // static HivezSignalsKeyValueStore defaultStore = HivezKeyValueStore();
}

@singleton
class HivezPersistedPreferencesStore extends IHivezSignalsKeyValueStore {
  HivezPersistedPreferencesStore(this.hiveService);

  final HiveService hiveService;

  @override
  Future<void> setItem<T>(Object key, T? value) =>
      hiveService.preferences.put(key, value);

  @override
  Future<T?> getItem<T>(Object key) =>
      hiveService.preferences.get(key) as Future<T?>;

  @override
  Future<void> removeItem(Object key) => hiveService.preferences.delete(key);
}
