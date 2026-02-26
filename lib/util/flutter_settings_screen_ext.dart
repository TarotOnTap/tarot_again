import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';

extension FlutterSettingsScreenExt on SimpleSettingsTile {
  Widget getIconButton(BuildContext context, Widget icon) {
    return IconButton(
      icon: icon, // const Icon(Icons.navigate_next),
      onPressed: enabled ? () => _handleTap(context) : null,
    );
  }

  void _handleTap(BuildContext context) {
    onTap?.call();

    if (child != null) {
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (BuildContext context) => child!));
    }
  }
}
