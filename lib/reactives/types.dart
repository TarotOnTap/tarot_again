enum StandardTarotDecks {
  rws("RWS Tarot Deck");

  const StandardTarotDecks(this.displayName);

  final String displayName;
}

enum DeckTypesEnum {
  standardTarot("StandardTarot"),
  standardPlayingCards("StandardPlayingCards");

  const DeckTypesEnum(this.displayName);

  final String displayName;
}

enum ShowingFaceEnum {
  back("Back"),
  front("Front");

  const ShowingFaceEnum(this.displayName);

  final String displayName;
}

enum ReversalEnum {
  upright("Upright"),
  reversed("Reversed");

  const ReversalEnum(this.displayName);

  final String displayName;
}
