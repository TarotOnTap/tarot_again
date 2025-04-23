import 'package:flutter/material.dart';
import 'package:tarot_again/data_layer/data_layer.dart';
import 'package:tarot_again/util/util.dart';

@immutable
class LinearLayoutWidget extends WatchingWidget with Logging {
  final HorizontalLinear layoutDetails;
  final List<Widget> children;

  const LinearLayoutWidget({
    super.key,
    required this.layoutDetails,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: children,
    );
  }
}
