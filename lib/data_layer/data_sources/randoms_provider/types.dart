import 'dart:math';

import 'package:tarot_again/data_layer/data_layer.dart';
import 'package:tarot_again/util/util.dart';

enum RandomGenerators {
  none(displayName: "None", genCreator: SecureRandom.new),
  local(displayName: "Local", genCreator: SecureRandom.new),
  secureRandom(displayName: "Secure Random", genCreator: SecureRandom.new);

  const RandomGenerators({required this.displayName, required this.genCreator});

  final String displayName;
  final RandomsProvider Function() genCreator;
}

abstract class RandomsProvider {
  Future<int> getNextInt({int rangeLow = 0, required int rangeHigh});

  Future<double> getNextDouble();

  Future<bool> getNextBool();
}

class AsyncRandoms extends BaseProvider with Logging {
  IList<String> _randomGeneratorNames = const IList<String>.empty();

  // lazy loaded. Not really needed, unless we switch to a dynamically-loaded
  // model for generators.
  IList<String> get randomGeneratorNames {
    if (_randomGeneratorNames.isEmpty) {
      _randomGeneratorNames =
          RandomGenerators.values.map((item) => item.displayName).toList().lock;
    }

    return _randomGeneratorNames;
  }

  RandomGenerators currentGenerator = RandomGenerators.none;
  late RandomsProvider currentProvider;

  AsyncRandoms._() {
    setRandomSource(RandomGenerators.none.displayName);
  }

  factory AsyncRandoms() {
    if (!sl.isRegistered<AsyncRandoms>()) {
      return sl.registerSingleton<AsyncRandoms>(AsyncRandoms._());
    }

    return sl<AsyncRandoms>();
  }

  void setRandomSource(String name) {
    // this *always* inserts a new random generator of the source type, even if it's
    // the same as the current source type.
    // along the way
    verbose("setRandomSource: newSource is $name");

    currentGenerator = RandomGenerators.values.firstWhere(
      (elem) => elem.displayName == name,
      orElse: () => RandomGenerators.none,
    );

    currentProvider = currentGenerator.genCreator();
  }

  Future<int> getNextInt({int rangeLow = 0, required int rangeHigh}) =>
      currentProvider.getNextInt(rangeLow: rangeLow = 0, rangeHigh: rangeHigh);

  Future<double> getNextDouble() => currentProvider.getNextDouble();

  Future<bool> getNextBool() => currentProvider.getNextBool();

  Future<IList<E>> shuffleIterable<E>(
    // The goal is to return a list of cards in shuffled order.
    // upstream processing can handle cards popping out of the shuffle, etc.
    // where it might be useful to use a stream, drawing one card at a time with
    // the occasional exception.
    Iterable<E> remaining,
  ) async {
    IList<E> copy = IList(remaining);
    // Output<E> removedItem = Output<E>();
    IList<E> resultList = IList<E>([]);

    if (copy.isNotEmpty) {
      // taskChoice never fails
      int index = await getNextInt(rangeHigh: copy.length - 1);

      // final int choice = await getNextInt(rangeHigh: copy.length - 1);
      E item = copy[index];
      copy = copy.removeAt(index);

      resultList = IList<E>([item]) + await shuffleIterable(copy);
    }

    return resultList;
  }

  Stream<E> shuffleIterableStream<E>(Iterable<E> remaining) async* {
    IList<E> copy = IList(remaining);
    // Output<E> removedItem = Output<E>();
    // IList<E> resultList = IList<E>([]);

    if (copy.isNotEmpty) {
      // taskChoice never fails
      int index = await getNextInt(rangeHigh: copy.length - 1);

      // final int choice = await getNextInt(rangeHigh: copy.length - 1);
      E item = copy[index];
      copy = copy.removeAt(index);

      yield item;
      yield* shuffleIterableStream(copy);
    }
  }

  StreamQueue<E> shuffleIterableQueue<E>(Iterable<E> remaining) =>
      StreamQueue(shuffleIterableStream<E>(remaining));
}

/// class SecureRandom extends _AsyncRandomsImpl with Logging {
/// use Random.secure() to create a "good enough" random number generator.
class SecureRandom extends RandomsProvider with Logging {
  // Other classes implement random numbers using various publicly available
  // online RNGs based on natural events.
  // The only reason to make an async version of the Random class is to use as
  // a drop-in replacement for the other classes.
  final Random secureRandom = Random.secure();

  @override
  Future<int> getNextInt({int rangeLow = 0, required int rangeHigh}) async =>
      secureRandom.nextInt(rangeHigh - rangeLow + 1) + rangeLow;

  @override
  Future<double> getNextDouble() async => secureRandom.nextDouble();

  @override
  Future<bool> getNextBool() async => secureRandom.nextBool();
}
