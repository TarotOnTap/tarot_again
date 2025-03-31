import 'package:tarot_again/util/util.dart';

import 'types.dart';

Future<void> initializeRandomsProvider() async {
  if (!di.isRegistered<AsyncRandoms>()) {
    di.registerSingleton<AsyncRandoms>(SecureRandom());
  }
}