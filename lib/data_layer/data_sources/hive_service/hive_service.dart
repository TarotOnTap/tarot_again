import 'package:hivez_flutter/hivez_flutter.dart';
import 'package:tarot_again/util/util.dart';

@singleton
class HiveService with Logging {
  final int junior = 150;

  late final Box<String, AssetStorageRep> assetStorageBox;

  HiveService() {
    verbose('HiveService()');
  }

  Future<void> initializeBoxes() async {
    assetStorageBox = await ensureBox<AssetStorageRep>("assetStorageRepBox");
  }

  @FactoryMethod(preResolve: true)
  static Future<HiveService> create() async {
    Logging.sVerbose('HiveService.create()');
    HiveService retVal = HiveService();
    Logging.sVerbose('  initializing boxes.');

    await retVal.initializeBoxes();

    return retVal;
  }

  Future<Box<String, T>> ensureBox<T>(String boxName) async {
    final Box<String, T> existingBox = Box<String, T>(boxName);
    await existingBox.ensureInitialized();

    return existingBox;
  }
}
