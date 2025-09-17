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

// /// extension [RangeGen] on [int]
// /// very simple extension, with one method.
// extension RangeGen on int {
//   /// [range] is a generator that produces values from 0 up to the int it's applied to.
//   /// it's useful replacing a for (var i=0; i<someInt; i++) (and that's all its useful for)
//   Iterable<int> range() sync* {
//     for (var i = 0; i < this; i++) {
//       yield i;
//     }
//   }
// }
//
// extension RepeatGen<E> on int {
//   Iterable<E> repeat(E Function(int) block) sync* {
//     for (var i = 0; i < this; i++) {
//       yield block(i);
//     }
//   }
// }
//
// // shamelessly stolen, with gratitude, from quiver.iterable
// Iterable<List<T>> zipIt<T>(Iterable<Iterable<T>> iterables) sync* {
//   if (iterables.isEmpty) return;
//   final iterators = iterables.map((e) => e.iterator).toList(growable: false);
//   while (iterators.every((e) => e.moveNext())) {
//     yield iterators.map((e) => e.current).toList(growable: false);
//   }
// }
//
// abstract class Singleton {
//   /// This constructor does one thing - it registers the newly created instance of this
//   /// type with GetIt.  This has the potential to be messy if the constructor is called
//   /// more than once, so don't.
//   static void selfRegister() {}
// }
