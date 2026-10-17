// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: implementation_imports

import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/_window.dart';

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

void runInSeparateWindow({
  bool exitOnClose = false,
  required String windowTitle,
  required Widget child,
}) {
  WidgetsFlutterBinding.ensureInitialized();

  runWidget(
    SeparateWindow(
      windowTitle: windowTitle,
      exitOnClose: exitOnClose,
      child: child,
    ),
  );
}

/// Displays a window and owns its [WindowController].
class SeparateWindow extends StatefulWidget {
  const SeparateWindow({
    super.key,
    required this.windowTitle,
    required this.exitOnClose,
    required this.child,
  });

  final bool exitOnClose;
  final String windowTitle;
  final Widget child;

  @override
  State<SeparateWindow> createState() => _SeparateWindowState();
}

class _SeparateWindowState extends State<SeparateWindow> with Logging {
  late final WindowController _controller;

  @override
  void initState() {
    super.initState();

    _controller = WindowController(
      size: const Size(800, 800),
      title: widget.windowTitle,
      delegate: widget.exitOnClose ? ExitOnCloseDelegate() : null,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    verbose("_SeparateWindowState.build");

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
