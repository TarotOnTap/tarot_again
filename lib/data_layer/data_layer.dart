import 'package:tarot_again/data_layer/repositories/initializer.dart' show initializeRepositories;

export 'data_sources/data_sources.dart';
export 'repositories/repositories.dart';

Future<void> initializeDataLayer() async {
  // await initializeDataSources();
  await initializeRepositories();
}