// this gets us GetIt/WatchIt packages

import 'package:flutter_test/flutter_test.dart';
import 'package:hivez_flutter/hivez_flutter.dart';
import 'package:path_provider_android/path_provider_android.dart';
import 'package:path_provider_windows/path_provider_windows.dart';
import 'package:platform/platform.dart';
// import 'package:platform_channel/main.dart' as platform_channel;
import 'package:tarot_again/hive/hive_adapters.dart';
import 'package:tarot_again/hive/hive_registrar.g.dart';
import 'package:tarot_again/util/util.dart' hide test;

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  // get the logging service up and running, so we can use it!
  // final String appName = "testing hive_service";
  initializeLoggingService();

  final lp = LocalPlatform();

  final appName = lp.executable.split('.')[0];

  if (lp.isWindows) {
    PathProviderWindows.registerWith();
  } else if (lp.isAndroid) {
    PathProviderAndroid.registerWith();
  } else {
    throw Exception(
      "Please manually register a path provider for ${lp.operatingSystem}",
    );
  }

  final tempStoragePath = ""; // (await getTemporaryDirectory()).toString();
  Logging.sVerbose('tempStoragePath is $tempStoragePath');

  Logging.sVerbose('initializing Hive..initFlutter..registerAdapters');

  await Hive.initFlutter(tempStoragePath);
  Hive.registerAdapters();

  Logging.sVerbose('manually registering IListAdapter');
  Hive.registerAdapter<IList>(IListAdapter());

  test('Testing to make sure Hive is alive', () async {
    final testBox = await Hive.openBox<int>("testBox");
    Logging.sVerbose('testBox is $testBox');

    Logging.sVerbose('writing data');
    for (var i in [
      ('a', 8),
      ('b', 6),
      ('c', 7),
      ('D', 5),
      ('E', 3),
      ('F', 0),
      ('G', 9),
    ]) {
      await testBox.put(i.$1, i.$2);
    }
    Logging.sVerbose('closing box.');
    await testBox.close();

    Logging.sVerbose('reopening box into a new variable');
    final testBox2 = await Hive.openBox<int>("testBox");
    Logging.sVerbose('keys are: ${testBox2.keys}');
    Logging.sVerbose('values are: ${testBox2.values}');

    int? resultData;
    Logging.sVerbose('reading data');
    for (var index in ['a', 'b', 'c', 'D', 'E', 'F', 'G', 'Q']) {
      resultData = await testBox2.get(index);
      Logging.sVerbose('  $index is $resultData');
    }
    Logging.sVerbose('closing box.');
    await testBox2.close();
  });

  group("Testing hive_service", () {
    setUp(() async {
      Logging.sVerbose("\nGroup 'Testing hive_service setUp()");
      Logging.sVerbose('appName is $appName');

      HiveService s = await HiveService.create();
      // HiveService.create() is self-registering

      return Future<void>.value();
    });

    tearDown(() async {
      Logging.sVerbose("\nGroup 'Testing hive_service tearDown()");

      await sl.unregister<HiveService>();

      Logging.sVerbose(
        '  sl.isRegistered<HiveService> return ${sl.isRegistered<HiveService>()}',
      );
    });

    test('HiveService service registered in GetIt', () {
      Logging.sVerbose('test HiveService registered in GetIt');
      expect(sl.isRegistered<HiveService>(), true);
    });

    test('HiveService.preferences box initialized', () async {
      Logging.sVerbose('test HiveService.preferences box initialized');
      final String testingKey = "___TESTING_ONLY___";
      final String testingValue = "___TEST_DATA_ONLY___";

      bool testResult = await sl<HiveService>().preferences.isInitialized;
      expect(testResult, true);

      bool contains = await sl<HiveService>().preferences.containsKey(
        testingKey,
      );
      expect(contains, false);

      await sl<HiveService>().preferences.put(testingKey, testingValue);
      bool contains2 = await sl<HiveService>().preferences.containsKey(
        testingKey,
      );
      expect(contains2, true);

      String? value =
          (await sl<HiveService>().preferences.get(testingKey)) as String;
      expect(value, testingValue);

      await sl<HiveService>().preferences.delete(testingKey);

      bool contains3 = await sl<HiveService>().preferences.containsKey(
        testingKey,
      );
      expect(contains3, false);
    });
  });
}
