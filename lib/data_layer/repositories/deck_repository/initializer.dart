import 'package:tarot_again/data_layer/data_layer.dart';
import 'package:tarot_again/util/util.dart';

Future<void> initializeDeckRepository() async {
  await initializeDataSources();

  if (!sl.isRegistered<DeckRepository>()) {
    sl.registerSingleton<DeckRepository>(DeckRepository(deckName: "RWS"));
  }
}
