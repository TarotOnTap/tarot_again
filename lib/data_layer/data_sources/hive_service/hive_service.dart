import 'package:hivez_flutter/hivez_flutter.dart';
import 'package:tarot_again/util/util.dart';

/// This class provides a simplified interface to [Hive], via [Hivez].
///
/// Because this class is a singleton service, it uses the @singleton and
/// @FactoryMethod annotations. Doing so provides a means of ensuring that
/// This, and other services, are initialized in the correct order and then
/// reachable through the [sm<>()] function provided by GetIt.
@singleton
class HiveService with Logging {
  /// Box for storing [AssetStorageRep] instances by key. Need to see if this
  /// is faster than using the [Bundle] load methods.
  late final BoxInterface<String, AssetStorageRep> assetStorageBox;

  /// Storage options for [Hivez]
  late final BoxConfig baseOptions;

  // late final Box<Object, Object?> preferences;

  /// This constructor initializes the BoxConfig options necessary to
  /// create and obtain [Hivez] boxes.
  HiveService() {
    baseOptions = BoxConfig("", logger: hDebug, path: ".hive");
  }

  /// Initializes the box used to store [AssetStorageRep] instances, to maybe
  /// save some time loading assets after the first run.
  // TODO: profile to see if using [Hive] is faster than loading assets using the [Bundle] method.

  Future<void> initializeBoxes() async {
    assetStorageBox = await ensureBox<String, AssetStorageRep>(
      "assetStorageRepBox",
      options: baseOptions,
    );
  }

  /// Initializes this service. The [preResolve] parameter to [@FactoryMethod] indicates that this
  /// Future should be resolved before the next service is created.
  @FactoryMethod(preResolve: true)
  static Future<HiveService> create() async {
    HiveService newService = HiveService();

    await newService.initializeBoxes();

    return newService;
  }

  /// The real meat of this service is [ensureBox]. It will make sure that a box with keys K and
  /// values V is created or opened, as necessary. [boxName] is used as the storage file name by [Hive].
  Future<BoxInterface<K, V>> ensureBox<K, V>(
    String boxName, {
    required BoxConfig options,
  }) async {
    final BoxInterface<K, V> existingBox = options
        .copyWith(name: boxName)
        .createBox<K, V>();

    await existingBox.ensureInitialized();

    return existingBox;
  }
}
