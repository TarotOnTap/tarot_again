// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../data_layer/data_sources/asset_manager/manager.dart' as _i82;
import '../data_layer/data_sources/hive_service/hive_service.dart' as _i544;
import '../data_layer/data_sources/layout_manager/manager.dart' as _i831;
import '../data_layer/data_sources/randoms_provider/types.dart' as _i913;
import '../reactives/computeds_manager.dart' as _i334;
import '../reactives/effects_manager.dart' as _i477;
import '../reactives/hives_signal_key_value_store.dart' as _i529;
import '../reactives/session_manager.dart' as _i950;
import '../reactives/signals_manager.dart' as _i271;
import 'event_bus.dart' as _i909;
import 'util.dart' as _i23;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final eventBusModule = _$EventBusModule();
    await gh.singletonAsync<_i544.HiveService>(
      () => _i544.HiveService.create(),
      preResolve: true,
    );
    gh.singleton<_i831.LayoutManager>(() => _i831.LayoutManager());
    gh.singleton<_i913.AsyncRandoms>(() => _i913.AsyncRandoms());
    gh.singleton<_i271.SignalsManager>(() => _i271.SignalsManager());
    gh.singleton<_i909.EventBus>(() => eventBusModule.eventBus);
    await gh.singletonAsync<_i82.AssetManager>(
      () => _i82.AssetManager.create(gh<_i23.HiveService>()),
      preResolve: true,
    );
    gh.singleton<_i529.HivezPersistedPreferencesStore>(
      () => _i529.HivezPersistedPreferencesStore(gh<_i23.HiveService>()),
    );
    gh.singleton<_i334.ComputedsManager>(
      () => _i334.ComputedsManager(signalsManager: gh<_i23.SignalsManager>()),
    );
    gh.singleton<_i477.EffectsManager>(
      () => _i477.EffectsManager(
        signalsManager: gh<_i23.SignalsManager>(),
        computedsManager: gh<_i23.ComputedsManager>(),
      ),
    );
    gh.singleton<_i950.SessionManager>(
      () => _i950.SessionManager(
        signalsManager: gh<_i23.SignalsManager>(),
        computedsManager: gh<_i23.ComputedsManager>(),
      ),
    );
    return this;
  }
}

class _$EventBusModule extends _i909.EventBusModule {}
