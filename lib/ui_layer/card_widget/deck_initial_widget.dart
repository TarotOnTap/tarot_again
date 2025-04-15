part of 'card_widget.dart';

class DeckInitialWidget extends StatelessWidget with Logging {
  const DeckInitialWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[Text("Deck"), Text("is"), Text("Initial")],
    );
  }
}
