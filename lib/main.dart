// import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:toastification/toastification.dart';

import 'ui_layer/ui_layer.dart';
import 'util/register_singletons.dart';
import 'util/util.dart';

void main() async {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      initializeLoggingService();
      Logging.staticVerbose("\n*******\nApp starting\n*******");
      // serviceLocatorConfig();

      registerSingletons();

      ErrorWidget.builder = (FlutterErrorDetails details) {
        // If we're in debug mode, use the normal error widget which shows the error
        // message:
        return ErrorWidget(details.exception);
      };

      // await _initFirebase();
      runApp(TarotAgainApp());
    },
    (Object error, StackTrace stack) {
      sl<Talker>().handle(error, stack, 'Uncaught app exception');
    },
  );
}

class TarotAgainApp extends StatelessWidget {
  const TarotAgainApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: MaterialApp(
        title: 'Tarot Again',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a purple toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: Scaffold(
          body: SafeArea(
            child: Center(
              child: const HomePageWidget(title: 'Flutter Demo Home Page'),
            ),
          ),
        ),
      ),
    );
  }
}
