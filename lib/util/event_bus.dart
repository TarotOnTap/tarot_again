import 'package:event_bus/event_bus.dart';
import 'package:flutter/widgets.dart';

import 'util.dart';

export "package:event_bus/event_bus.dart";

final EventBus eventBus = EventBus();

void createEventBus() {
  if (!sl.isRegistered<EventBus>()) {
    sl.registerSingleton<EventBus>(eventBus);
  }
}

class InflateEvent<T> {}

void createInflator<T extends Object>(T Function() createFunc) {
  if (!sl.isRegistered<T>()) {
    sl.registerLazySingleton<T>(() => createFunc());

    eventBus.on<InflateEvent<T>>().listen((event) {
      sl<T>();
    });
  }
}

// @immutable
// class EventBusWidget<EventType> extends WatchingWidget {
//   final Widget child;
//   final bool Function(EventType)? updateIf;
//
//   const EventBusWidget({super.key, this.updateIf, required this.child});
//
//   @override
//   Widget build(BuildContext context) {
//     final asyncData = watchStream((EventType t) {
//       final temp = updateIf;
//       bool doUpdate = true;
//
//       if (temp != null) {
//         doUpdate = temp(t);
//       }
//
//       if (doUpdate) {
//         return child.
//       }
//     });
//   }
// }

// di is provided by the WatchIt package, and is simply a reference to
// GetIt.I<T>();

// This variable is a handy way to make the event bus available globally, assuming
// that EventBus has been created and registered with GetIt previously.

// global functions that make it easy to use EventBus

// NB - these functions are not, at this point, functional/fpdart coded. Mostly,
// this is because flutter isn't really set up to handle that. Part of my investigation
// in this app is to see if functional types *can* be incorporated into flutter.

// The first two, getEventBusStream and receiveEvents, are not used in flutter
// and could be switched over to fpdart types

Stream<T> getEventBusStream<T>([bool Function(T)? filter]) {
  // this global function does not rely on WatchIt for functionality.

  // Use this function to receive events of a particular type T from the event bus.
  // Optionally, filter those events with a function that returns true to emit the
  // event or false to drop the event.
  // To receive all events, don't supply a type T - event bus will give the
  // stream everything it receives.

  Stream<T> s = eventBus.on<T>();

  return filter != null ? s.where((T event) => filter(event)) : s;
}

StreamSubscription<T> receiveEvents<T>({
  // this global function does not rely on WatchIt for functionality.

  // supply a void handler function that takes an event of type T, optionally filters it
  // with a boolean function that also takes an event of type T, and passes
  // any events that come through the filter to the handler.
  required void Function(T event) onData,
  bool Function(T)? filter,
}) => getEventBusStream<T>(filter).listen(onData);

T awaitEvent<T>(T initial, [bool Function(T)? filter]) {
  // this global function DOES rely on WatchIt for functionality.

  // this is useful for building widgets, among other things.  See the WatchIt
  // package for details on how that works for the watchStream function.

  // awaitEvent returns the data that was passed into the stream
  AsyncSnapshot<T> snapshot = AsyncSnapshot<T>.nothing();

  snapshot = watchStream<EventBus, T>(
    (_) => getEventBusStream<T>(filter),
    initialValue: initial,
  );

  return snapshot.data as T;
}

/// [watchEvents] is useful
AsyncSnapshot<T> watchEvents<T>(T initial, [bool Function(T)? filter]) =>
// this global function DOES rely on WatchIt for functionality
watchStream<EventBus, T>(
  (EventBus item) => getEventBusStream<T>(filter),
  initialValue: initial,
);
