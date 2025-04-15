import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'blocs/initializer.dart';
import 'data_layer/data_layer.dart';
import 'ui_layer/ui_layer.dart';
import 'util/util.dart';

void main() async {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      // serviceLocatorConfig();

      ErrorWidget.builder = (FlutterErrorDetails details) {
        // If we're in debug mode, use the normal error widget which shows the error
        // message:
        return ErrorWidget(details.exception);
      };

      await initializeEverything();

      // Bloc.observer = const AppBlocObserver();

      // await _initFirebase();
      runApp(TarotAgainApp());
    },
    (Object error, StackTrace stack) {
      sl<Talker>().handle(error, stack, 'Uncaught app exception');
    },
  );
}

Future<void> initializeEverything() async {
  initializeLoggingService();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory:
        kIsWeb
            ? HydratedStorageDirectory.web
            : HydratedStorageDirectory((await getTemporaryDirectory()).path),
  );

  initializeDataLayer();
  initializeBlocs();
}

class TarotAgainApp extends StatelessWidget {
  const TarotAgainApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      home: const HomePageWidget(title: 'Flutter Demo Home Page'),
    );
  }
}
