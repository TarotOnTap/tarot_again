import 'package:tarot_again/util/util.dart';

import 'provider.dart';

Future<void> initializeAssetProvider() async {
  await AssetProvider.initialize();
}
