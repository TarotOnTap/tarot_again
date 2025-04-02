part of 'card_widget_bloc.dart';

@immutable
final class CardWidgetState extends Equatable {
  final bool faceUp;
  final bool reversed;

  final TCModel? card;
  final Widget? face;
  final Widget? back;

  final String? description;
  final String? uprightMeaning;
  final String? reversedMeaning;

  const CardWidgetState({
    this.card,
    this.faceUp=false,
    this.reversed=false,
    this.face,
    this.back,
    this.description,
    this.uprightMeaning,
    this.reversedMeaning
  });

  CardWidgetState copyWith({
    TCModel? card,
    bool? faceUp,
    bool? reversed,
    Widget? face,
    Widget? back,
    String? description,
    String? uprightMeaning,
    String? reversedMeaning
  }) =>
      CardWidgetState(
        card: card, // never changes
        faceUp: faceUp ?? this.faceUp,
        reversed: reversed ?? this.reversed,
        face: face ?? this.face,
        back: back ?? this.back,
        description: description ?? this.description,
        uprightMeaning: uprightMeaning ?? this.uprightMeaning,
        reversedMeaning: reversedMeaning ?? this.reversedMeaning
      );

  @override
  List<Object?> get props => [
    card,
    faceUp,
    reversed,
    face,
    back,
    description,
    uprightMeaning,
    reversedMeaning
  ];
}