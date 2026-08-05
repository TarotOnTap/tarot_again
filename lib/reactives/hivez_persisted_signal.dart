import 'package:async_extension/async_extension.dart';
// import 'package:fpdart/fpdart.dart';
import 'package:hivez_flutter/hivez_flutter.dart';
import 'package:tarot_again/util/util.dart';

/// A persistent [Signal] using [Hivez](https://pub.dev/packages/hivez)
///
/// A peristent signal is a signal that, when created, retrieves a value from
/// a Hivez [Box] if one exists and sets the value of the signal to the persisted
/// value, asynchronously by using a Signals [effect]. If the persisted value does not exist, the signal will be set to the
/// [initialValue] and an entry in the [Box] will be created with that value.
/// If neither value nor initialValue is provided, the signal will be set to null
/// and not persisted when the persistent signal is created.
///
/// Use the factory constructor to create a new persisted signal.
///
///

class HivezPersistedSignal<T> extends Signal<T?> {
  HivezPersistedSignal._(
    this.key,
    super.value, {
    Box? storageBox,
    T? initialValue,
    super.options,
  }) {
    hiveBox = storageBox ?? sl<HiveService>().preferences;
    effectDisposer = effect(() async {
      await hiveBox.put(key, value);
    });
  }

  final Object key;
  late final Box hiveBox;
  late final void Function() effectDisposer;

  /// factory function to create a new persisted signal
  ///
  /// required Object [key] - any non-null value can be used as a key in the [Box]
  /// The optional [startingValue] is of the parameter type provided to the class constructor
  /// The optional [storageBox] is a Hivez [Box]. If not provided, the default
  /// [Box] to use is the HivezService's [preferences] [Box].
  /// The optional [initialValue] is used when the [key] does not exist in the storage [Box] when this signal is created.
  /// The [SignalOptions] [options] parameter is sent, unmodified, to the [Signal] constructor.
  factory HivezPersistedSignal({
    required Object key,
    T? startingValue,
    Box<Object, T?>? storageBox,
    T? initialValue,
    SignalOptions<T?>? options,
  }) {
    final HivezPersistedSignal<T> hps2 = HivezPersistedSignal<T>._(
      key,
      startingValue,
      storageBox: storageBox,
      initialValue: initialValue,
      options: options,
    );

    hps2.fetchPersistedValue(initialValue);

    return hps2;
  }

  /// Decides whether or not to use the [initialValue] to set the value of the signal
  ///
  /// Under the hood, this is an async function that *eventually* answers
  /// the question of whether or not a value exists in the [Box] with the [key]
  /// and updates the [Signal] acccordingly.
  ///
  ///
  void fetchPersistedValue(T? initialValue) {
    /// Hivez [Box] methods are async.
    /// [async_extension](https://pub.dev/packages/async_extension) offers the
    /// onResolve method that will execute the provided function once the
    /// Future resolves, without needing to declare a function async.
    ///
    /// containsKey mimics the [Map.containsKey] method, but asynchronously.
    ///
    /// We use [containsKey] to check whether the [key] exists or not because
    /// we allow [null] data values.
    hiveBox.containsKey(key).onResolve((bool exists) {
      if (exists) {
        hiveBox.get(key).onResolve((value) {
          untracked(() => set(value));
        });
      } else {
        if (initialValue != null) {
          untracked(() {
            set(initialValue);

            hiveBox.put(key, initialValue).ignore();
          });
        }
      }
    });
  }
}
