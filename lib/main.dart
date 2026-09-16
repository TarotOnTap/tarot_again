// import 'package:flutter/material.dart';
import 'package:platform/platform.dart';
import 'package:toastification/toastification.dart';

import 'ui_layer/top_level_layout/toplevel_layout.dart';
import 'util/flutter_util.dart';
import 'util/services.dart';
import 'util/util.dart';

void main(List<String> args) async {
  /// Initialize [GetIt] by acessing its singleton instance
  final getIt = GetIt.instance;

  // get the logging service up and running, so we can use it!
  WidgetsFlutterBinding.ensureInitialized();

  await InitServices.initServices();

  ErrorWidget.builder = (FlutterErrorDetails details) {
    // If we're in debug mode, use the normal error widget which shows the error
    // message:
    return ErrorWidget(details.exception);
  };

  runApp(TarotAgainApp());
}

class OuterApp with PubSpec {}

@immutable
class TarotAgainApp extends StatelessWidget {
  const TarotAgainApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: MaterialApp(
        initialRoute: "/",
        routes: <String, WidgetBuilder>{
          '/': (BuildContext context) => const TopLevelLayout(),
        },
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
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
          brightness: Brightness.light,
        ),
      ),
    );
  }
}
