import 'package:tarot_again/util/util.dart';

import 'register_singletons.config.dart';

final services = GetIt.instance;

@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: true, // default
)
Future<GetIt> configureServices() => services.init();
