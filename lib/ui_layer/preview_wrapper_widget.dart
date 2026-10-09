import 'package:tarot_again/util/util.dart';
import 'package:tarot_again/util/flutter_util.dart';
import 'package:tarot_again/util/services.dart' show InitServices;

import 'package:flutter_quill/flutter_quill.dart';

/// A wrapper widget for Flutter widget previews that initializes GetIt.
///
/// This widget handles GetIt setup in initState and cleanup via reset()
/// in dispose, making it perfect for preview scenarios where widgets are
/// rendered in isolation.
///
/// return const MaterialApp(
///
Widget servicesPreviewWrapper(Widget child) =>
    ServicesPreviewWrapper(child: child);

class ServicesPreviewWrapper extends StatefulWidget {
  const ServicesPreviewWrapper({
    super.key,
    // required this.init,
    required this.child,
  });

  /// The child widget to render after services are initialized
  final Widget child;

  /// Initialization function that registers dependencies in GetIt
  // final void Function(GetIt getIt) init;

  @override
  State<ServicesPreviewWrapper> createState() => _ServicesPreviewWrapperState();
}

class _ServicesPreviewWrapperState extends State<ServicesPreviewWrapper> {
  @override
  void initState() {
    super.initState();
    // Initialize GetIt with preview dependencies
    // widget.init(GetIt.instance);
  }

  @override
  void dispose() {
    // Clean up all GetIt registrations when preview is disposed
    GetIt.instance.reset();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: InitServices.initializeMain().run(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            home: Scaffold(body: widget.child),

            title: 'Tarot Again',
            theme: ThemeData(
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
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
