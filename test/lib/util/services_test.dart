import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
// import 'package:path_provider_android/path_provider_android.dart';
// import 'package:path_provider_windows/path_provider_windows.dart';
// import 'package:platform/platform.dart';
import 'package:tarot_again/util/services.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  // get the logging service up and running, so we can use it!
  // final String appName = "testing hive_service";
  // initializeLoggingService();

  // ignore: unused_local_variable
  final getIt = GetIt.instance;

  // get the logging service up and running, so we can use it!
  // WidgetsFlutterBinding.ensureInitialized();

  test("Test that initServices returns without error", () async {
    await InitServices.initServices();
  });
}
