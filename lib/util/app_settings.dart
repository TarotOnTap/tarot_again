import 'package:fpdart/fpdart.dart';

import './util.dart';

export 'package:flutter_settings_screens/flutter_settings_screens.dart';

// Settings are created in this module the first time the app runs; more
// specifically, if the setting doesn't already exist in SharedPreferences,
// on a setting by setting basis.

// firstRunSettings runs *before* the signals in reactives/signals_manager.dart
// are created; this allows the persisted settings to override whatever
// default value is used at signal creation. The SettingsBackedSignal class
// and settingsBackedSignal() function handle the mechanics of that, so we
// don't have to fuss about those details here.

const ISet<Type> baseSettings = ISetConst({int, double, bool, String});

typedef InitialSettingsType<T> = ({String key, String label, T initialValue});

final List<InitialSettingsType> settings = <InitialSettingsType>[
  (key: 'reversalsAllowed', label: "Reversals Allowed", initialValue: true),
  (key: 'currentDeck', label: "Current Deck", initialValue: 'RWS'),
];

Future<Unit> firstRunSettings() async {
  Logging.staticVerbose("firstRunSettings");

  for (var setting in settings) {
    if (!(Settings.containsKey(setting.key) ?? false)) {
      await Settings.setValue(setting.key, setting.initialValue);
    }
  }

  return unit;
}

Future<Unit> resetSettings() async {
  Settings.clearCache();

  return firstRunSettings(); // which returns a Future<Unit> value.
}
