part of 'card_widget.dart';

class DeckEmptyWidget extends StatelessWidget with Logging {
  const DeckEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[Text("Deck"), Text("is"), Text("Empty")],
    );
  }
}
