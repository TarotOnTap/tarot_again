part of 'card_widget_bloc.dart';

@freezed
abstract class CardWidgetState with _$CardWidgetState {
  // Note to self - the DealtModel card is actually a property
  // of our bloc, rather than changeable state; it is set by the constructor
  // when the CardWidgetBloc is created.
  const factory CardWidgetState({
    @Default(false) bool faceUp,
    @Default(false) bool reversed,
  }) = _CardWidgetState;

  factory CardWidgetState.fromJson(Map<String, Object?> json) =>
      _$CardWidgetStateFromJson(json);
}
