import 'package:hivez_flutter/hivez_flutter.dart';
import 'package:tarot_again/util/util.dart';

@singleton
class HiveService with Logging {
  final int junior = 150;

  HiveService() {
    verbose('HiveService()');
  }

  @FactoryMethod(preResolve: true)
  static Future<HiveService> create() async {
    Logging.staticVerbose('HiveService.create()');
    HiveService retVal = HiveService();
    Logging.staticVerbose('  finished. Returning HiveService()');
    // await Hive.initFlutter();
    // Hive.registerAdapters();

    return retVal;
  }

  Future<Box<String, T>> ensureBox<T>(String boxName) async {
    final Box<String, T> existingBox = Box<String, T>(boxName);
    await existingBox.ensureInitialized();

    return existingBox;
  }
}
