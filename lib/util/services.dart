import 'package:flutter/material.dart';
import 'package:hivez_flutter/hivez_flutter.dart';
import 'package:tarot_again/hive/hive_adapters.dart';
import 'package:tarot_again/hive/hive_registrar.g.dart';
import 'package:tarot_again/util/register_singletons.dart';
import 'package:tarot_again/util/util.dart';

/// its included file.  The included file is automatically update, need to run
/// build_runner to make it work.
///
/// The application's runtime name [appName] is used to initialize
/// Hive storage. If the app's name changes, any storage that existed will
/// be lost and new storage created.
///
/// The [test] parameter indicates whether this is being run in a test
/// environment or not.
Future<void> initServices({required String appName, bool test = false}) async {
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
  await Hive.initFlutter(appName);
  Hive.registerAdapters();
  Hive.registerAdapter<IList>(IListAdapter());

  /// [configureServices()] loads all of our defined services into GetIt in the
  /// correct order to initialize them.
  await configureServices();
}
