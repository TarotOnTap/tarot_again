import 'package:tarot_again/util/util.dart';

import 'types.dart';

Future<void> initializeRandomsProvider() async {
  await AsyncRandoms.initialize();
}
