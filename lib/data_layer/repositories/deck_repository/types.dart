import 'package:tarot_again/data_layer/data_layer.dart';
import 'package:tarot_again/util/util.dart';

export 'repository.dart' show DeckRepository;
export 'asset_card.dart' show AssetPathsCard;
// export 'asset_card.dart' show AssetCard, LoadedAssetMap;

@immutable
class DealtCard extends Equatable {
  final AssetPathsCard card;
  final LoadedAssetsMap assets;

  final bool reversed;

  const DealtCard({
    required this.card,
    required this.assets,
    required this.reversed,
  });

  @override
  List<Object> get props => [card, assets, reversed];
}
