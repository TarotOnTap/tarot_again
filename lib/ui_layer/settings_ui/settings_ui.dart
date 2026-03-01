import 'package:flutter/material.dart';
import 'package:tarot_again/util/util.dart';

class SettingsUIWidget extends StatelessWidget with Logging {
  const SettingsUIWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsScreen(
      title: "Settings",
      children: [
        SwitchSettingsTile(
          // leading: Icon(Icons.developer_mode),
          settingKey: 'reversalsAllowed',
          title: 'Allow reversals',
          onChange: (value) {
            SignalsManager.reversalsAllowed.value = value;
            debug('reversalsAllow: $value');
          },
        ),
      ],
    );
  }
}
