import 'package:tarot_again/data_layer/data_layer.dart';
import 'package:tarot_again/util/util.dart';

part 'types.freezed.dart';

@Freezed(fromJson: false, toJson: false)
abstract class TCModelAssets with _$TCModelAssets {
  // final String? description;
  // final String? reversed;
  // final String? upright;
  // final AssetGenImage? image;

  factory TCModelAssets({
    @Default(null) String? description,
    @Default(null) String? reversed,
    @Default(null) String? upright,
    @Default(null) AssetGenImage? image,
  }) = _TCModelAssets;
}
