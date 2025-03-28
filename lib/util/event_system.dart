import 'package:meta/meta.dart';
import 'package:async/async.dart';
import 'package:event_bus/event_bus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'dart:async';
import 'package:watch_it/watch_it.dart';


// this is the base class for all of the messages to be passed on the event
// bus.
// Messages are immutable and Equatable.

@immutable
class MessageEvent extends Equatable {
  final Object sender;

  const MessageEvent({required this.sender});

  MessageEvent copyWith({Object? sender}) =>
    MessageEvent(sender: sender ?? this.sender);

  @override
  List<Object> get props => [ sender ];
}

extension EventMessages on Object {
  void eventSend(MessageEvent message) => di<EventBus>().fire(message);

  // convenience function - any object can receive events  by using onEvent,
  // like
  //
  // sealed class BusinessEvents extends MessageEvent {
  //   BusinessEvents({ required super.sender });
  //
  //   List<Object> get props => [ ...super.props ];
  // }
  //
  // class SellStuff extends BusinessEvents {
  //   final int howMuch;
  //   final String whatKind;
  //
  // class Business {
  //   // this bit is optional
  //   late final StreamSubscription handlerSubscription;
  //
  //   void sellStuff(SellStuff v) { // do some work here to keep track of
  //   // inventory and stuff
  //   }
  //
  //   void sellBigStuff(SellStuff v) { // handle a rilly rilly big order }
  //
  //   Business() {
  //     // if you don't need to cancel the subscription later,
  //     // you could just use
  //     // onEvent<SellStuff>(sellStuff)
  //     handlerSubscription = onEvent<SellStuff>(sellStuff);
  //
  //     // this one uses a filter function to trigger a different handler for
  //     // the same kind of event.
  //     // set up just the way this is, the first handler will be called
  //     // for every SellStuff event, and the second handler will *also* be
  //     // called on orders with more than 500 items.
  //     // If you want to make it so one or the other is called, use something
  //     // onEvent<SellStuff>(sellStuff, (SellStuff event) => event.howMany <= 500);
  //     // for the first handler.
  //     onEvent<SellStuff>(sellBigStuff, (SellStuff event) => event.howMany > 500);
  //   }
  // }
  StreamSubscription<T> onEvent<T extends MessageEvent>({
    required void Function(T event) onData,
    bool Function(T)? filter,
  }) => getEventBusStream<T>(filter).listen(onData);
}

class EventSystem {
  late final StreamQueue eventBusQueue;
  EventSystem() {
    if (!di.isRegistered<EventBus>()) {
      di.registerSingleton<EventBus>(EventBus());
    }

    eventBusQueue = StreamQueue(di<EventBus>().streamController.stream);

    if (!di.isRegistered<EventSystem>()) {
      di.registerSingleton<EventSystem>(this);
    }
  }
}

// The four functions below are set up so that they only receive messages derived
// from MessageEvent.  If you want to catch other kinds of events, use di<EventBus>()
// directly in order to pass any objects at all along the event bus.
// MessageEvent is for use between app services that need to know the identity of
// the sender.
Stream<T> getEventBusStream<T extends MessageEvent>([ bool Function(T)? filter ]) {
  // Use this function to receive events of a particular type T from the event bus.
  // Optionally, filter those events with a function that returns true to emit the
  // event or false to drop the event.
  // To receive all events, don't supply a type T - event bus will give the
  // stream everything it receives.

  Stream<T> s = di<EventBus>().on<T>();

  return filter != null ? s.where((T event) => filter(event)) : s;
}

// supply a void handler function that takes an event of type T, optionally filters it
// with a boolean function that also takes an event of type T, and passes
// any events that come through the filter to the handler.
//
// the return value of the function is a StreamSubscription - retain this result
// if you want to be able to cancel the receiving stream. Otherwise, you can
// just drop the value on the floor and let the garbage collector handle it.
StreamSubscription<T> receiveEvents<T  extends MessageEvent>({
  required void Function(T event) onData,
  bool Function(T)? filter,
}) => getEventBusStream<T>(filter).listen(onData);


/// These functions can be used inside of Widget builders to keep an eye on
/// the EventBus stream
///

// the event bus *does not* need to be registered with GetIt to use these functions.
T awaitEvent<T extends MessageEvent>(T initial, [ bool Function(T)? filter ]) {
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
AsyncSnapshot<T> watchEvents<T  extends MessageEvent>(T initial, [ bool Function(T)? filter ]) =>
    watchStream<EventBus, T>((EventBus item) => getEventBusStream<T>(filter),
        initialValue:  initial);