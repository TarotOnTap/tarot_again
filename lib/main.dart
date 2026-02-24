// import 'package:flutter/material.dart';
import 'package:hivez_flutter/hivez_flutter.dart';
import 'package:platform/platform.dart';
import 'package:toastification/toastification.dart';

import 'hive/hive_registrar.g.dart';
import 'ui_layer/top_level_layout/toplevel_layout.dart';
import 'util/flutter_util.dart';
import 'util/register_singletons.dart';
import 'util/util.dart';

// String? appName;
// String? appDir;

void main(List<String> args) async {
  final lp = LocalPlatform();

  final appExecutable = lp.executable;
  final appName = appExecutable.split('.')[0];

  // make sure the GetIt is initialized before we start putting things in it.
  final getIt = GetIt.instance;

  // get the logging service up and running, so we can use it!
  initializeLoggingService();

  WidgetsFlutterBinding.ensureInitialized();
  Logging.staticVerbose('  WidgetsFlutterBinding.ensureInitialized() ran.');

  // note - cannot use logging at this point, has to be
  // Hive.initFlutter puts all files into the application documents
  // directory, and then the sub-directory provided as the subDir
  // argument to initFlutter.
  Logging.staticVerbose("\n*******\nApp starting\n*******");
  Logging.staticVerbose("App executable is $appExecutable");
  Logging.staticVerbose('appName is $appName');

  // final parser = ArgParser();
  // // final game = TarotGame();
  //
  // parser.addFlag("create-assets", negatable: false);
  // // parser.addOption("generate-layouts");
  // final ArgResults argResults = parser.parse(args);
  // final bool createAssets = argResults["create-assets"];

  // final String? generateLayouts = argResults["generate-layouts"];

  // runZonedGuarded(
  //   () async {
  // Logging.staticVerbose('  in runZonedGuarded');

  // serviceLocatorConfig();

  Logging.staticVerbose('  initializing Hive');

  Hive
    ..initFlutter(appName)
    ..registerAdapters();

  Logging.staticVerbose('  Hive initialized.');

  // Settings is the place to store user preferences that can be
  // changed; e.g. whether tarot cards should be shown with reversals
  // or without.  I've set it up to use Hive as the storage provider.
  // await Settings.init(
  //   cacheProvider: HiveCache(),
  // ); // default settings provider, per platform
  // await firstRunSettings(); // if this is the first run, set up our
  // // default settings.

  // for any settingsBackedSignals, defaults have been set up during
  // firstRunSettings() and the registered signals will pick up whatever
  // value has been stored in Settings.
  await configureServices();
  // await registerSingletons();

  ErrorWidget.builder = (FlutterErrorDetails details) {
    // If we're in debug mode, use the normal error widget which shows the error
    // message:
    return ErrorWidget(details.exception);
  };

  runApp(TarotAgainApp());
  // } // ,
  // (Object error, StackTrace stack) {
  //   sl<Talker>().handle(error, stack, 'Uncaught app exception');
  // },
  // );
}

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
