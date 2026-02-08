import 'util.dart';

/// extension [RangeGen] on [int]
/// very simple extension, with one method.
extension RangeGen on int {
  /// [range] is a generator that produces values from 0 up to the int it's applied to.
  /// it's useful replacing a for (var i=0; i<someInt; i++) (and that's all its useful for)
  Iterable<int> get range sync* {
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

// class Manager<R extends ReactiveState> with Logging {
//   final R reactives = sl<R>();
// }

class ImmutableSignal<T> extends Signal<T> with TrackedSignalMixin<T> {
  ImmutableSignal(super.value, {super.debugLabel}) {
    effect(() => log("  previous value is $this.previousValue"));
  }
}

ImmutableSignal<T> immutableSignal<T>(T value, {String? debugLabel}) =>
    ImmutableSignal<T>(value, debugLabel: debugLabel);

/// a local interface that indicates that the class has the necessary equipment to
/// convert itself to json, and to be revived from json.
/// note that the factory function fromJson is not actually enforced *at all*
/// by the dart compiler.
/// This interface should be added to any class marked
/// with @freezed or @JsonSerializable, or that implements these methods on its
/// own hooks.
/// This is used by the Settings module shared_preferences storage mechanism,
/// where it's used to indicate that a non-supported class should be converted
/// to/from a String using these methods.
abstract interface class Jsonable {
  Map<String, dynamic> toJson();

  factory Jsonable.fromJson(Map<String, dynamic> json) {
    throw UnimplementedError();
  }
}
