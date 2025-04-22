import 'package:flutter/material.dart';
import 'package:tarot_again/util/util.dart';

@immutable
class NullLayoutWidget extends WatchingWidget with Logging {
  const NullLayoutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Placeholder(child: Text("NullLayoutWidget"));
  }
}
