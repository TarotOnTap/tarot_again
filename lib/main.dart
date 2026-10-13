// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: implementation_imports
//

import 'dart:ui';

import 'package:toastification/toastification.dart';

import 'package:flutter/src/widgets/_window.dart';

// import 'package:material_ui/material_ui.dart' show GlobalMaterialLocalizations;
import 'package:cupertino_ui/cupertino_ui.dart'
    show GlobalCupertinoLocalizations;

import 'package:flutter_localizations/flutter_localizations.dart'
    show GlobalWidgetsLocalizations;

import 'package:flutter_quill/flutter_quill.dart';

// import 'package:fpdart/fpdart.dart' show Either;

import 'ui_layer/top_level_layout/toplevel_layout.dart';
import 'ui_layer/top_level_layout/window_settings_accessor.dart';
import 'util/flutter_util.dart';
import 'util/util.dart';
import 'util/services.dart';

// import 'package:rust/rust.dart' show Result, Option;
import 'package:anyhow/anyhow.dart';

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

class MultiWindowApp extends StatefulWidget {
  const MultiWindowApp({super.key});

  @override
  State<MultiWindowApp> createState() => _MultiWindowAppState();
}

class _MultiWindowAppState extends State<MultiWindowApp> with Logging {
  final WindowController controller = WindowController(
    size: const Size(800, 600),
    title: 'Tarot Again',
    delegate: MainControllerWindowDelegate(),
  );

  final WindowSettings settings = WindowSettings();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget _makeMaterialApp({required Widget child}) {
    final String title = 'Tarot Again';

    Result<ThemeData> themeData = guard(
      () => ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
        brightness: Brightness.light,
      ),
    ).context("_makeMaterialApp: attempting to create ThemeData");

    final tdMap = themeData
        .map(
          (td) => guard(
            () => MaterialApp(
              builder: (BuildContext context, Widget? child) {
                return MaterialUiCompatibilityBridge(child: child!);
              },
              title: title,
              home: child,
              theme: td,
              localizationsDelegates: [
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                FlutterQuillLocalizations.delegate,
              ],
              supportedLocales: [Locale('en', 'US')],
            ),
          ).context("_makeMaterialApp: attempting to create MaterialApp"),
        )
        .flatten();

    return switch (tdMap) {
      Ok(v: var okay) => okay,
      Err(v: var error) => Placeholder(child: Text("Error: $error")),
    };
  }

  Result<Widget> _makeToastWrapper(BuildContext context) {
    return guard(
      () => ToastificationWrapper(
        child: _makeMaterialApp(
          child: TopLevelLayout(windowController: controller),
        ),
      ),
    );
  }

  WindowEntry _makeMainWindowEntry(BuildContext context) => WindowEntry(
    controller: controller,
    builder: (context) =>
        _makeToastWrapper(context)
            .context("_makeMainWindowEntry: builder anonymous function")
            .unwrap(),
  );

  @override
  Widget build(BuildContext context) {
    final mainWindowEntry = guard(() => _makeMainWindowEntry(context))
        .context("_MultiWindowAppState.build: _makeMainWindowEntry");

    final windowManager = mainWindowEntry
        .map((mwe) => guard(() => WindowManager(initialWindows: [mwe])))
        .flatten()
        .context("_MultiWindowAppState.build: creating windowManager");

    final windowSettingsAccessor = windowManager
        .map(
          (wm) => guard(
            () => WindowSettingsAccessor(windowSettings: settings, child: wm),
          ),
        )
        .flatten()
        .context("_MultiWindowAppState.build: creating WindowSettingsAccessor");

    return switch (windowSettingsAccessor) {
      Ok(v: var okay) => okay,
      Err(v: var error) => Placeholder(
        child: Text("_MultiWindowAppState.build: Error: $error"),
      ),
    };
  }
}
