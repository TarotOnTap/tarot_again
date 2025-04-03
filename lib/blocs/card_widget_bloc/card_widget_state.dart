part of 'card_widget_bloc.dart';

@freezed
sealed class CardWidgetState with _$CardWidgetState {
  factory CardWidgetState({
    @Default(false) bool faceUp,
    @Default(false) bool reversed,
    TCModel? card,
    String? description,
    String? uprightMeaning,
    String? reversedMeaning,
  }) = _CardWidgetState;

  factory CardWidgetState.fromJson(Map<String, Object?> json) =>
      _$CardWidgetStateFromJson(json);
}

// @JsonSerializable()
// @immutable
// final class CardWidgetState extends Equatable {
//   final bool faceUp;
//   final bool reversed;
//
//   final TCModel card;
//
//   final String? description;
//   final String? uprightMeaning;
//   final String? reversedMeaning;
//
//   const CardWidgetState({
//     required this.card,
//     this.faceUp = false,
//     this.reversed = false,
//     this.description,
//     this.uprightMeaning,
//     this.reversedMeaning,
//   });
//
//   CardWidgetState copyWith({
//     TCModel? card,
//     bool? faceUp,
//     bool? reversed,
//     String? description,
//     String? uprightMeaning,
//     String? reversedMeaning,
//   }) => CardWidgetState(
//     card: card ?? this.card,
//     faceUp: faceUp ?? this.faceUp,
//     reversed: reversed ?? this.reversed,
//     description: description ?? this.description,
//     uprightMeaning: uprightMeaning ?? this.uprightMeaning,
//     reversedMeaning: reversedMeaning ?? this.reversedMeaning,
//   );
//
//   /// Connect the generated [_$PersonFromJson] function to the `fromJson`
//   /// factory.
//   factory CardWidgetState.fromJson(Map<String, dynamic> json) =>
//       _$CardWidgetStateFromJson(json);
//
//   /// Connect the generated [_$PersonToJson] function to the `toJson` method.
//   Map<String, dynamic> toJson() => _$CardWidgetStateToJson(this);
//
//   @override
//   List<Object?> get props => [
//     card,
//     faceUp,
//     reversed,
//     description,
//     uprightMeaning,
//     reversedMeaning,
//   ];
// }