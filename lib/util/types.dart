import 'util.dart';

/// extension [RangeGen] on [int]
/// very simple extension, with one method.
extension RangeGen on int {
  /// [range] is a generator that produces values from 0 up to the int it's applied to.
  /// it's useful replacing a for (var i=0; i<someInt; i++) (and that's all its useful for)
  Iterable<int> range() sync* {
    for (var i = 0; i < this; i++) {
      yield i;
    }
  }
}

extension RepeatGen<E> on int {
  Iterable<E> repeat(E Function(int) block) sync* {
    for (var i = 0; i < this; i++) {
      yield block(i);
    }
  }
}

// shamelessly stolen, with gratitude, from quiver.iterable
Iterable<List<T>> zipIt<T>(Iterable<Iterable<T>> iterables) sync* {
  if (iterables.isEmpty) return;
  final iterators = iterables.map((e) => e.iterator).toList(growable: false);
  while (iterators.every((e) => e.moveNext())) {
    yield iterators.map((e) => e.current).toList(growable: false);
  }
}

abstract class Singleton {
  /// This constructor does one thing - it registers the newly created instance of this
  /// type with GetIt.  This has the potential to be messy if the constructor is called
  /// more than once, so don't.
  static void selfRegister() {}
}

abstract class ReactiveState {}

class Manager<R extends ReactiveState> with Logging {
  final R reactives = sl<R>();
}
