import 'package:tarot_again/util/util.dart';

import 'events.dart';
import 'provider.dart';

class StandardDeckInitializer {
  StandardDeckDataProvider? _provider;
  StandardDeckInitializer() {
    onEvent<InitializeStandardDeck>(onData: _initializeStandardDeck);
  }

  void _initializeStandardDeck(InitializeStandardDeck event) {
    _provider ??= StandardDeckDataProvider();

    eventSend(StandardDeckInitialized(responseTo: event));
  }
}

// this line creates the object that responds to the Initializer event. That's
// all it's for.
StandardDeckInitializer sdi = StandardDeckInitializer();