import 'package:meta/meta.dart';
import 'package:tarot_again/util/util.dart';

sealed class DeckDataProviderEvent extends MessageEvent {
  const DeckDataProviderEvent({super.sender});
}
class ShuffleDeck extends DeckDataProviderEvent {}
class DeckShuffled extends DeckDataProviderEvent {}

@immutable
class GetNextCard extends DeckDataProviderEvent {}

@immutable
class NoNextCard extends DeckDataProviderEvent {}

@immutable
class NextCard extends DeckDataProviderEvent {
  final TCModel card;

  const NextCard({super.sender, required this.card});

  @override
  NextCard copyWith({Object? sender, TCModel? card}) =>
      NextCard(
          sender: sender ?? this.sender,
          card: card ?? this.card
      );

  @override
  List<Object?> get props => [ sender, card ];
}