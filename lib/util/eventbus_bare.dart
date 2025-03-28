/// This file creates the bare bones functionality.
/// It does not depend on get_it or watch_it packages.
/// use these functions in plain dart apps.
///
import 'dart:async';
import 'package:event_bus/event_bus.dart';

export "package:event_bus/event_bus.dart";

// This variable is a handy way to make the event bus available globally.
EventBus eventBus = EventBus();

Stream<T> getEventBusStream<T>([ bool Function(T)? filter ]) {
  // this global function does not rely on WatchIt for functionality.

  // Use this function to receive events of a particular type T from the event bus.
  // Optionally, filter those events with a function that returns true to emit the
  // event or false to drop the event.
  // To receive all events, don't supply a type T - event bus will give the
  // stream everything it receives.

  Stream<T> s = eventBus.on<T>();

  return filter != null ? s.where((T event) => filter(event)) : s;
}


// this global function does not rely on WatchIt for functionality.

// supply a void handler function that takes an event of type T, optionally filters it
// with a boolean function that also takes an event of type T, and passes
// any events that come through the filter to the handler.

// example:

// HitEm is the message that gets sent from elsewhere in the app, perhaps a
// button in the UI. The message is created to contain the name of the target.
// @immutable
// class HitEm {
//   final String name;
//
//   HitEm(this.name);
// }
//
// here is the class that receives the message
// class Bludgeon {
//   String _bludgeon = "by your command...";

//   void _hit(HitEm message) {
//     _bludgeon = "Hitting ${message.name}!"
//     print(_bludgeon);
//
//   Bludgeon() {
//     receiveEvents<HitEm>(_hit);
//   }
//
// elsewhere in the app...
// eventBus.fire(HitEm("Jonathan"));
//
// the return value of the function is a StreamSubscription - retain this result
// if you want to be able to cancel the receiving stream. Otherwise, you can
// just drop the value on the floor and let the garbage collector handle it.
StreamSubscription<T> receiveEvents<T>({
  required void Function(T event) onData,
  bool Function(T)? filter,
}) => getEventBusStream<T>(filter).listen(onData);