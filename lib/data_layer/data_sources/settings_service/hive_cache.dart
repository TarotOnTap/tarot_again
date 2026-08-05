import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:tarot_again/util/util.dart';

/// A cache access provider class for shared preferences using Hive library
@singleton
class HiveCache extends CacheProvider with Logging {
  Box? _preferences;
  final String keyName = 'app_preferences';

  HiveCache(this.hiveService) {
    WidgetsFlutterBinding.ensureInitialized();
  }

  final HiveService hiveService;

  /// this init function is required by the CacheProvider interface, but we
  /// don't need to do anything here. [hiveService.preferences] holds our
  /// database.
  @override
  Future<void> init() async {}

  Set get keys => getKeys();

  @override
  bool? getBool(String key, {bool? defaultValue}) {
    return hiveService.preferences.get(key);
  }

  @override
  double? getDouble(String key, {double? defaultValue}) {
    return hiveService.preferences?.get(key);
  }

  @override
  int? getInt(String key, {int? defaultValue}) {
    return hiveService.preferences?.get(key);
  }

  @override
  String? getString(String key, {String? defaultValue}) {
    return hiveService.preferences?.get(key);
  }

  @override
  Future<void> setBool(String key, bool? value) async {
    await hiveService.preferences?.put(key, value);
  }

  @override
  Future<void> setDouble(String key, double? value) async {
    await hiveService.preferences?.put(key, value);
  }

  @override
  Future<void> setInt(String key, int? value) async {
    await hiveService.preferences?.put(key, value);
  }

  @override
  Future<void> setString(String key, String? value) async {
    await hiveService.preferences?.put(key, value);
  }

  @override
  Future<void> setObject<T>(String key, T? value) async {
    await hiveService.preferences?.put(key, value);
  }

  @override
  bool containsKey(String key) {
    return hiveService.preferences?.containsKey(key) ?? false;
  }

  @override
  Set getKeys() {
    return hiveService.preferences?.keys.toSet() ?? {};
  }

  @override
  Future<void> remove(String key) async {
    if (containsKey(key)) {
      await hiveService.preferences?.delete(key);
    }
  }

  @override
  Future<void> removeAll() async {
    final keys = getKeys();
    await hiveService.preferences.deleteAll(keys.map((e) => e.toString()));
  }

  @override
  T? getValue<T>(String key, {T? defaultValue}) {
    var value = hiveService.preferences.get(key);
    if (value != null) {
      return value;
    }
    return defaultValue;
  }
}
