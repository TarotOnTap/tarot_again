part of 'bulk_card_control_bloc.dart';

@freezed
abstract class BulkCardControlState with _$BulkCardControlState {
  factory BulkCardControlState({
    required bool everybodyFaceUp,
    required bool reversalsAllowed,
    @Default("RWS") String deckName,
  }) = _BulkCardControlState;

  factory BulkCardControlState.fromJson(Map<String, Object?> json) =>
      _$BulkCardControlStateFromJson(json);
}