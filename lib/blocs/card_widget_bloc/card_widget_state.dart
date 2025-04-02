part of 'card_widget_bloc.dart';

final class CardWidgetState extends Equatable {
  final bool faceUp;
  final bool reversed;

  final DealtCard? card;
  final Widget? face;
  final Widget? back;

  const CardWidgetState({
    this.card,
    this.faceUp=false,
    this.reversed=false,
    this.face,
    this.back
  });

  CardWidgetState copyWith({
    DealtCard? card,
    bool? faceUp,
    bool? reversed,
    Widget? face,
    Widget? back
  }) =>
      CardWidgetState(
        card: card, // never changes
        faceUp: faceUp ?? this.faceUp,
        reversed: reversed ?? this.reversed,
        face: face ?? this.face,
        back: back ?? this.back
      );

  @override
  List<Object?> get props => [ card, faceUp, reversed, face, back ];
}