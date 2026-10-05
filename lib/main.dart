// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: implementation_imports
//

import 'dart:ui';

import 'package:toastification/toastification.dart';

import 'package:flutter/src/widgets/_window.dart';

import 'package:flutter_quill/flutter_quill.dart';

import 'ui_layer/top_level_layout/toplevel_layout.dart';
import 'util/flutter_util.dart';
import 'util/services.dart';

class TarotAgainWindowDelegate with WindowControllerDelegate {
  @override
  void onWindowDestroyed() {
    super.onWindowDestroyed();
    ServicesBinding.instance.exitApplication(AppExitType.required);
  }
}

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

  runWidget(WindowingTarotAgainApp());

  // runApp(TarotAgainApp());
}

Widget windowingTarotAgainAppPreviewWrapper(Widget child) =>
    WindowingTarotAgainApp(child: child);

class const WindowingTarotAgainApp({super.key, final Widget? child})
    extends StatefulWidget {
  @override
  State<WindowingTarotAgainApp> createState() => _WindowingTarotAgainAppState();
}

class _WindowingTarotAgainAppState extends State<WindowingTarotAgainApp> {
  final WindowController controller = WindowController(
    size: const Size(800, 600),
    title: 'Tarot Again app',
    delegate: TarotAgainWindowDelegate(),
  );
  // final WindowSettings settings = RegularWindowSettings();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget? child = widget.child;
    if (child != null) {
      return Window(controller: controller, child: child);
    } else {
      return Window(controller: controller, child: TarotAgainApp());
    }
  }
}

@Preview(name: 'Tarot Again App', wrapper: windowingTarotAgainAppPreviewWrapper)
Widget tarotAgainApp() => TarotAgainApp();

@immutable
class const TarotAgainApp({super.key}) extends StatelessWidget {
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
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          // GlobalCupertinoLocalizations.delegate,
          // GlobalWidgetsLocalizations.delegate,
          FlutterQuillLocalizations.delegate,
        ],
        supportedLocales: const [Locale('en', 'US')],
      ),
    );
  }
}
