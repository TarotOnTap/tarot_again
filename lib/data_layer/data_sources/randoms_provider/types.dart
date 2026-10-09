import 'dart:math';

// import 'package:randomness/randomness.dart';

// import 'package:tarot_again/util/event_bus.dart';
import 'package:tarot_again/util/util.dart';

enum RandomGenerators {
  none(displayName: "Default", genCreator: SecureRandom.new),
  local(displayName: "Device", genCreator: SecureRandom.new);

  // secureRandom(displayName: "Device", genCreator: SecureRandom.new);

  const RandomGenerators({required this.displayName, required this.genCreator});

  final String displayName;
  final IRandomsProvider Function() genCreator;
}

extension RandomInt on int {
  int get random =>
      sl<SignalsManager>().currentRandomProvider.value.nextInt(this - 1);
}

/// The [IRandomsProvider] gives the methods that must be present for any
/// provider of random numbers.
/// All methods are async or async*, because some of the random providers
/// will rely on network calls to retrieve random numbers from online
/// providers.
abstract interface class IRandomsProvider implements Random {
  /// [getNextInt] Returns the next integer from the random number generator, and the
  /// integer will fall within the range provided
  @override
  int nextInt(rangeHigh);

  /// [getNextIntFromCountdown] is useful for shuffling iterables. It provides a
  /// stream of random integers that corresponds to indexes on a shrinking list; each
  /// random number yielded will presumably be used to remove an item from a list, in which
  /// case the list's length will decrease by one for each random int provided. The last
  /// int yielded will always be 0, as the remaining list index will also be 0.
  Iterable<int> nextIntFromCountdown(int rangeHigh);

  @override
  /// [getNextDouble] returns a double in the range >= 0.0 and < 1.0 (according to the documentation for math.Random)
  double nextDouble();

  /// [getNextBool] returns a bool with an equally-weighted probability of true or false.
  @override
  bool nextBool();
}

/// This class is the sole provider of random numbers for this app.
///
/// The actual random number generator
/// used can be swapped between available options, but all calls for random numbers are made through the singleton
/// instance of this class.
@singleton
class RandomsManager with Logging implements IRandomsProvider {
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
    sl<SignalsManager>().currentRandomGenerator.value = RandomGenerators.values
        .firstWhere(
          (elem) => elem.displayName == name,
          orElse: () => RandomGenerators.none,
        );

    final sm = sl<SignalsManager>();

    sm.currentRandomProvider.value = sm.currentRandomGenerator.value
        .genCreator();
  }

  @override
  int nextInt(int rangeHigh) =>
      sl<SignalsManager>().currentRandomProvider.value.nextInt(rangeHigh);

  @override
  Iterable<int> nextIntFromCountdown(int rangeHigh) => sl<SignalsManager>()
      .currentRandomProvider
      .value
      .nextIntFromCountdown(rangeHigh);

  @override
  double nextDouble() =>
      sl<SignalsManager>().currentRandomProvider.value.nextDouble();

  @override
  bool nextBool() =>
      sl<SignalsManager>().currentRandomProvider.value.nextBool();

  Iterable<E> shuffleIterable<E>({required Iterable<E> remaining}) =>
      IList<E>(remaining)
          .shuffle(sl<SignalsManager>().currentRandomProvider.value);
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
  int nextInt(rangeHigh) => secureRandom.nextInt(rangeHigh);

  @override
  Iterable<int> nextIntFromCountdown(int rangeHigh) sync* {
    int currentRange = rangeHigh; // covers the range [0..rangeHigh)

    while (currentRange > 0) {
      yield secureRandom.nextInt(currentRange);

      currentRange = currentRange - 1;
    }

    yield 0;
  }

  @override
  double nextDouble() => secureRandom.nextDouble();

  @override
  bool nextBool() => secureRandom.nextBool();
}
