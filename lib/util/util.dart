import 'package:tarot_again/data_layer/data_layer.dart';
import 'package:watch_it/watch_it.dart';

export 'dart:async' hide AsyncError;
export 'dart:developer';

export 'package:async/async.dart';
export 'package:change_case/change_case.dart';
export 'package:collection/collection.dart';
export 'package:dart_scope_functions/dart_scope_functions.dart';
export 'package:equatable/equatable.dart';
export 'package:fast_immutable_collections/fast_immutable_collections.dart';
export 'package:flutter/foundation.dart' hide binarySearch, mergeSort;
export 'package:flutter_settings_screens/flutter_settings_screens.dart';
export 'package:freezed_annotation/freezed_annotation.dart';
export 'package:get_it/get_it.dart';
export 'package:go_router/go_router.dart';
export 'package:json_annotation/json_annotation.dart';
export 'package:meta/meta.dart';
export 'package:signals/signals_flutter.dart';
export 'package:tarot_again/data_layer/data_layer.dart';
export 'package:tarot_again/reactives/reactives.dart';
// export 'package:tarot_again/reactives/session_manager.dart';
export 'package:watch_it/watch_it.dart';

export 'logging.dart';
export 'types.dart';

void registerDependencies() {
  sl.registerSingleton<AsyncRandoms>(AsyncRandoms());
}
