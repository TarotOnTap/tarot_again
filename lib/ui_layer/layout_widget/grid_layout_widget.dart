import 'package:flutter/material.dart';
import 'package:tarot_again/data_layer/data_layer.dart';
import 'package:tarot_again/util/util.dart';

@immutable
class GridLayoutWidget extends StatelessWidget with Logging {
  final SimpleGrid layoutDetails;
  final List<Widget> children;

  const GridLayoutWidget({
    super.key,
    required this.layoutDetails,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    verbose("GridLayoutWidget.build");
    verbose("  children.length: ${children.length}");
    return Placeholder(child: Text("GridLayoutWidget"));
  }
}
