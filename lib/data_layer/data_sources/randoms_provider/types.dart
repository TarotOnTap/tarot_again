import 'dart:math';

import 'package:tarot_again/util/event_bus.dart';
import 'package:tarot_again/util/util.dart';

enum RandomGenerators {
  none(displayName: "Default", genCreator: SecureRandom.new),
  local(displayName: "Device", genCreator: SecureRandom.new);

  // secureRandom(displayName: "Device", genCreator: SecureRandom.new);

  const RandomGenerators({required this.displayName, required this.genCreator});

  final String displayName;
  final IRandomsProvider Function() genCreator;
}

/// The [IRandomsProvider] gives the methods that must be present for any
/// provider of random numbers.
/// All methods are async or async*, because some of the random providers
/// will rely on network calls to retrieve random numbers from online
/// providers.
abstract interface class IRandomsProvider {
  /// [getNextInt] Returns the next integer from the random number generator, and the
  /// integer will fall within the range provided
  Future<int> getNextInt({int rangeLow = 0, required int rangeHigh});

  /// [getNextIntFromCountdown] is useful for shuffling iterables. It provides a
  /// stream of random integers that corresponds to indexes on a shrinking list; each
  /// random number yielded will presumably be used to remove an item from a list, in which
  /// case the list's length will decrease by one for each random int provided. The last
  /// int yielded will always be 0.
  Stream<int> getNextIntFromCountdown(int rangeHigh);

  /// [getNextDouble] returns a double in the range >= 0.0 and < 1.0 (according to the documentation for math.Random)
  Future<double> getNextDouble();

  /// [getNextBool] returns a bool with an equally-weighted probability of true or false.
  Future<bool> getNextBool();
}

/// This class is the sole provider of random numbers for this app.
///
/// The actual random number generator
/// used can be swapped between available options, but all calls for random numbers are made through the singleton
/// instance of this class.
@singleton
class AsyncRandoms
    with EventReceiverMixin, Logging
    implements IRandomsProvider {
  static IList<String> _randomGeneratorNames = const IList<String>.empty();

  // lazy loaded. Not really needed, unless we switch to a dynamically-loaded
  // model for generators.
  static IList<String> get randomGeneratorNames {
    if (_randomGeneratorNames.isEmpty) {
      _randomGeneratorNames = RandomGenerators.values
          .map((item) => item.displayName)
          .toList()
          .lock;
    }

    return _randomGeneratorNames;
  }

  /// This method is for changing the source of randomness from among a fixed set
  /// of choices, encoded as the enum [RandomGenerators].
  ///
  /// [name] is the display name for the generator, as seen on screen and selected by the user.
  void setRandomSource(String name) {
    // this *always* inserts a new random generator of the source type, even if it's
    // the same as the current source type.
    SignalsManager.currentRandomGenerator.value = RandomGenerators.values
        .firstWhere(
          (elem) => elem.displayName == name,
          orElse: () => RandomGenerators.none,
        );

    SignalsManager.currentRandomProvider.value = SignalsManager
        .currentRandomGenerator
        .value
        .genCreator();
  }

  Future<int> getNextInt({int rangeLow = 0, required int rangeHigh}) =>
      SignalsManager.currentRandomProvider.value.getNextInt(
        rangeLow: rangeLow,
        rangeHigh: rangeHigh,
      );

  Stream<int> getNextIntFromCountdown(int rangeHigh) => SignalsManager
      .currentRandomProvider
      .value
      .getNextIntFromCountdown(rangeHigh);

  Future<double> getNextDouble() =>
      SignalsManager.currentRandomProvider.value.getNextDouble();

  Future<bool> getNextBool() =>
      SignalsManager.currentRandomProvider.value.getNextBool();

  (IList<E>, IList<E>) _moveBetweenILists<E>(
    IList<E> copy,
    IList<E> result,
    index,
  ) {
    Output<E> item = Output<E>();

    return (copy.removeAt(index, item), result.add(item.value!));
  }

  Future<IList<E>> shuffleIterable<E>({required Iterable<E> remaining}) async {
    IList<E> resultList = IList<E>.empty();

    if (remaining.isNotEmpty) {
      IList<E> copy = IList<E>(remaining);

      await for (int index in getNextIntFromCountdown(resultList.length)) {
        (copy, resultList) = _moveBetweenILists<E>(copy, resultList, index);
      }
    }

    return resultList;
  }

  // The goal is to return a list of cards in shuffled order.
  // upstream processing can handle cards popping out of the shuffle, etc.
  // where it might be useful to use a stream, drawing one card at a time with
  // the occasional exception.
  Future<IList<E>> shuffleIterable2<E>({required Iterable<E> remaining}) async {
    IList<E> copy = IList(remaining);
    IList<E> resultList = IList<E>.empty();

    int index;

    if (copy.isNotEmpty) {
      if (copy.length == 1) {
        resultList = copy;
      } else {
        index = await getNextInt(rangeHigh: copy.length - 1);

        E item = copy[index];

        resultList =
            IList<E>([item]) +
            await shuffleIterable<E>(remaining: copy.removeAt(index));
      }
    }

    return resultList;
  }

  Stream<E> shuffleIterableStream<E>(Iterable<E> remaining) async* {
    IList<E> copy = IList(remaining);
    // Output<E> removedItem = Output<E>();
    // IList<E> resultList = IList<E>([]);

    while (copy.isNotEmpty) {
      if (copy.length == 1) {
        yield copy[0];

        return;
      } else {
        int index = await getNextInt(rangeHigh: copy.length - 1);

        E item = copy[index];
        copy = copy.removeAt(index);

        yield item;
      }
    }
  }

  StreamQueue<E> shuffleIterableQueue<E>(Iterable<E> remaining) =>
      StreamQueue(shuffleIterableStream<E>(remaining));
}

/// class SecureRandom extends _AsyncRandomsImpl with Logging {
/// use Random.secure() to create a "good enough" random number generator.
class SecureRandom extends IRandomsProvider with Logging {
  // Other classes implement random numbers using various publicly available
  // online RNGs based on natural events.
  // The only reason to make an async version of the Random class is to use as
  // a drop-in replacement for the other classes.
  final Random secureRandom = Random.secure();

  @override
  Future<int> getNextInt({int rangeLow = 0, required int rangeHigh}) async =>
      secureRandom.nextInt(rangeHigh - rangeLow) + rangeLow;

  Stream<int> getNextIntFromCountdown(int rangeHigh) async* {
    int currentRange = rangeHigh; // covers the range [0..rangeHigh)

    while (currentRange > 0) {
      yield secureRandom.nextInt(currentRange);
    }

    yield 0;
  }

  @override
  Future<double> getNextDouble() async => secureRandom.nextDouble();

  @override
  Future<bool> getNextBool() async => secureRandom.nextBool();
}
