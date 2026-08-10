export 'computeds_manager.dart';
export 'effects_manager.dart';
export 'future_signals_manager.dart';
export 'hivez_persisted_signal.dart';
export 'session_manager.dart';
export 'signals_manager.dart';
export 'slot_state.dart';
export 'types.dart';

// @module
// abstract class ReactivesModule {
//   @singleton
//   SignalsManager get signalsManager =>
//       SignalsManager(appSettings: sl<AppSettings>());
//
//   @singleton
//   ComputedsManager get computedsManager =>
//       ComputedsManager(signalsManager: sl<SignalsManager>());
//
//   @singleton
//   EffectsManager get effectsManager => EffectsManager(
//     signalsManager: sl<SignalsManager>(),
//     computedsManager: sl<ComputedsManager>(),
//   );
//
//   @singleton
//   SessionManager get sessionManager => SessionManager(
//     signalsManager: signalsManager,
//     computedsManager: computedsManager,
//   );
// }
