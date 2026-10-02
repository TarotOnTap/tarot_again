// import 'package:align_positioned/align_positioned.dart';
import 'package:flutter/material.dart';
// import 'package:tarot_again/ui_layer/card_widget/card_widget.dart';
import 'package:tarot_again/util/util.dart';

class LayoutBackground({super.key}) extends StatelessWidget with Logging {
  @override
  Widget build(BuildContext context) {
    return Center(child: Container(color: Theme.of(context).focusColor));
  }
}
