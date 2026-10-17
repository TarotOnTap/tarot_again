// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: implementation_imports
//
import 'dart:ui';

import 'package:flutter/src/widgets/_window.dart';
import 'package:flutter/services.dart';

import 'package:material_ui/material_ui.dart';
import 'package:cupertino_ui/cupertino_ui.dart';

import 'package:flutter_quill/flutter_quill.dart';

import 'package:flutter_localizations/flutter_localizations.dart'
    show GlobalWidgetsLocalizations;

import 'ui_layer/top_level_layout/toplevel_layout.dart';

import 'util/util.dart';
import 'util/services.dart';

// import 'util/make_window.dart';

// import 'package:rust/rust.dart' show Result, Option;
// import 'package:anyhow/anyhow.dart';

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

  runApp(
    MaterialApp(
      builder: (BuildContext context, Widget? child) {
        return MaterialUiCompatibilityBridge(child: child!);
      },
      localizationsDelegates: <LocalizationsDelegate>[
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        FlutterQuillLocalizations.delegate,
      ],
      home: TopLevelLayout(),
    ),
  );

  // runInSeparateWindow(
  //   windowTitle: "Tarot Again",
  //   exitOnClose: true,
  //   child: TopLevelLayout(),
  // );
}

class MainControllerWindowDelegate with WindowControllerDelegate {
  @override
  void onWindowDestroyed() {
    super.onWindowDestroyed();
    ServicesBinding.instance.exitApplication(AppExitType.required);
  }
}

class MultiWindowApp extends StatefulWidget {
  const MultiWindowApp({super.key});

  @override
  State<MultiWindowApp> createState() => _MultiWindowAppState();
}

class _MultiWindowAppState extends State<MultiWindowApp> {
  final WindowController controller = WindowController(
    size: const Size(800, 600),
    title: 'Tarot Again',
    delegate: MainControllerWindowDelegate(),
  );

  @override
  void initState() {
    super.initState();

    sl.registerSingleton<WindowController>(
      controller,
      instanceName: "mainWindowController",
    );
  }
  // final WindowSettings settings = WindowSettings();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WindowManager(
      initialWindows: [
        WindowEntry(
          controller: controller,
          builder: (context) => MaterialApp(
            builder: (BuildContext context, Widget? child) {
              return MaterialUiCompatibilityBridge(child: child!);
            },
            home: TopLevelLayout(),
          ),
        ),
      ],
    );
  }
}
