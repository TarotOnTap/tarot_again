import 'package:hivez_flutter/hivez_flutter.dart';
import 'package:tarot_again/util/util.dart';

class HivezPersistedSignal<T> extends AsyncSignal<T?> {
  HivezPersistedSignal._(
    this.key,
    super.value, {
    Box? storageBox,
    super.options,
  }) {
    hivezBox = storageBox ?? sl<HiveService>().preferences;

    if (value is AsyncLoading) {
      fetchInitialValue().ignore();
    }
  }

  factory HivezPersistedSignal(
    Object key, {
    Box? storageBox,
    bool setValueOnCreation = false,
    T? defaultValue,
    SignalOptions<AsyncState<T?>>? options,
  }) {
    AsyncState<T?> dataToSet = setValueOnCreation
        ? AsyncState.data(defaultValue)
        : AsyncState<T?>.loading();

    return HivezPersistedSignal._(
      key,
      dataToSet,
      storageBox: storageBox,
      options: options,
    );
  }

  final Object key;
  late final Box hivezBox;

  Future<void> fetchInitialValue() async {
    T? savedValue = await hivezBox.get(key);

    setValue(savedValue);
  }

  @override
  bool set(AsyncState<T?> val, {bool force = false}) {
    // ignore() says to run the future without this function having to wait for
    // it. This works because the Hivez Box will be eventually consistent with
    // the backing store for this signal.

    if (val is AsyncData) {
      hivezBox.put(key, val.value).ignore();
    }

    return super.set(val, force: force);
  }
}

HivezPersistedSignal<T> hivezPersistedSignal<T>(
  Object key, {
  Box? storageBox,
  bool setValueOnCreation = false,
  T? defaultValue,
  SignalOptions<AsyncState<T?>>? options,
}) => HivezPersistedSignal<T>(
  key,
  storageBox: storageBox,
  setValueOnCreation: setValueOnCreation,
  defaultValue: defaultValue,
  options: options,
);
