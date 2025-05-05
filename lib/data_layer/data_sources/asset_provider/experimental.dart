import 'package:tarot_again/util/util.dart';

typedef NodeMap = IMap<String, MappableNode>;

extension IterableUseful<E> on Iterable<E> {
  Iterable<E> get tail => skip(1);
}

mixin MappableNode {
  late final MappableNode? parent;
  NodeMap node = const NodeMap.empty();

  MappableNode add(String key, MappableNode toAdd) {
    toAdd.parent = this;
    node = node.add(key, toAdd);

    return this;
  }

  bool containsKey(String key) => node.containsKey(key);

  @override
  noSuchMethod(Invocation invocation) {
    // permitting dotted getter access on the node.
    // we simply pass along the given getter name as an index into node data. If that
    // fails, we fail.
    if (invocation.isGetter) {
      String s = invocation.memberName.toString();

      throwIfNot(
        node.containsKey(s),
        UnrecognizedKeysException(
          [s],
          node as Map<dynamic, dynamic>,
          node.keys.toList(),
        ),
      );

      return node[s]!;
    }

    return super.noSuchMethod(invocation);
  }

  bool get isEmpty => node.isEmpty;

  bool get isNotEmpty => node.isNotEmpty;

  // likewise, we permit indexed access. However, this is allowed to return null normally.
  operator [](String index) => node[index];
}

class LayerMap with MappableNode {
  // note - parent is optional here, because the add method on MappableNode will set
  // the parent when a node is added to the tree. The root of the tree, however, has
  // no parent.
  LayerMap({MappableNode? parent}) {
    this.parent = parent;
  }
}

class LeafMap with MappableNode {
  // these three attributes are available for dotted access.
  final String assetPath;

  late final String fileName;
  late final String fileExtension;

  LeafMap({required this.assetPath, MappableNode? parent}) {
    this.parent = parent;

    final pathSegments = assetPath.split("/");
    final filePieces = pathSegments.last.split(".");

    fileName = pathSegments.last;
    // final fileKey = filePieces[0];
    fileExtension = filePieces.last;
  }

  // provide indexed access to these three attributes.
  @override
  operator [](String index) => switch (index) {
    "assetPath" => assetPath,
    "fileName" => fileName,
    "fileExtension" => fileExtension,
    _ => null,
  };
}

MappableNode assetMap = LayerMap();

MappableNode addAsset(
  String assetPath,
  Iterable<String> nodeList,
  MappableNode currentMap,
) {
  String key = nodeList.first;

  if (!currentMap.containsKey(key)) {
    currentMap = currentMap.add(key, LayerMap(parent: currentMap));
  }

  if (nodeList.length == 2) {
    currentMap[key]?.add(
      nodeList.last,
      LeafMap(assetPath: assetPath, parent: currentMap[key]),
    );

    return currentMap;
  } else {
    return addAsset(
      assetPath,
      nodeList.tail,
      currentMap[key] ?? LayerMap(parent: currentMap),
    );
  }
}
