// import 'package:flutter/material.dart';
import 'package:args/args.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:tarot_again/hive/hive_registrar.g.dart';
import 'package:toastification/toastification.dart';

import 'ui_layer/top_level_layout/toplevel_layout.dart';
import 'util/app_settings.dart';
import 'util/flutter_util.dart';
import 'util/hive_settings.dart';
import 'util/register_singletons.dart';
import 'util/util.dart';

// Future<void> _generateLayouts(String? generateLayouts) async {
//   if (generateLayouts != null) {
//     final layoutString = await sl<LayoutManager>().generateLayouts();
//     Logging.staticVerbose(" generated layout: layout string is\n$layoutString");
//
//     File outputFile;
//     RandomAccessFile? realFile;
//
//     try {
//       Logging.staticVerbose(
//         "  creating File object for  file $generateLayouts",
//       );
//       outputFile = File(generateLayouts);
//     } catch (e, _) {
//       Logging.staticError(
//         "  error creating File object for  file $generateLayouts, error is $e",
//       );
//       return;
//     }
//
//     File createdFile;
//     try {
//       Logging.staticVerbose("  creating file $generateLayouts");
//       createdFile = await outputFile.create(exclusive: false, recursive: true);
//     } catch (e, _) {
//       Logging.staticError(
//         "  error creating file $generateLayouts, error is $e",
//       );
//       return;
//     }
//
//     try {
//       Logging.staticVerbose("  opening file in createdFile");
//       realFile = await createdFile.open(mode: FileMode.write);
//     } catch (e, _) {
//       Logging.staticError(
//         "  error opening file $generateLayouts in mode FileMode.write, error is $e",
//       );
//       return;
//     }
//
//     try {
//       Logging.staticVerbose("  writing layoutString to realFile");
//       realFile.writeString(layoutString);
//     } catch (e, _) {
//       Logging.staticError(
//         "  error writing layoutString to file $generateLayouts, error is $e",
//       );
//     }
//
//     try {
//       Logging.staticVerbose("  closing realFile");
//       realFile.close();
//     } catch (e, _) {
//       Logging.staticError("  error closing realFile, error is $e");
//     }
//
//     Logging.staticVerbose("_generateLayouts exiting.");
//
//     // try {
//     //   outputFile = await File(
//     //     generateLayouts,
//     //   ).create(exclusive: false, recursive: true);
//     //   realFile = await outputFile.open(mode: FileMode.write);
//     //
//     //   await outputFile.writeAsString(layoutString, flush: true);
//     // } catch (e, _) {
//     //   Logging.staticError(
//     //     "  error writing to file $generateLayouts, error is $e",
//     //   );
//     // } finally {
//     //   realFile?.close();
//     //   // no finally currently; the file is only open during the write operation
//     //   // and then self-closes(?)
//     // }
//   }
// }

void main(List<String> args) async {
  final parser = ArgParser();
  // final game = TarotGame();

  parser.addFlag("create-assets", negatable: false);
  // parser.addOption("generate-layouts");
  final ArgResults argResults = parser.parse(args);
  final bool createAssets = argResults["create-assets"];
  // final String? generateLayouts = argResults["generate-layouts"];

  if (createAssets) {
  } else {
    runZonedGuarded(
      () async {
        WidgetsFlutterBinding.ensureInitialized();
        initializeLoggingService();
        Logging.staticVerbose("\n*******\nApp starting\n*******");
        // serviceLocatorConfig();
        Logging.staticVerbose("main arguments are $args");

        Hive
          ..initFlutter()
          ..registerAdapters();

        await Settings.init(
          cacheProvider: HiveCache(),
        ); // default settings provider, per platform
        await firstRunSettings(); // if this is the first run, set up our
        // default settings.

        // for any settingsBackedSignals, defaults have been set up during
        // firstRunSettings() and the registered signals will pick up whatever
        // value has been stored in Settings.
        await registerSingletons();

        ErrorWidget.builder = (FlutterErrorDetails details) {
          // If we're in debug mode, use the normal error widget which shows the error
          // message:
          return ErrorWidget(details.exception);
        };

        // TODO: init sqlite db, using device's per-user storage. Make sure to include migration!
        // await _initFirebase();
        // runApp(GameWidget(game: TarotGame()));
        runApp(TarotAgainApp());
      },
      (Object error, StackTrace stack) {
        sl<Talker>().handle(error, stack, 'Uncaught app exception');
      },
    );
  }
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
