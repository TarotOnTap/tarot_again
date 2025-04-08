import 'data_sources.dart';

Future<void> initializeDataSources() async {
  await initializeAssetProvider();
  await initializeRandomsProvider();
  await initializeStandardDeckProvider();
  await initializeLayoutProvider();
}
