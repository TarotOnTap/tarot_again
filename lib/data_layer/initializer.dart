import 'data_layer.dart';


Future<void> initializeDataLayer() async {
  await initializeDataSources();
  await initializeRepositories();
}