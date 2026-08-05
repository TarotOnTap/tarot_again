import 'package:fpdart/fpdart.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:tarot_again/util/util.dart';

enum LoggingLevels { debug, verbose, warning, error }

typedef ET<T> = Either<Object, T>;

class BufferedLog {
  final StringBuffer _logger = StringBuffer();
  final LoggingLevels _level;
  final bool autoFlush;

  BufferedLog(this._level, {this.autoFlush = false});

  BufferedLog add(Object msg) {
    _logger.write("$runtimeType:$msg");

    if (autoFlush) {
      commit();
    }

    return this;
  }

  /// tryAdd uses fpdart's Either class to attempt to run a function and print
  /// a message. The function returns a record of itself and the Either result of
  /// running the function. If the function does not throw an error, the message
  /// is printed.
  /// It is not possible to have the printed message reflect the value returned
  /// by the function at this time.
  (BufferedLog, Either<Object, T>) tryAdd<T>(T Function() runThis, Object msg) {
    final either = ET<T>.tryCatch(runThis, (Object o, StackTrace s) => o);

    either.fold(
      (Object o) => addln("  tryAdd's function raised error $o"),
      (T value) => add(msg),
    );

    return (this, either);
  }

  /// tryAdd uses fpdart's Either class to attempt to run a function and print
  /// a message. The function returns a record of itself and the Either result of
  /// running the function. If the function does not throw an error, the message
  /// is printed.
  /// It is not possible to have the printed message reflect the value returned
  /// by the function at this time.
  (BufferedLog, Either<Object, T>) tryAddln<T>(
    T Function() runThis,
    Object msg,
  ) {
    final either = ET<T>.tryCatch(runThis, (Object o, StackTrace s) => o);

    either.fold(
      (Object o) => addln("  tryAddln's function raised error $o"),
      (T value) => addln(msg),
    );

    return (this, either);
  }

  BufferedLog addln(Object msg) {
    _logger.writeln(msg);

    if (autoFlush) {
      commit();
    }

    return this;
  }

  BufferedLog commit() {
    final talker = sl<Talker>();

    switch (_level) {
      case LoggingLevels.verbose:
        talker.verbose(_logger.toString());
      case LoggingLevels.debug:
        talker.debug(_logger.toString());
      case LoggingLevels.warning:
        talker.warning(_logger.toString());
      case LoggingLevels.error:
        talker.error(_logger.toString());
    }

    _logger.clear();

    return this;
  }
}

mixin Logging {
  // final Talker _log = sl<Talker>();
  /* static */

  void debug(Object msg) => sl<Talker>().debug("$this:$msg");

  void hDebug(String msg) => sl<Talker>().debug("hiviz debug: $this:$msg");

  BufferedLog bDebug(Object msg, {autoFlush = false}) =>
      BufferedLog(LoggingLevels.debug, autoFlush: autoFlush);

  static void sDebug(Object msg) => sl<Talker>().debug("static: $msg");

  void error(Object msg) => sl<Talker>().error("$this:$msg");

  BufferedLog bError(Object msg, {autoFlush = false}) =>
      BufferedLog(LoggingLevels.error, autoFlush: autoFlush);

  static void sError(Object msg) => sl<Talker>().debug("static: $msg");

  /* static */
  T verbose<T>(Object msg, {T Function()? runIt, Object? afterMessage}) {
    final talker = sl<Talker>();

    runIt ??= () {} as T Function();

    talker.verbose("$runtimeType:$msg");

    final T retval = runIt();

    if (afterMessage != null) {
      talker.verbose("  $afterMessage");
    }

    return retval;
  }

  FutureOr<T> verboseWrap<T>(
    String preMsg, {
    required FutureOr<T> Function() runIt,
    String Function(FutureOr<T>)? postMsg,
  }) {
    verbose(preMsg);

    FutureOr<T> tmp = runIt();

    if (postMsg != null) {
      switch (tmp) {
        case Future t:
          t.then((value) => postMsg(value));
        case T t:
          postMsg(t);
      }
    }

    return tmp;
  }

  BufferedLog bVerbose(Object msg, {bool autoFlush = false}) =>
      BufferedLog(LoggingLevels.verbose, autoFlush: autoFlush);

  static void sVerbose(Object msg) => sl<Talker>().verbose("static: $msg");

  /* static */
  void warning(Object msg) => sl<Talker>().warning("$this:$msg");

  BufferedLog bWarning(Object msg, {autoFlush = false}) =>
      BufferedLog(LoggingLevels.warning, autoFlush: autoFlush);

  static void sWarning(Object msg) => sl<Talker>().warning("static: $msg");
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

  static AnsiPen get getPen => AnsiPen()..xterm(121);

  static String get getKey => 'good';
}

Talker _talkerInit() => TalkerFlutter.init(
  settings: TalkerSettings(
    colors: {
      TalkerKey.verbose: AnsiPen()..yellow(),
      GoodLog.getKey: GoodLog.getPen,
    },
  ),
);

void initializeLoggingService() {
  if (!sl.isRegistered<Talker>()) {
    sl.registerSingleton<Talker>(_talkerInit());
  }
}
