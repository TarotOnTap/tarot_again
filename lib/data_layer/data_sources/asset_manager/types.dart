import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';

// part 'types.freezed.dart'; // leave this here

@immutable
class AssetGenImage {
  const AssetGenImage(this._assetName, {this.size, this.flavors = const {}});

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

typedef TCModelAssets = ({
  Option<String> description,
  Option<String> reversedMeaning,
  Option<String> uprightMeaning,
  Option<AssetGenImage> image,
});

const TCModelAssets emptyTCModelAssets = (
  description: Option.none(),
  reversedMeaning: Option.none(),
  uprightMeaning: Option.none(),
  image: Option.none(),
);

// @Freezed(fromJson: false, toJson: false)
// abstract class TCModelAssets with _$TCModelAssets {
//   const factory TCModelAssets({
//     @Default(Option<String>.none()) Option<String> description,
//     @Default(Option<String>.none()) Option<String> reversedMeaning,
//     @Default(Option<String>.none()) Option<String> uprightMeaning,
//     @Default(Option<AssetGenImage>.none()) Option<AssetGenImage> image,
//   }) = _TCModelAssets;
// }
