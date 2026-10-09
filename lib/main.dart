// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: implementation_imports
//

import 'dart:ui';

import 'package:toastification/toastification.dart';

import 'package:flutter/src/widgets/_window.dart';

import 'package:flutter_quill/flutter_quill.dart';

import 'ui_layer/top_level_layout/toplevel_layout.dart';
import 'util/flutter_util.dart';
import 'util/util.dart';
import 'util/services.dart';

void main(List<String> args) async {
  /// Initialize [GetIt] by acessing its singleton instance
  // ignore: unused_local_variable
  // final getIt = GetIt.instance;

  // // get the logging service up and running, so we can use it!
  // WidgetsFlutterBinding.ensureInitialized();

  await InitServices.initializeMain().run();

  // ErrorWidget.builder = (FlutterErrorDetails details) {
  //   // If we're in debug mode, use the normal error widget which shows the error
  //   // message:
  //   return ErrorWidget(details.exception);
  // };

  runApp(MultiWindowApp());

  // runApp(TarotAgainApp());
}

class MainControllerWindowDelegate with WindowControllerDelegate {
  @override
  void onWindowDestroyed() {
    super.onWindowDestroyed();
    ServicesBinding.instance.exitApplication(AppExitType.required);
  }
}

class MultiWindowApp extends StatelessWidget {
  const MultiWindowApp({super.key});

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tarot Again',
      home: TopLevelLayout(),
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
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        // GlobalCupertinoLocalizations.delegate,
        // GlobalWidgetsLocalizations.delegate,
        FlutterQuillLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en', 'US')],
    );
  }
}
