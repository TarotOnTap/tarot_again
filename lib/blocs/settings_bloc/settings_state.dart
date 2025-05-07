part of 'settings_bloc.dart';

@freezed
sealed class SettingsState with _$SettingsState {
  const factory SettingsState.initial({@Default(true) bool needsOnboarding}) =
      SettingsStateInitial;

  const factory SettingsState.settingsStateReady({
    @Default(false) bool blockGlobalAnimations,
    @Default(false) bool blockCardBackAnimations,
  }) = SettingsStateReady;

  factory SettingsState.fromJson(Map<String, dynamic> json) =>
      _$SettingsStateFromJson(json);
}
