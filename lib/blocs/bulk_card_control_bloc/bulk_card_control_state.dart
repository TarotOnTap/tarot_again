part of 'bulk_card_control_bloc.dart';

typedef CardPosition = String;
typedef CardPositions = IList<CardPosition>;

@JsonEnum()
enum StandardTarotDecksEnum {
  rws(displayName: "RWS");

  const StandardTarotDecksEnum({required this.displayName});

  final String displayName;
}

@JsonEnum()
enum DeckTypesEnum {
  standardTarot(displayName: "Standard Tarot"),
  standardPlayingCards(displayName: "Standard Playing Cards");

  const DeckTypesEnum({required this.displayName});

  final String displayName;
}

@freezed
abstract class BulkCardControlState with _$BulkCardControlState {
  factory BulkCardControlState({
    @Default(false) bool everybodyFaceUp,
    @Default(true) bool reversalsAllowed,
    @Default(DeckTypesEnum.standardTarot) DeckTypesEnum deckType,
    @Default(StandardTarotDecksEnum.rws) StandardTarotDecksEnum deckChoice,
  }) = _BulkCardControlState;

  factory BulkCardControlState.fromJson(Map<String, Object?> json) =>
      _$BulkCardControlStateFromJson(json);
}
