import 'package:material_ui/material_ui.dart';

@immutable
class NoCardDealt extends StatelessWidget {
  const NoCardDealt({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 70,
      height: 120,
      child: Center(child: Icon(Icons.question_mark)),
    );
  }
}
