import 'package:tarot_again/util/util.dart';

// import 'events.dart';
import 'provider.dart';

Future<void> initializeStandardDeckProvider() async {
  await StandardDeckProvider.initialize();
}
