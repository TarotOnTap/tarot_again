// import 'package:async_extension/async_extension.dart';
import 'package:fpdart/fpdart.dart';
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
///
const String _PERSISTED_VALUE_KEY_ = "value";
const String _PERSISTED_NAME_PREPEND = "__persisted__";

/// This class is a persistent [Signal] using [Hivez](https://pub.dev/packages/hivez)
///
/// It works using async magic to save and restore a value from a single [Hive]
/// [Box] devoted to this one signal; the box has only one key [_PERSISTED_VALUE_KEY_]
/// and holds a value of type \<[Option]\<T?>> ([Option] from [fpdart]).
///
/// Parameters:
/// [persistedName] is the bare name/filename of the [Hive][Box] used to persist this signal
/// [initialValue] is an optional named peramater (passed as initialValue) that will be used
/// if, and only if, a value is not already persisted in the [Box].
/// [options] is [BoxConfig] that could be used if anybody wanted to override the
/// default options for this particular signal. Properably not useful and I may
/// remove it.
class HivezPersistedSignal<T> extends Signal<T> with Logging {
  HivezPersistedSignal._(
    super.internalValue,
    this.persistedName, {
    required super.options,
  }) {
    final BoxConfig boxOptions = BoxConfig(
      persistedName,
      path: ".persistedStorage",
      collection: "persistedStorage",
      logger: hDebug,
    );

    hiveBox = sl<HiveService>().ensureBox<String, T>(
      persistedName,
      options: boxOptions,
    );

    // this runs every time the value of the signal changes - except the first time, when we
    // try to fetch the value from storage if it exists. That logic is handled elsewhere
    effectDisposer = effect(() async {
      if (persistedValueLoaded) {
        hiveBox.onResolve(
          (hb) async => await hb.put(_PERSISTED_VALUE_KEY_, value),
        );
      }
    });
  }

  /// [_persistedValueLoaded] is a write-once variable that indicates whether or not
  /// an attempt was made to load the persisted value. Once the attempt is made,
  /// whether the value existed in the Box or not, this variable is set to true.
  bool _persistedValueLoaded = false;

  bool get persistedValueLoaded => _persistedValueLoaded;

  //
  // /// [persistedName] is the mangle name of the [Hive][Box] used to persist this signal
  final String persistedName;

  /// [hiveBox] stores the future returned by [HiveService.ensureBox]. It needs
  /// to be used by either await hivebox
  /// or [hiveBox.onResolve()] to access the [Box];
  late final Future<BoxInterface<String, T>> hiveBox;

  /// the actual [Effect] in use here simply saves the newly-set value of the
  /// signal to its Box. [effectDisposer] is used to dispose of the effect when
  /// this signal is [close]d, which is not yet implemented
  // TODO: implement a close function that disposes of this effect.
  late final EffectCleanup effectDisposer;

  // Option<T?> _persistedValue = Option<T?>.none();

  /// factory function to create a new persisted signal
  ///
  /// Parameters:
  /// required String [name] - the un-mangled name used to create the [Box] for
  /// this signal.
  /// The optional [startingValue] is of the parameter type provided to the class constructor
  /// The optional [initialValue] is used when the [key] does not exist in the storage [Box] when this signal is created.
  /// The [SignalOptions] [options] parameter is sent, unmodified, to the [Signal] constructor.
  factory HivezPersistedSignal({
    required String name,
    required T initialValue,
  }) {
    final String storageName = _PERSISTED_NAME_PREPEND + name;

    final hps2 = HivezPersistedSignal._(
      initialValue,
      storageName,
      options: SignalOptions<T>(name: storageName),
    );

    hps2.fetchPersistedValue(initialValue).ignore();

    return hps2;
  }

  /// Decides whether or not to use the [initialValue] to set the value of the signal
  ///
  /// Under the hood, this is an async function that *eventually* answers
  /// the question of whether or not a value exists in the [Box] with the [key]
  /// and updates the [Signal] acccordingly.
  ///
  ///
  Future<void> fetchPersistedValue(T initialValue) async {
    /// Hivez [Box] methods are async.
    /// [async_extension](https://pub.dev/packages/async_extension) offers the
    /// onResolve method that will execute the provided function once the
    /// Future resolves, without needing to declare a function async.
    ///
    /// containsKey mimics the [Map.containsKey] method on a [Hive][Box], but asynchronously.

    final hb = await hiveBox;

    // a null value for newValue will indicate that this is a first run for
    // this persisted signal, and that therefore the key and value don't
    // exist in the Box.  Values in the [Box] are not nullable.
    T? newValue = await hb.get(_PERSISTED_VALUE_KEY_);

    // the logic - what to do if we have a new key-value (first run situation)
    if (newValue != null) {
      // don't track the set in this particular instance; if we do, we'll
      // trigger off a loop as the set value.
      // Once _persistedValueLoaded is set, future set operations will go ahead
      // and async put the newValue to the Box.
      set(newValue);
      _persistedValueLoaded = true;
    } else {
      await hb.put(_PERSISTED_VALUE_KEY_, initialValue);
    }
  }
}

HivezPersistedSignal<T> hivezPersistedSignal<T>(String name, T initialValue) =>
    HivezPersistedSignal<T>(name: name, initialValue: initialValue);

/// [HivezPersistedMapSignal] class is a [MapSignal] on top and a
/// regular [Hivez][Box] key-value store underneath.
///

class HivezPersistedMapSignal<K, V> extends MapSignal<K, V?> with Logging {
  HivezPersistedMapSignal._(
    super.internalValue,
    this.persistedName, {
    required super.options,
  }) {
    final BoxConfig boxOptions = BoxConfig(
      persistedName,
      path: ".persistedStorage",
      collection: "persistedStorage",
      logger: hDebug,
    );

    hiveBox = sl<HiveService>().ensureBox<K, V?>(
      persistedName,
      options: boxOptions,
    );

    // this runs every time the value of the signal changes - except the first time, when we
    // try to fetch the value from storage if it exists. That logic is handled elsewhere
    effectDisposer = effect(() async {
      if (persistedValueLoaded) {
        hiveBox.onResolve((hb) async {
          for (var k in value.keys) {
            await hb.put(k, value[k]);
          }
        });
      }
    });
  }

  /// [_persistedValueLoaded] is a write-once variable that indicates whether or not
  /// an attempt was made to load the persisted value. Once the attempt is made,
  /// whether the value existed in the Box or not, this variable is set to true.
  bool _persistedValueLoaded = false;

  bool get persistedValueLoaded => _persistedValueLoaded;

  // late final HiveService hiveService;

  /// [persistedName] is the mangle name of the [Hive][Box] used to persist this signal
  final String persistedName;

  /// [hiveBox] stores the future returned by [HiveService.ensureBox]. It needs
  /// to be used by either await hivebox
  /// or [hiveBox.onResolve()] to access the [Box];
  late final Future<BoxInterface<K, V?>> hiveBox;

  /// the actual [Effect] in use here simply saves the newly-set value of the
  /// signal to its Box. [effectDisposer] is used to dispose of the effect when
  /// this signal is [close]d, which is not yet implemented
  // TODO: implement a close function that disposes of this effect.
  late final EffectCleanup effectDisposer;

  /// factory function to create a new persisted signal
  ///
  /// Parameters:
  /// required String [name] - the un-mangled name used to create the [Box] for
  /// this signal.
  /// The optional [startingValue] is of the parameter type provided to the class constructor
  /// The optional [initialValue] is used when the [key] does not exist in the storage [Box] when this signal is created.
  /// The [SignalOptions] [options] parameter is sent, unmodified, to the [Signal] constructor.
  factory HivezPersistedMapSignal({
    required String name,
    required Map<K, V?> initialValue,
  }) {
    final String storageName = _PERSISTED_NAME_PREPEND + name;

    final hps2 = HivezPersistedMapSignal._(
      initialValue,
      storageName,
      options: MapSignalOptions<K, V>(name: storageName),
    );

    hps2.fetchPersistedValue(initialValue).ignore();

    return hps2;
  }

  @override
  operator []=(K key, V? value) {
    super[key] = value;
    hiveBox.onResolve((hb) async => await hb.put(key, value));
  }

  /// Decides whether or not to use the [initialValue] to set the value of the signal
  ///
  /// Under the hood, this is an async function that *eventually* answers
  /// the question of whether or not a value exists in the [Box] with the [key]
  /// and updates the [Signal] acccordingly.
  ///
  ///
  Future<void> fetchPersistedValue(Map<K, V?> initialValue) async {
    /// Hivez [Box] methods are async.
    /// [async_extension](https://pub.dev/packages/async_extension) offers the
    /// onResolve method that will execute the provided function once the
    /// Future resolves, without needing to declare a function async.
    ///
    /// containsKey mimics the [Map.containsKey] method on a [Hive][Box], but asynchronously.

    final BoxInterface<K, V?> hb = await hiveBox;

    // a null value for newValue will indicate that this is a first run for
    // this persisted signal, and that therefore the key and value don't
    // exist in the Box.  Values in the [Box] are not nullable.
    final keys = await hb.getAllKeys();

    if (keys.isEmpty) {
      _persistedValueLoaded = true;
      value = initialValue;
    } else {
      final newValue = keys.map((k) => hb.get(k));
      final newValues = await Future.wait(newValue);

      value = Map<K, V?>.fromIterables(keys, newValues);
      _persistedValueLoaded = true;
    }
  }
}

HivezPersistedMapSignal<K, V> hivezPersistedMapSignal<K, V>(
  String name,
  Map<K, V> initialValue,
) => HivezPersistedMapSignal<K, V>(name: name, initialValue: initialValue);
