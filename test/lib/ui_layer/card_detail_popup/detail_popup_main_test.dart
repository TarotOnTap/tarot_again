import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path_provider_android/path_provider_android.dart';
import 'package:path_provider_windows/path_provider_windows.dart';
import 'package:platform/platform.dart';
import 'package:tarot_again/ui_layer/card_detail_popup/detail_popup_main.dart';
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

  group('DetailPopupMain', () {
    // setUpAll(() async {
    //   try {
    //     Logging.sVerbose(
    //       "  setUpAll: checking that initServices initialized sl<HiveService>()",
    //     );
    //     final hiveService = sl<HiveService>();
    //
    //     Logging.sVerbose("  post-sl<HiveService>()");
    //     Logging.sVerbose("  hiveService is $hiveService");
    //     Logging.sVerbose(
    //       "  hiveService.assetStorageBox is ${hiveService.assetStorageBox}",
    //     );
    //   } catch (e) {
    //     Logging.sVerbose("  setUpAll: ERROR: $e");
    //     rethrow;
    //   }
    // });

    group('Route configuration', () {
      test('constructor stores slotIndex parameter', () {
        final popup = DetailPopupMain(slotIndex: 3);
        expect(popup.slotIndex, equals(3));
      });

      test('barrierColor is black with 50% opacity', () {
        final popup = DetailPopupMain(slotIndex: 0);
        expect(popup.barrierColor, equals(Colors.black.withAlpha(0x50)));
      });

      test('barrierDismissible allows dismissal by tapping barrier', () {
        final popup = DetailPopupMain(slotIndex: 0);
        expect(popup.barrierDismissible, isTrue);
      });

      test('barrierLabel describes the dismissible dialog', () {
        final popup = DetailPopupMain(slotIndex: 0);
        expect(popup.barrierLabel, equals('Dismissible Dialog'));
      });

      test('transitionDuration is 300 milliseconds', () {
        final popup = DetailPopupMain(slotIndex: 0);
        expect(
          popup.transitionDuration,
          equals(const Duration(milliseconds: 300)),
        );
      });

      test('inherits from PopupRoute', () {
        final popup = DetailPopupMain(slotIndex: 0);
        expect(popup, isA<PopupRoute<dynamic>>());
      });
    });

    group('Multiple popup instances', () {
      test('each instance has independent slotIndex', () {
        final popup1 = DetailPopupMain(slotIndex: 0);
        final popup2 = DetailPopupMain(slotIndex: 5);
        final popup3 = DetailPopupMain(slotIndex: 10);

        expect(popup1.slotIndex, equals(0));
        expect(popup2.slotIndex, equals(5));
        expect(popup3.slotIndex, equals(10));
      });

      test('all instances share same barrier configuration', () {
        final popup1 = DetailPopupMain(slotIndex: 0);
        final popup2 = DetailPopupMain(slotIndex: 1);

        expect(popup1.barrierColor, equals(popup2.barrierColor));
        expect(popup1.barrierDismissible, equals(popup2.barrierDismissible));
        expect(popup1.barrierLabel, equals(popup2.barrierLabel));
        expect(popup1.transitionDuration, equals(popup2.transitionDuration));
      });

      test('supports slot indices from 0 to at least 22', () {
        for (int i = 0; i <= 22; i++) {
          final popup = DetailPopupMain(slotIndex: i);
          expect(popup.slotIndex, equals(i));
        }
      });
    });

    group('Edge cases', () {
      test('handles zero slot index', () {
        final popup = DetailPopupMain(slotIndex: 0);
        expect(popup.slotIndex, equals(0));
      });

      test('handles large slot index values', () {
        final popup = DetailPopupMain(slotIndex: 999);
        expect(popup.slotIndex, equals(999));
      });

      test('supports generic type parameter', () {
        final popup = DetailPopupMain<String>(slotIndex: 0);
        expect(popup, isA<DetailPopupMain<String>>());
      });
    });
  });
}
