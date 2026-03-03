import 'package:hivez/hivez.dart';
import 'package:signals/signals_flutter.dart';

class HivezSignalsKeyValueStore implements SignalsKeyValueStore {
  HivezSignalsKeyValueStore({required this.settings});

  final Box<String, dynamic> settings;

  @override
  Future<void> setItem(String key, String value) async {
    await settings.put(key, value);
  }

  @override
  Future<String?> getItem(String key) async {
    await settings.get(key);
  }

  @override
  Future<void> removeItem(String key) async {
    await settings.delete(key);
  }
}
