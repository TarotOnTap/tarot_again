// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
// import 'package:path_provider_android/path_provider_android.dart';
// import 'package:path_provider_windows/path_provider_windows.dart';
// import 'package:platform/platform.dart';
import 'package:tarot_again/main.dart';
import 'package:tarot_again/util/services.dart';
import 'package:tarot_again/util/util.dart' hide test;

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  // get the logging service up and running, so we can use it!
  // final String appName = "testing hive_service";
  // initializeLoggingService();

  // ignore: unused_local_variable
  final getIt = GetIt.instance;

  // get the logging service up and running, so we can use it!
  // WidgetsFlutterBinding.ensureInitialized();

  await InitServices.initServices();

  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const TarotAgainApp());

    // // Verify that our counter starts at 0.
    // expect(find.text('0'), findsOneWidget);
    // expect(find.text('1'), findsNothing);
    //
    // // Tap the '+' icon and trigger a frame.
    // await tester.tap(find.byIcon(Icons.add));
    // await tester.pump();
    //
    // // Verify that our counter has incremented.
    // expect(find.text('0'), findsNothing);
    // expect(find.text('1'), findsOneWidget);
  });
}
