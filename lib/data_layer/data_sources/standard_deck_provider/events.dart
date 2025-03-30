import 'package:meta/meta.dart';
import 'package:tarot_again/util/util.dart';

import 'types.dart';

// initializer events
@immutable
class InitializeStandardDeck extends MessageEvent {
  const InitializeStandardDeck({super.sender});
}

@immutable
class StandardDeckInitialized extends ResponseEvent {
  const StandardDeckInitialized({super.sender, super.responseTo});
}

@immutable
sealed class StandardDeckDataProviderEvent extends MessageEvent {
  const StandardDeckDataProviderEvent({super.sender});
}

@immutable
sealed class StandardDeckDataProviderResponseEvent extends ResponseEvent {
  const StandardDeckDataProviderResponseEvent({super.sender, super.responseTo});
}

@immutable
class ShuffleDeck extends StandardDeckDataProviderEvent {
  const ShuffleDeck({super.sender});
}

@immutable
class DeckShuffled extends StandardDeckDataProviderResponseEvent {
  const DeckShuffled({super.sender, super.responseTo});
}

@immutable
class GetNextCard extends StandardDeckDataProviderEvent {
  const GetNextCard({super.sender});
}

@immutable
class NoNextCard extends StandardDeckDataProviderResponseEvent {
  const NoNextCard({super.sender, super.responseTo});
}

@immutable
class NextCard extends StandardDeckDataProviderResponseEvent {
  final TCModel card;

  const NextCard({super.sender, super.responseTo, required this.card});

  @override
  NextCard copyWith({Object? sender, MessageEvent? responseTo, TCModel? card}) =>
      NextCard(
          sender: sender ?? this.sender,
          responseTo: responseTo ?? this.responseTo,
          card: card ?? this.card
      );

  @override
  List<Object?> get props => [ sender, card ];
}