// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: implementation_imports

export 'package:material_ui/material_ui.dart';
export 'package:flutter_it/flutter_it.dart';
export 'package:flutter/services.dart';
export 'package:flutter/widgets.dart';
export 'package:flutter/widget_previews.dart';

import 'dart:ui' show VoidCallback;

import 'package:flutter/src/widgets/_window.dart';

class CallbackWindowControllerDelegate with WindowControllerDelegate {
  CallbackWindowControllerDelegate({required this.onDestroyed});

  @override
  void onWindowDestroyed() {
    onDestroyed();
    super.onWindowDestroyed();
  }

  final VoidCallback onDestroyed;
}
