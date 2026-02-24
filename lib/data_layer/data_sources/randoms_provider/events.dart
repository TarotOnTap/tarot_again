import 'package:tarot_again/data_layer/data_layer.dart';
import 'package:tarot_again/util/event_bus.dart';

/// prefix E for Event

class ESetRandomSource extends EventBase<String> {} // no corresponding getter?

// (int, int) represents the range (inclusive min, exclusive max) of the values to be generated.
class EGenerateRandomInt extends EventBase<(int, int)> {}

// the response is a single integer
class ERandomIntGenerated extends EventBase<int> {}

class EGenerateRandomDouble extends EventBase {}

class ERandomDoubleGenerated extends EventBase<double> {}

class EGenerateRandomBool extends EventBase {}

class ERandomBoolGenerated extends EventBase<bool> {}

class EGetNextRandomTarotCard extends EventBase {}

class ENextRandomTarotCardGenerated extends EventBase<TarotDeckCards> {}

class ERandomShuffleIterable<E> extends EventBase<Iterable<E>> {}

class EShuffleIterableGenerated<E> extends EventBase<Iterable<E>> {}
