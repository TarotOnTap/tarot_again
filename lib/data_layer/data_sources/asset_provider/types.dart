import 'package:flutter/material.dart';
import 'package:tarot_again/util/util.dart';

typedef NodeMap = IMap<String, MappableNode>;

extension IterableUseful<E> on Iterable<E> {
  Iterable<E> get tail => skip(1);

  Iterable<E> get front => take(length - 1);
}

class MappableNodeException implements Exception {}

class LeafMapAddException implements MappableNodeException {
  final LeafNode leafMap;

  String? get message => "attempt to add a child to a LeafNode()";

  const LeafMapAddException(this.leafMap);

  @override
  String toString() => "LeafMapAddException on $leafMap";
}

class MappableNode {
  MappableNode? parent;
  IMap<String, Object?> node = const IMap<String, Object?>.empty();

  MappableNode({this.parent});

  MappableNode add(String key, MappableNode toAdd) {
    toAdd.parent = this;
    node = node.add(key, toAdd);

    return this;
  }

  bool containsKey(String key) => node.containsKey(key);

  bool get isEmpty => node.isEmpty;

  bool get isNotEmpty => node.isNotEmpty;

  Iterable<String> get keys => node.keys;

  Iterable<Object?> get values => node.values;

  Iterable<MapEntry<String, Object?>> get entries => node.entries;

  operator [](String index) => node[index];
}

enum LeafAssetTypes { image, markdown, json, unknown }

class LeafNode extends MappableNode {
  late final LeafAssetTypes assetType;

  final String assetPath;

  late final String fileName;
  late final String fileExtension;

  late final AssetGenImage? imageAsset;

  // isImage is the more important of these, because consumers of images do not
  // need to async await, or load the image prior to use. The AssetGenImage type
  // handles the necessary transformation for us so that it can be used directly in
  // widgets without having do anything special.

  // Other asset types do need to be awaited before they can be used.
  LeafNode({required this.assetPath, super.parent}) {
    final pathSegments = assetPath.split("/");
    final filePieces = pathSegments.last.split(".");

    fileName = pathSegments.last;
    // final fileKey = filePieces[0];
    fileExtension = filePieces.last;

    assetType = switch (fileExtension) {
      "md" => LeafAssetTypes.markdown,
      "json" => LeafAssetTypes.json,
      "jpg" || "png" || "gif" || "jpeg" => LeafAssetTypes.image,
      _ => LeafAssetTypes.unknown,
    };

    // imageAsset needs to be initialized, because it's late final
    imageAsset =
        assetType == LeafAssetTypes.image
            ? imageAsset = AssetGenImage(assetPath)
            : null;

    node = node
        .add("assetPath", assetPath)
        .add("fileName", fileName)
        .add("fileExtension", fileExtension);
  }

  @override
  MappableNode add(String key, MappableNode toAdd) =>
      throw (LeafMapAddException(this));

  @override
  String toString() {
    StringBuffer description = StringBuffer("LeafMap(");
    description.writeln("  assetPath: '$assetPath'");
    description.writeln("  fileName: '$fileName'");
    description.writeln("  fileExtension: '$fileExtension'");
    description.writeln(")");
    return description.toString();
  }
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

sealed class AssetProviderEvents {}

class SetDeckTypeEvent extends AssetProviderEvents {
  final String deckType;

  SetDeckTypeEvent({required this.deckType});
}

class SetDeckNameEvent extends AssetProviderEvents {
  final String deckName;

  SetDeckNameEvent({required this.deckName});
}
