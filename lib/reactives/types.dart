import 'package:tarot_again/util/util.dart';

// import 'package:tarot_again/util/util.dart';

part 'types.freezed.dart';
part 'types.g.dart';

/// In order to make @freezed sealed classes look like enums, do as this class
/// does.  First, declare an empty private constructor.
/// Second, define your factory functions for each subtype.
/// Third, get you fromJson in there - that's the whole point
/// of this shenanigan, to be able to easily searialize these
/// over-engineered enums.
/// Fourth, for each of your subtypes, create a static const member that
/// provides a single, unique instance of that subtype.
/// To use, then, you can reference the enum-like value as
/// StandardTarotDecks.rwsTarotDeck.
/// Having done this, you've made a serializable enum that "just works" like
/// any other freezed/json_serializable class *and* works like an enum.

@freezed
sealed class StandardTarotDecks with _$StandardTarotDecks {
  const StandardTarotDecks._();

  const factory StandardTarotDecks.rws({required String displayName}) =
      RWSTaroDeck;

  factory StandardTarotDecks.fromJson(Map<String, dynamic> json) =>
      _$StandardTarotDecksFromJson(json);

  static const rwsTarotDeck = StandardTarotDecks.rws(
    displayName: "RWS Tarot Deck",
  );
}

@freezed
sealed class DeckTypesEnum with _$DeckTypesEnum {
  const DeckTypesEnum._();

  const factory DeckTypesEnum.standardTarot({
    @Default("StandardTarot") String displayName,
  }) = StandardTarotDeckType;

  const factory DeckTypesEnum.standardPlayingCards({
    @Default("Standard Playing Cards") String displayName,
  }) = StandardPlayingCardsDeckType;

  factory DeckTypesEnum.fromJson(Map<String, dynamic> json) =>
      _$DeckTypesEnumFromJson(json);

  static const standardTarotDeck = DeckTypesEnum.standardTarot();
  static const standardPlayingCardsDeck = DeckTypesEnum.standardPlayingCards();
}

@freezed
sealed class ShowingFaceEnum with _$ShowingFaceEnum {
  const ShowingFaceEnum._();

  const factory ShowingFaceEnum.back({@Default("Back") String displayName}) =
      ShowingFaceEnumBack;

  const factory ShowingFaceEnum.front({@Default("Front") displayName}) =
      ShowingFaceEnumFront;

  static const showingFaceBack = ShowingFaceEnum.back();
  static const showingFaceFront = ShowingFaceEnum.front();

  factory ShowingFaceEnum.fromJson(Map<String, dynamic> json) =>
      _$ShowingFaceEnumFromJson(json);
}

@freezed
sealed class ReversalEnum with _$ReversalEnum {
  const ReversalEnum._();

  const factory ReversalEnum.upright({@Default("Upright") String displayName}) =
      ReversalEnumUpright;

  const factory ReversalEnum.reversed({
    @Default("Reversed") String displayName,
  }) = ReversalEnumReversed;

  factory ReversalEnum.fromJson(Map<String, dynamic> json) =>
      _$ReversalEnumFromJson(json);

  static const reversalUpright = ReversalEnum.upright();
  static const reversalReversed = ReversalEnum.reversed();
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
      // Settings backingStore.  NB - if the type T is note one of the
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
