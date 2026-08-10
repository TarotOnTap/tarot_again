import 'package:hivez_flutter/hivez_flutter.dart';
import 'package:tarot_again/util/util.dart';

@singleton
class HiveService with Logging {
  final int junior = 150;

  late final Box<String, AssetStorageRep> assetStorageBox;
  late final Box<Object, Object?> preferences;

  HiveService() {
    verbose('HiveService()');
  }

  Future<void> initializeBoxes() async {
    verbose('HiveService.initializeBoxes()');
    verbose('  assetStorageRep');
    assetStorageBox = await ensureBox<AssetStorageRep>("assetStorageRepBox");

    verbose('  preferences');
    preferences = await ensureBox<Object?>('preferences');
  }

  @FactoryMethod(preResolve: true)
  static Future<HiveService> create() async {
    Logging.sVerbose('HiveService.create()');
    Logging.sVerbose('  calling HiveService()');
    HiveService retVal = HiveService();

    Logging.sVerbose('  initializing boxes.');
    await retVal.initializeBoxes();

    /// this should happen if we're testing
    Logging.sVerbose('  making sure HiveService is registered in GetIt');
    if (!sl.isRegistered<HiveService>()) {
      Logging.sVerbose(
        '  HiveService is not registered in GetIt; registering hiveService',
      );
      sl.registerSingleton<HiveService>(retVal);

      Logging.sVerbose(
        '  HiveService registered in GetIt: ${sl.isRegistered<HiveService>()}',
      );
    }

    return retVal;
  }

  Future<Box<String, T>> ensureBox<T>(String boxName) async {
    final Box<String, T> existingBox = Box<String, T>(boxName, logger: hDebug);
    await existingBox.ensureInitialized();

    return existingBox;
  }
}
