import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:fpdart/fpdart.dart';

import './util.dart';

export 'package:flutter_settings_screens/flutter_settings_screens.dart';

typedef InitialSettingsType<T> = ({String key, String label, T initialValue});

final List<InitialSettingsType> settings = <InitialSettingsType>[
  (key: 'reversalsAllowed', label: "Reversals Allowed", initialValue: true),
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
