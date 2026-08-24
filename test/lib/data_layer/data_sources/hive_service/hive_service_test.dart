// this gets us GetIt/WatchIt packages

import 'package:flutter_test/flutter_test.dart';
import 'package:hivez_flutter/hivez_flutter.dart';
import 'package:path_provider_android/path_provider_android.dart';
import 'package:path_provider_windows/path_provider_windows.dart';
import 'package:platform/platform.dart';
import 'package:tarot_again/util/services.dart';
import 'package:tarot_again/util/util.dart' hide test;

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  // get the logging service up and running, so we can use it!
  // final String appName = "testing hive_service";
  // initializeLoggingService();

  final getIt = GetIt.instance;

  final lp = LocalPlatform();

  if (lp.isWindows) {
    PathProviderWindows.registerWith();
  } else if (lp.isAndroid) {
    PathProviderAndroid.registerWith();
  } else {
    throw Exception(
      "Please manually register a path provider for ${lp.operatingSystem}",
    );
  }

  final appName = lp.executable.split('.')[0];

  await initServices(appName: appName, test: true);

  // final tempStoragePath = ""; // (await getTemporaryDirectory()).toString();

  test('Testing to make sure Hive is alive', () async {
    final testBox = await Hive.openBox<int>("testBox");

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

    await testBox.close();

    final testBox2 = await Hive.openBox<int>("testBox");

    List<int?> resultData = <int?>[];

    for (var index in ['a', 'b', 'c', 'D', 'E', 'F', 'G', 'Q']) {
      resultData.add(await testBox2.get(index));
    }
    expect(resultData, [8, 6, 7, 5, 3, 0, 9, null]);
    await testBox2.close();
  });

  group("Testing hive_service", () {
    // setUp(() async {
    //   HiveService s = await HiveService.create();
    //   sl.registerSingleton<HiveService>(s);
    //   // HiveService.create() is self-registering
    //
    //   return Future<void>.value();
    // });

    // tearDown(() async {
    //   Logging.sVerbose("\nGroup 'Testing hive_service tearDown()");
    //
    //   await sl.unregister<HiveService>();
    // });

    test('HiveService service registered in GetIt', () {
      expect(sl.isRegistered<HiveService>(), true);
    });
  });
}
