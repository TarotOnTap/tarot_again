import 'package:tarot_again/util/util.dart';

// @JsonEnum()
enum StandardTarotDecksEnum {
  rws(displayName: "RWS");

  const StandardTarotDecksEnum({required this.displayName});

  final String displayName;
}

// @JsonEnum()
enum DeckTypesEnum {
  standardTarot(displayName: "Standard Tarot"),
  standardPlayingCards(displayName: "Standard Playing Cards");

  const DeckTypesEnum({required this.displayName});

  final String displayName;
}

final class SlotState {
  late final Signal<TarotDeckCards?> deckCard;
  late final Signal<bool> faceUp;
  late final Signal<bool> reversed;
  late final Signal<TCModelAssets?> assets;
  late final Signal<String> slotName;

  final int slotIndex;

  SlotState({required this.slotIndex}) {
    deckCard = signal(null, debugLabel: "deckCard slot[$slotIndex]");
    faceUp = signal(false, debugLabel: "faceUp slot[$slotIndex]");
    reversed = signal(false, debugLabel: "reversed slot[$slotIndex]");
    assets = signal(null, debugLabel: "assets slot[$slotIndex]");
    slotName = signal("", debugLabel: "slotName slot[$slotIndex]");
  }

  bool get isDealt => deckCard.value != null;

  bool get hasAssets => assets.value != null;

  @override
  String toString() {
    return "SlotState(slotIndex: $slotIndex, slotName: $slotName\n"
        "  deckCard: $deckCard,\n  faceUp: $faceUp,\n  reversed: $reversed,\n  assets: $assets\n)";
  }
}
