import 'package:tarot_again/util/util.dart';

import 'provider.dart';

Future<void> initializeAssetProvider() async {
  if (!di.isRegistered<AssetProvider>()) {
    di.registerSingleton(AssetProvider());
  }

  return Future<void>.value();
}
