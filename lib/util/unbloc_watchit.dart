import "package:flutter/material.dart";
import "package:watch_it/watch_it.dart";

import "unbloc_bare.dart";

/// These functions can be used inside of Widget builders to keep an eye on
/// the EventBus stream
///

// the event bus *does not* need to be registered with GetIt to use these functions.
T awaitEvent<T>(T initial, [ bool Function(T)? filter ]) {
  // this global function DOES rely on WatchIt for functionality.

  // this is useful for building widgets, among other things.  See the WatchIt
  // package for details on how that works for the watchStream function.

  // awaitEvent returns the data that was passed into the stream
  AsyncSnapshot<T> snapshot = AsyncSnapshot<T>.nothing();

  snapshot = watchStream<EventBus, T>((_) => getEventBusStream<T>(filter),
      initialValue: initial
  );

  return snapshot.data as T;
}

// use only inside the build function of a widget that extends WatchingStatelessWidget
// or WatchingStatefulWidget, or uses the WatchItMixin or WatchItStatefulWidgetMixin
AsyncSnapshot<T> watchEvents<T>(T initial, [ bool Function(T)? filter ]) =>
    watchStream<EventBus, T>((EventBus item) => getEventBusStream<T>(filter),
    initialValue:  initial);