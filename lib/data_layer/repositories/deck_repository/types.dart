import 'package:tarot_again/data_layer/data_layer.dart';
import 'package:tarot_again/data_layer/repositories/deck_repository/asset_card.dart';
import 'package:tarot_again/util/util.dart';

export 'repository.dart' show DeckRepository;

part 'types.freezed.dart';
part 'types.g.dart';

class DealtModel with Logging {
  final String assetName;
  final AssetPathMap paths;
  late final LoadedAssetsMap assets;

  DealtModel({required this.assetName}) : paths = assetPathGenerator(assetName);

  // void loadAssets() async {
  //   assets = await di<AssetProvider>().loadAssetsByFileExtension(paths);
  // }

  Future<DealtCard> transform({
    required TCModel card,
    required bool isReversed,
  }) async {
    verbose("transform method");
    verbose("  isReversed is $isReversed");

    assets = await sl<AssetProvider>().loadAssetsByFileExtension(paths);

    final DealtCard retVal = DealtCard.deckCard(
      tcCard: card,
      reversed: isReversed,
      imageAssetPath: assets["image"] ?? "",
      description: assets["description"] ?? "",
      uprightMeaning: assets["upright"] ?? "",
      reversedMeaning: assets["reversed"] ?? "",
    );

    verbose("  returning $retVal");

    return retVal;
  }
}

/// DealtCard is a class that represents two possible states of a card that has
/// been dealt by the [DeckRepository]. [DeckEmpty] represents the absence of a
/// card, because the deck has been run dry. We shouldn't get to this state to
/// often, except that it's used before any cards have been dealt, as well.
/// [DeckCard] then represents the state of a card that has been dealt - any
/// assets it might have ([imageAssetPath] an image, [description] a description in Markdown format,
/// [uprightMeaning] a meaning or interpretation for
/// its upright and [reversedMeaning] reversed values, also in Markdown format.
/// Empty strings for these last values indicate the absence of an asset (this should
/// only occur during development).
@freezed
sealed class DealtCard with _$DealtCard {
  /// [deckCard] is the constructor for [DeckCard] subclass
  /// the four [String] parameters are asset paths to an Image (for [imageAssetPath]) or
  /// the contents of a Markdown file. The default value of "" for these assets indicates that the
  /// asset is not present; this should only occur during development.
  factory DealtCard.deckCard({
    required TCModel tcCard,
    required bool reversed,
    @Default("") String imageAssetPath,
    @Default("") String description,
    @Default("") String uprightMeaning,
    @Default("") String reversedMeaning,
  }) = DeckCard;

  factory DealtCard.unassignedCard() = DealtCardUnassignedCard;

  /// the [deckInitial] constructor indicates that a deck has not been set up yet,
  /// and the [DeckInitial] class is an empty default value.
  factory DealtCard.deckInitial() = DeckInitial;

  /// [deckEmpty] is the constructor for the [DeckEmpty] subclass, which that the deck is
  /// empty after all of the cards have been dealt from it.
  factory DealtCard.deckEmpty() = DeckEmpty;

  factory DealtCard.fromJson(Map<String, Object?> json) =>
      _$DealtCardFromJson(json);
}
