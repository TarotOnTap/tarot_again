import 'package:material_ui/material_ui.dart';
import 'package:tarot_again/util/util.dart';

class LayoutBackground({super.key}) extends StatelessWidget with Logging {
  @override
  Widget build(BuildContext context) {
    return Center(child: Container(color: Theme.of(context).focusColor));
  }
}
