import 'package:tarot_again/blocs/blocs.dart';
import 'package:tarot_again/data_layer/data_layer.dart';
import 'package:tarot_again/util/util.dart';

class AssetRepository {
  late final AssetProvider assetProvider;
  late final BulkCardControlBloc bccBloc;

  AssetRepository._() {
    assetProvider = sl<AssetProvider>();
    bccBloc = sl<BulkCardControlBloc>();
  }

  factory AssetRepository() {
    if (!sl.isRegistered<AssetRepository>()) {
      sl.registerSingleton<AssetRepository>(AssetRepository._());
    }

    return sl<AssetRepository>();
  }
}
