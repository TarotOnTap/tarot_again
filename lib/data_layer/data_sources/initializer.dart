import 'data_sources.dart';

Future<void> initializeDataSources() async {
  await initializeRandomsProvider();
  await initializeStandardDeckProvider();
}
