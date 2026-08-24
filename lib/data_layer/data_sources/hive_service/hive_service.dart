import 'package:hivez_flutter/hivez_flutter.dart';
import 'package:tarot_again/util/util.dart';

@singleton
class HiveService with Logging {
  late final BoxInterface<String, AssetStorageRep> assetStorageBox;

  late final BoxConfig baseOptions;

  // late final Box<Object, Object?> preferences;

  HiveService() {
    baseOptions = BoxConfig("", logger: hDebug, path: ".hive");
  }

  Future<void> initializeBoxes() async {
    assetStorageBox = await ensureBox<String, AssetStorageRep>(
      "assetStorageRepBox",
      options: baseOptions,
    );
  }

  @FactoryMethod(preResolve: true)
  static Future<HiveService> create() async {
    HiveService newService = HiveService();

    await newService.initializeBoxes();

    return newService;
  }

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
