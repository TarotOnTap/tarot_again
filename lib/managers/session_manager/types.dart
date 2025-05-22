import 'package:tarot_again/util/util.dart';

part 'types.freezed.dart';
part 'types.g.dart';

class LoggingSignal<T> extends Signal<T> with TrackedSignalMixin<T>, Logging {
  final String? name;

  LoggingSignal(
    super.value, {
    this.name,
    super.debugLabel,
    super.autoDispose = false,
  }) {
    verbose("LoggingSignal constructor; name is $name");
    subscribe((v) => verbose("Signal $name changed from $previousValue to $v"));
  }
}

LoggingSignal<T> loggingSignal<T>(
  T value, {
  String? name,
  String? debugLabel,
  bool autoDispose = false,
}) => LoggingSignal<T>(
  value,
  name: name,
  debugLabel: debugLabel,
  autoDispose: autoDispose,
);

class LoggingComputed<T> extends Computed<T>
    with TrackedSignalMixin<T>, Logging {
  final String? name;

  LoggingComputed(
    super.fn, {
    this.name,
    super.debugLabel,
    super.autoDispose = false,
  }) {
    verbose("LoggingComputed constructor; name is $name");
    subscribe(
      (v) => verbose("Computed $name changed from $previousValue to $v"),
    );
  }
}

LoggingComputed<T> loggingComputed<T>(
  T Function() fn, {
  String? name,
  String? debugLabel,
  bool autoDispose = false,
}) => LoggingComputed<T>(
  fn,
  name: name,
  debugLabel: debugLabel,
  autoDispose: autoDispose,
);

@JsonEnum()
enum StandardTarotDecksEnum {
  rws(displayName: "RWS");

  const StandardTarotDecksEnum({required this.displayName});

  final String displayName;
}

@JsonEnum()
enum DeckTypesEnum {
  standardTarot(displayName: "Standard Tarot"),
  standardPlayingCards(displayName: "Standard Playing Cards");

  const DeckTypesEnum({required this.displayName});

  final String displayName;
}

@freezed
sealed class SlotState with _$SlotState {
  const factory SlotState.notDealt({
    required int slotIndex,
    @Default("") String slotName,
  }) = SlotStateNotDealt;

  // const factory SlotState.dealt({
  //   required int slotIndex,
  //   @Default("") String slotName,
  //   required bool faceUp,
  //   required DealtCard card,
  // }) = SlotStateDealtNoAssets;

  const factory SlotState.dealt({
    required int slotIndex,
    @Default("") String slotName,
    required bool faceUp,
    required DealtCard card,
    @JsonKey(includeFromJson: false, includeToJson: false) AssetGenImage? image,
    @JsonKey(includeFromJson: false, includeToJson: false) String? description,
    @JsonKey(includeFromJson: false, includeToJson: false)
    String? uprightMeaning,
    @JsonKey(includeFromJson: false, includeToJson: false)
    String? reversedMeaning,
  }) = SlotStateDealt;

  factory SlotState.fromJson(Map<String, dynamic> json) =>
      _$SlotStateFromJson(json);
}
