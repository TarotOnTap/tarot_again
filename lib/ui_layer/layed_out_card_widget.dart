import 'package:flutter/material.dart';
import 'package:tarot_again/blocs/blocs.dart';
import 'package:tarot_again/data_layer/data_layer.dart';
import 'package:tarot_again/util/util.dart';

@immutable
class LayedOutCardWidget extends StatelessWidget {
  final LayoutPositionInfo layoutPosition;

  const LayedOutCardWidget({super.key, required this.layoutPosition});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
