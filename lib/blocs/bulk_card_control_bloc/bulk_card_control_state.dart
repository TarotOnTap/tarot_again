part of 'bulk_card_control_bloc.dart';

typedef CardPosition = String;
typedef CardPositions = IList<CardPosition>;

@freezed
abstract class BulkCardControlState with _$BulkCardControlState {
  factory BulkCardControlState({
    @Default(false) bool everybodyFaceUp,
    @Default(true) bool reversalsAllowed,
    @Default("RWS") String deckName,
    @Default(Option<CardPositions>.none()) Option<CardPositions> positions,
  }) = _BulkCardControlState;

  factory BulkCardControlState.fromJson(Map<String, Object?> json) =>
      _$BulkCardControlStateFromJson(json);
}
