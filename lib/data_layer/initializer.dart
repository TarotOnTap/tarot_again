import 'data_layer.dart';

Future<void> initializeDataLayer() async {
  await initializeAssetProvider();
  await initializeDataSources();
  await initializeRepositories();
}
