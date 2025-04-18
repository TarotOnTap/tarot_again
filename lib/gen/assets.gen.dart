/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsDecksGen {
  const $AssetsDecksGen();

  /// Directory path: assets/decks/standard_tarot
  $AssetsDecksStandardTarotGen get standardTarot =>
      const $AssetsDecksStandardTarotGen();
}

class $AssetsLayoutsGen {
  const $AssetsLayoutsGen();

  /// Directory path: assets/layouts/tarot_layouts
  $AssetsLayoutsTarotLayoutsGen get tarotLayouts =>
      const $AssetsLayoutsTarotLayoutsGen();
}

class $AssetsDecksStandardTarotGen {
  const $AssetsDecksStandardTarotGen();

  /// Directory path: assets/decks/standard_tarot/RWS
  $AssetsDecksStandardTarotRWSGen get rws =>
      const $AssetsDecksStandardTarotRWSGen();

  /// Directory path: assets/decks/standard_tarot/meanings
  $AssetsDecksStandardTarotMeaningsGen get meanings =>
      const $AssetsDecksStandardTarotMeaningsGen();
}

class $AssetsLayoutsTarotLayoutsGen {
  const $AssetsLayoutsTarotLayoutsGen();

  /// File path: assets/layouts/tarot_layouts/all_cards.json
  String get allCards => 'assets/layouts/tarot_layouts/all_cards.json';

  /// File path: assets/layouts/tarot_layouts/past_present_future.json
  String get pastPresentFuture =>
      'assets/layouts/tarot_layouts/past_present_future.json';

  /// List of all assets
  List<String> get values => [allCards, pastPresentFuture];
}

class $AssetsDecksStandardTarotRWSGen {
  const $AssetsDecksStandardTarotRWSGen();

  /// Directory path: assets/decks/standard_tarot/RWS/descriptions
  $AssetsDecksStandardTarotRWSDescriptionsGen get descriptions =>
      const $AssetsDecksStandardTarotRWSDescriptionsGen();

  /// Directory path: assets/decks/standard_tarot/RWS/images
  $AssetsDecksStandardTarotRWSImagesGen get images =>
      const $AssetsDecksStandardTarotRWSImagesGen();
}

class $AssetsDecksStandardTarotMeaningsGen {
  const $AssetsDecksStandardTarotMeaningsGen();

  /// Directory path: assets/decks/standard_tarot/meanings/standard_tarot
  $AssetsDecksStandardTarotMeaningsStandardTarotGen get standardTarot =>
      const $AssetsDecksStandardTarotMeaningsStandardTarotGen();
}

class $AssetsDecksStandardTarotRWSDescriptionsGen {
  const $AssetsDecksStandardTarotRWSDescriptionsGen();

  /// File path: assets/decks/standard_tarot/RWS/descriptions/fool.md
  String get fool => 'assets/decks/standard_tarot/RWS/descriptions/fool.md';

  /// File path: assets/decks/standard_tarot/RWS/descriptions/hermit.md
  String get hermit => 'assets/decks/standard_tarot/RWS/descriptions/hermit.md';

  /// List of all assets
  List<String> get values => [fool, hermit];
}

class $AssetsDecksStandardTarotRWSImagesGen {
  const $AssetsDecksStandardTarotRWSImagesGen();

  /// File path: assets/decks/standard_tarot/RWS/images/fool.jpg
  AssetGenImage get fool =>
      const AssetGenImage('assets/decks/standard_tarot/RWS/images/fool.jpg');

  /// File path: assets/decks/standard_tarot/RWS/images/hermit.jpg
  AssetGenImage get hermit =>
      const AssetGenImage('assets/decks/standard_tarot/RWS/images/hermit.jpg');

  /// List of all assets
  List<AssetGenImage> get values => [fool, hermit];
}

class $AssetsDecksStandardTarotMeaningsStandardTarotGen {
  const $AssetsDecksStandardTarotMeaningsStandardTarotGen();

  /// Directory path: assets/decks/standard_tarot/meanings/standard_tarot/reversed
  $AssetsDecksStandardTarotMeaningsStandardTarotReversedGen get reversed =>
      const $AssetsDecksStandardTarotMeaningsStandardTarotReversedGen();

  /// Directory path: assets/decks/standard_tarot/meanings/standard_tarot/upright
  $AssetsDecksStandardTarotMeaningsStandardTarotUprightGen get upright =>
      const $AssetsDecksStandardTarotMeaningsStandardTarotUprightGen();
}

class $AssetsDecksStandardTarotMeaningsStandardTarotReversedGen {
  const $AssetsDecksStandardTarotMeaningsStandardTarotReversedGen();

  /// File path: assets/decks/standard_tarot/meanings/standard_tarot/reversed/fool.md
  String get fool =>
      'assets/decks/standard_tarot/meanings/standard_tarot/reversed/fool.md';

  /// List of all assets
  List<String> get values => [fool];
}

class $AssetsDecksStandardTarotMeaningsStandardTarotUprightGen {
  const $AssetsDecksStandardTarotMeaningsStandardTarotUprightGen();

  /// File path: assets/decks/standard_tarot/meanings/standard_tarot/upright/fool.md
  String get fool =>
      'assets/decks/standard_tarot/meanings/standard_tarot/upright/fool.md';

  /// List of all assets
  List<String> get values => [fool];
}

class Assets {
  const Assets._();

  static const $AssetsDecksGen decks = $AssetsDecksGen();
  static const $AssetsLayoutsGen layouts = $AssetsLayoutsGen();
}

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
