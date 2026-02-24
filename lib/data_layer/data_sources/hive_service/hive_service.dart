import 'package:tarot_again/util/util.dart';

@singleton
class HiveService with Logging {
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
}
