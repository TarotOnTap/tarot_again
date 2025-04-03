import 'package:tarot_again/data_layer/data_layer.dart';

Future<void> initializeRepositories() async {
  await initializeDataSources();

  await initializeDeckRepository();
}
