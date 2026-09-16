import 'package:flutter/material.dart';
import 'package:hivez_flutter/hivez_flutter.dart';
import 'package:tarot_again/hive/hive_adapters.dart';
import 'package:tarot_again/hive/hive_registrar.g.dart';
import 'package:tarot_again/util/register_singletons.dart';
import 'package:tarot_again/util/util.dart';
import 'package:tarot_again/util/pubspec.dart';

/// A class to initialize services in the correct order
///
/// This class uses the generated [Pubspec] class in order to get
/// the application's name across all platforms, which is used to initialize
/// [Hive].
class InitServices with Pubspec {
  static Future<void> initServices({bool test = false}) async {
    // get the logging service up and running, so we can use it!
    initializeLoggingService();

    /// In the
    /// flutter_test environment, the correct ensureInitialized is run
    /// elsewhere; in other environments, we should run it here.
    if (!test) {
      WidgetsFlutterBinding.ensureInitialized();
    }

    /// Initialize Hive storage and make sure all the necessary type adapters
    /// are registered.
    await Hive.initFlutter(Pubspec.name);
    Hive.registerAdapters();
    Hive.registerAdapter<IList>(IListAdapter());

    /// [configureServices()] loads all of our defined services into GetIt in the
    /// correct order to initialize them.
    await configureServices();
  }
}
