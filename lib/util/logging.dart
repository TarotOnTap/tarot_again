import 'package:watch_it/watch_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

mixin Logging {
  final Talker _log = di<Talker>();

  void debug(msg) => _log.debug("$runtimeType: $msg");

  void error(msg) => _log.error("$runtimeType: $msg");

  void verbose(msg) => _log.verbose("$runtimeType: $msg");

  void warning(msg) => _log.warning("$runtimeType: $msg");
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
