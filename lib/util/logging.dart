import 'package:talker_flutter/talker_flutter.dart';
import 'package:watch_it/watch_it.dart';

mixin Logging {
  // final Talker _log = sl<Talker>();
  /* static */
  void debug(msg) => sl<Talker>().debug("$this:$msg");

  static void staticDebug(msg) => sl<Talker>().debug("static: $msg");

  /* static */
  void error(msg) => sl<Talker>().error("$this:$msg");

  static void staticError(msg) => sl<Talker>().debug("static: $msg");

  /* static */
  void verbose(msg) => sl<Talker>().verbose("$this:$msg");

  static void staticVerbose(msg) => sl<Talker>().verbose("static: $msg");

  /* static */
  void warning(msg) => sl<Talker>().warning("$this:$msg");

  static void staticWarning(msg) => sl<Talker>().warning("static: $msg");
}

class GoodLog extends TalkerLog {
  GoodLog(String super.message);

  /// Log title
  @override
  String get title => 'good';

  /// Log key
  @override
  String get key => getKey;

  /// Log color
  @override
  AnsiPen get pen => getPen;

  static get getPen => AnsiPen()..xterm(121);

  static get getKey => 'good';
}

Talker _talkerInit() => TalkerFlutter.init(
  settings: TalkerSettings(
    colors: {
      TalkerLogType.verbose.key: AnsiPen()..yellow(),
      GoodLog.getKey: GoodLog.getPen,
    },
  ),
);

void initializeLoggingService() {
  if (!di.isRegistered<Talker>()) {
    di.registerSingleton<Talker>(_talkerInit());
  }
}
