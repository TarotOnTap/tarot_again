import 'package:material_ui/material_ui.dart';
import 'package:cupertino_ui/cupertino_ui.dart';

import 'package:flutter_quill/flutter_quill.dart';

import 'package:flutter_localizations/flutter_localizations.dart'
    show GlobalWidgetsLocalizations;

import 'ui_layer/ui_layer.dart';
import 'util/services.dart';

void main(List<String> args) async {
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
      restorationScopeId: "app",

      localizationsDelegates: <LocalizationsDelegate>[
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        FlutterQuillLocalizations.delegate,
      ],
      home: MainScaffold(),
    ),
  );
}
