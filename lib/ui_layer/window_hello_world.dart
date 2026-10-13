// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: implementation_imports

import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/_window.dart';
import 'package:flutter/widgets.dart';
import 'package:material_ui/material_ui.dart';
import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:flutter_quill/flutter_quill.dart';

import 'package:flutter_localizations/flutter_localizations.dart'
    show GlobalWidgetsLocalizations;

import 'package:tarot_again/util/util.dart';

/// Exits the application when the user closes the window.
class ExitOnCloseDelegate with WindowControllerDelegate {
  @override
  void onWindowCloseRequested(WindowController controller) {
    ServicesBinding.instance.exitApplication(AppExitType.required);
  }
}

void runInSeparateWindow({required Widget child}) {
  WidgetsFlutterBinding.ensureInitialized();

  runWidget(SeparateWindow(child: child));
}

/// Displays a window and owns its [WindowController].
class SeparateWindow extends StatefulWidget {
  const SeparateWindow({super.key, required this.child});

  final Widget child;

  @override
  State<SeparateWindow> createState() => _SeparateWindowState();
}

class _SeparateWindowState extends State<SeparateWindow> with Logging {
  final WindowController _controller = WindowController(
    size: const Size(600, 400),
    title: 'MyApp',
    delegate: ExitOnCloseDelegate(),
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    verbose("_HelloWindowState.build");

    return Window(
      controller: _controller,
      child: MaterialApp(
        builder: (BuildContext context, Widget? child) {
          return MaterialUiCompatibilityBridge(child: child!);
        },
        localizationsDelegates: <LocalizationsDelegate>[
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          FlutterQuillLocalizations.delegate,
        ],
        home: Scaffold(body: widget.child),
      ),
    );
  }
}
