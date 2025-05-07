import 'package:tarot_again/util/util.dart';

part 'settings_bloc.freezed.dart';
part 'settings_bloc.g.dart';
part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends HydratedBloc<SettingsEvent, SettingsState>
    with Logging {
  SettingsBloc._() : super(SettingsState.initial());

  @override
  SettingsState? fromJson(Map<String, dynamic> json) =>
      SettingsState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(SettingsState state) => state.toJson();

  factory SettingsBloc() {
    if (!sl.isRegistered<SettingsBloc>()) {
      sl.registerSingleton<SettingsBloc>(SettingsBloc._());
    }

    return sl<SettingsBloc>();
  }
}
