import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
// import 'package:path_provider_android/path_provider_android.dart';
// import 'package:path_provider_windows/path_provider_windows.dart';
// import 'package:platform/platform.dart';
import 'package:tarot_again/util/services.dart';
import 'package:tarot_again/util/logging.dart';
import 'package:fpdart/fpdart.dart';

void main() async {
  // ignore: unused_local_variable
  final getIt = GetIt.instance;
  TestWidgetsFlutterBinding.ensureInitialized();
  // get the logging service up and running, so we can use it!
  // final String appName = "testing hive_service";
  initializeLoggingService();

  // get the logging service up and running, so we can use it!
  // WidgetsFlutterBinding.ensureInitialized();

  test("Test that initServices returns without error", () async {
    await InitServices.initServices().run().then((result) {
      result.fold(
        (exception) => fail("initServices failed with exception: $exception"),
        (unit) => expect(unit, isA<Unit>()),
      );
    });
  });
}
