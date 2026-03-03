import 'package:tarot_again/util/util.dart';

enum StandardTarotDecks {
  rws("RWS Tarot Deck");

  const StandardTarotDecks(this.displayName);

  final String displayName;
}

enum DeckTypesEnum {
  standardTarot("StandardTarot"),
  standardPlayingCards("StandardPlayingCards");

  const DeckTypesEnum(this.displayName);

  final String displayName;
}

enum ShowingFaceEnum {
  back("Back"),
  front("Front");

  const ShowingFaceEnum(this.displayName);

  final String displayName;
}

enum ReversalEnum {
  upright("Upright"),
  reversed("Reversed");

  const ReversalEnum(this.displayName);

  final String displayName;
}

/// A FlutterSignal (as returned by signal, e.g.) that has been adapted to
/// persist its changes to the Settings singleton from the flutter_settings_screens
/// package. This in turn is backed by a key-value store; in this case, it will
/// use SharedPreferences (specifically, SharedPreferencesCache).
/// Note - not using the signals package's PersistedSignal types because those
/// persist their values by converting them to strings in storage. I'd rather
/// use the direct types that SharedPreferences exposes.
class SettingsBackedSignal<T> extends FlutterSignal<T> {
  /// the constructor follows the FlutterSignal design *except* that it adds
  /// a required settingsKey parameter, to name the key that will be used
  /// with settings.
  SettingsBackedSignal(
    super.internalValue, {
    super.autoDispose = false,
    super.debugLabel,
    super.runCallbackOnListen = false,
    required this.settingsKey,
  }) {
    effect(() async {
      // this effect persists whatever value this signal is assigned to the
      // Settings backingStore.  NB - if the type T is not one of the
      // types directly supported by the SharedParameter (int, double, bool,
      // String - then we'd need to add a conversion step in here based on
      // type T.
      // Also note, this effect runs after the signal's value changes.

      // if (plainSettingsTypes.contains(T)) {
      await Settings.setValue<T>(settingsKey, value);
      // } else {
      //   if (T is Serializable) {
      // }
    });
  }

  final String settingsKey;
}

// const plainSettingsTypes = <Type>{int, double, bool, String};

SettingsBackedSignal<T> settingsBackedSignal<T>(
  T value, {
  String? debugLabel,
  bool autoDispose = false,
  bool runCallbackOnListen = false,
  required settingsKey,
}) {
  // if getValue returns null, there is no setting with this key
  // established yet. Note - this shouldn't actually happen, settings are
  // created at first run. However, this just makes it easy to ensure that
  // a signal backed by a setting has the correct value at startup, rather than
  // a non-persisted arbitrary value.
  T? storedValue = Settings.getValue<T>(settingsKey);

  return SettingsBackedSignal<T>(
    storedValue ?? value, // use the stored value, unless there isn't one.
    debugLabel: debugLabel,
    autoDispose: autoDispose,
    runCallbackOnListen: runCallbackOnListen,
    settingsKey: settingsKey,
  );
}
