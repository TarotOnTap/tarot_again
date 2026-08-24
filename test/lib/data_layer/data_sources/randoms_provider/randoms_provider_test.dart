// this gets us GetIt/WatchIt packages

import 'package:flutter_test/flutter_test.dart';
import 'package:path_provider_android/path_provider_android.dart';
import 'package:path_provider_windows/path_provider_windows.dart';
import 'package:platform/platform.dart';
import 'package:tarot_again/util/services.dart';
import 'package:tarot_again/util/util.dart' hide test;

Stream<int> getNRandomInts({
  required AsyncRandoms source,
  required int count,
  int rangeLow = 0,
  required int rangeHigh,
}) async* {
  for (var i = 0; i < count; i++) {
    yield await source.getNextInt(rangeHigh: rangeHigh, rangeLow: rangeLow);
  }
}

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

  // initializeDataLayer();

  AsyncRandoms randoms = sl<AsyncRandoms>();

  test("Test RandomsProvider's initializer", () async {
    expect(randoms, isA<AsyncRandoms>());
  });

  group("AsyncRandom getNextInt using default range-low of zero, and with various ranges", () {
    test("test that random number ranges start at 0 by default", () async {
      final Stream<int> randomStream = getNRandomInts(
        source: randoms,
        count: 1000,
        rangeHigh: 500,
      );

      bool testResult = true;

      await for (int elem in randomStream) {
        if (elem < 0) {
          Logging.sVerbose('found a negative random number: $elem');
          testResult = false;
          break;
        }
      }

      // bool testResult = await randomStream.every((int elem) => elem >= 0);

      expect(testResult, true);
    });

    test("test that random number ranges produce numbers less than their upper limit", () async {
      final Stream<int> randomStream = getNRandomInts(
        source: randoms,
        count: 1000,
        rangeHigh: 357,
      );

      bool testResult = true;

      await for (int elem in randomStream) {
        if (elem >= 357) {
          Logging.sVerbose(
            'found a random number greater than upper limit of 357: $elem',
          );
          testResult = false;
          break;
        }
      }

      // bool testResult = await randomStream.every((int elem) => elem < 357);
      expect(testResult, true);
    });
    test(
      "test that random numbers over a range stay within their limits",
      () async {
        final Stream<int> randomStream = getNRandomInts(
          source: randoms,
          count: 1000,
          rangeLow: -852,
          rangeHigh: 922,
        );

        bool testResult = true;

        await for (int elem in randomStream) {
          if (elem < -852 || elem >= 922) {
            Logging.sVerbose(
              'found a random number out of range [-852, 922): $elem',
            );
            testResult = false;
            break;
          }
        }

        // bool testResult = await randomStream.every(
        //   (int elem) => elem >= -852 && elem < 922,
        // );

        expect(testResult, true);
      },
    );
  });

  group("Testing AsyncRandoms shuffleIterableStream", () {});
}
