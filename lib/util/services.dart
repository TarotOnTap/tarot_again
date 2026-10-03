import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hivez_flutter/hivez_flutter.dart';
import 'package:tarot_again/hive/hive_adapters.dart';
import 'package:tarot_again/hive/hive_registrar.g.dart';
import 'package:tarot_again/util/register_singletons.dart';
import 'package:tarot_again/util/util.dart';
import 'package:tarot_again/util/pubspec.dart';


// import 'package:platform/platform.dart';

/// A class to initialize services in the correct order
///
/// This class uses the generated [Pubspec] class in order to get
/// the application's name across all platforms, which is used to initialize
/// [Hive].
class InitServices with Pubspec {
  /// Initialize services in the correct order.
  ///
  /// returns the TaskEither to be [.run()] at a later time, with an await
  static TaskEither<ExceptionOf<InitServices>, Unit> initServices() {
    // get the logging service up and running, so we can use it!

    final TaskEither<ExceptionOf<InitServices>, Unit> io1 =
        initializeLoggingService().toTaskEither();

    final te1 = io1(
      TaskEither<ExceptionOf<InitServices>, Unit>.tryCatch(
        () => voidToFutureUnit(Hive.initFlutter(Pubspec.name)),
        (e, _) => ExceptionOf<InitServices>(
          message: e,
          invalidState: "Hive.initFlutter failed",
          expectedState: "Hive.initFlutter succeeded",
        ),
      ),
    );

    return te1(Task<GetIt>(configureServices).toTaskEither())
        .map((geddit) => unit)
        .alt(() {
          Hive.registerAdapters();
          Hive.registerAdapter<IList>(IListAdapter());

          return TaskEither<ExceptionOf<InitServices>, Unit>.of(unit);
        });
  }

  /// Provide initialization for main() for both running and testing
  /// this app.
  ///
  /// [test] whether we are running testing
  static TaskEither<ExceptionOf<InitServices>, Unit> initializeMain({
    bool test = false,
  }) {
    /// this initializes [GetIt] for everybody.
    // ignore: unused_local_variable
    final getIt = GetIt.instance;

    if (test) {
      TestWidgetsFlutterBinding.ensureInitialized();
    } else {
      WidgetsFlutterBinding.ensureInitialized();
    }

    return initServices().alt(() {
      ErrorWidget.builder = (FlutterErrorDetails details) {
        // If we're in debug mode, use the normal error widget which shows the error
        // message:
        return ErrorWidget(details.exception);
      };

      return TaskEither<ExceptionOf<InitServices>, Unit>.of(unit);
    });
  }
}
