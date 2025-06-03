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

abstract class PostInit {
  // each singleton may have a function postInit that will be invoked after
  // the singleton is initialized. This allows all of the singletons to be
  // registered with get it and initialized, to avoid references to
  // uncreated objects.
  // Subclass' postInit functions should invoke super.postInit() as the last item
  // in their own postInit functions.
  Future<void> postInit();
}

abstract class ReactiveState {}

class Manager<R extends ReactiveState> with Logging {
  final R reactives = sl<R>();
}
