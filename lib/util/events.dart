import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

export 'package:meta/meta.dart' show immutable;

// the messages for the TarotAgain app, plus the base of all MessageEvents.
@immutable
class MessageEvent extends Equatable {
  // some messages are sent by the app itself, without needing a source.
  // In those cases, the sender may be null.
  // if you're expecting a reply, make sure to create or copyWith using sender: this
  // could also, conceivably, use the sender field as a "reply to" if you want the
  // response message to go to a particular object that is expecting it.
  final Object? sender;

  const MessageEvent({this.sender});

  MessageEvent copyWith({Object? sender}) =>
      MessageEvent(
          sender: sender ?? this.sender
      );
  @override
  List<Object?> get props => [ sender ];
}

@immutable
class ResponseEvent extends MessageEvent {
  final MessageEvent? responseTo;

  const ResponseEvent({super.sender, this.responseTo});

  @override
  ResponseEvent copyWith({Object? sender, MessageEvent? responseTo}) =>
      ResponseEvent(sender: sender ?? this.sender, responseTo: responseTo ?? this.responseTo);

  @override
  List<Object?> get props => [ sender, responseTo ];
}

// messages for the top-level app and major pieces to use are defined here
@immutable
sealed class SystemMessage extends MessageEvent {
  const SystemMessage({super.sender});
}

@immutable
class InitializeApp extends SystemMessage {
  const InitializeApp({super.sender});
}

@immutable
class AppInitialized extends ResponseEvent {
  const AppInitialized({super.sender, super.responseTo});
}

@immutable
sealed class SystemCheckIn extends SystemMessage {
  const SystemCheckIn({super.sender});
}

@immutable
class AllDataSourcesCheckIn extends SystemCheckIn {
  const AllDataSourcesCheckIn({super.sender});
}

@immutable
class AllRepositoriesCheckIn extends SystemCheckIn {
  const AllRepositoriesCheckIn({super.sender});
}

@immutable
class AllBlocsCheckIn extends SystemCheckIn {
  const AllBlocsCheckIn({super.sender});
}

@immutable
sealed class SystemCheckInResponse extends ResponseEvent {
  const SystemCheckInResponse({super.sender, super.responseTo});
}

@immutable
class DataSourcesCheckInResponse extends SystemCheckInResponse {
  const DataSourcesCheckInResponse({super.sender, super.responseTo});
}

@immutable
class RepositoriesCheckInResponse extends SystemCheckInResponse {
  const RepositoriesCheckInResponse({super.sender, super.responseTo});
}

@immutable
class BlocsCheckInResponse extends SystemCheckInResponse {
  const BlocsCheckInResponse({super.sender, super.responseTo});
}