import 'package:tarot_again/util/util.dart';

// import 'events.dart';
import 'provider.dart';

Future<void> initializeStandardDeckProvider() async {
  if (!di.isRegistered<StandardDeckProvider>()) {
    di.registerSingleton(StandardDeckProvider());
  }

  return Future<void>.value();
}
