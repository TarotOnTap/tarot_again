import 'package:flutter_test/flutter_test.dart';
import 'package:hivez_flutter/hivez_flutter.dart';
import 'package:tarot_again/util/util.dart' hide test;
import 'package:tarot_again/util/services.dart';

void main() async {
  await InitServices.initializeMain(test: true).run();

  // TestWidgetsFlutterBinding.ensureInitialized();
  // Hive.init('.hivez-persisted-signal-test');
  // initializeLoggingService().run();
  sl.registerSingleton<HiveService>(HiveService());

  var testNumber = 0;

  String nextSignalName() {
    testNumber += 1;
    return 'hivez-persisted-signal-test-$testNumber';
  }

  Future<void> settlePersistence() async {
    await Future<void>.delayed(Duration.zero);
    await Future<void>.delayed(Duration.zero);
  }

  group('HivezPersistedSignal', () {
    test('uses the initial value and persists it on first load', () async {
      final signal = HivezPersistedSignal<int>(
        name: nextSignalName(),
        initialValue: 42,
      );

      final box = await signal.hiveBox;
      await signal.fetchPersistedValue(42);

      expect(signal.value, 42);
      expect(signal.persistedValueLoaded, isTrue);
      expect(await box.get('value'), 42);
    });

    test(
      'restores an existing persisted value instead of the initial value',
      () async {
        final signalName = nextSignalName();
        final storageName = '__persisted__$signalName';
        final box = await sl<HiveService>().ensureBox<String, int>(
          storageName,
          options: BoxConfig(
            storageName,
            path: '.persistedStorage',
            collection: 'persistedStorage',
          ),
        );
        await box.put('value', 99);

        final signal = HivezPersistedSignal<int>(
          name: signalName,
          initialValue: 42,
        );
        await signal.fetchPersistedValue(42);

        expect(signal.value, 99);
        expect(signal.persistedValueLoaded, isTrue);
        expect(await box.get('value'), 99);
      },
    );

    test('persists a value set after the persisted value is loaded', () async {
      final signal = HivezPersistedSignal<int>(
        name: nextSignalName(),
        initialValue: 1,
      );
      final box = await signal.hiveBox;
      await signal.fetchPersistedValue(1);

      signal.set(7);
      await settlePersistence();

      expect(signal.value, 7);
      expect(await box.get('value'), 7);
    });

    test('helper creates a signal with the expected name and value', () async {
      final signal = hivezPersistedSignal<String>(nextSignalName(), 'upright');

      expect(signal.persistedName, startsWith('__persisted__'));
      expect(signal.value, 'upright');
      expect(await signal.hiveBox, isNotNull);
    });
  });
}
