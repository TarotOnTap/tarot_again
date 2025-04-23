import 'package:tarot_again/blocs/blocs.dart';
import 'package:tarot_again/data_layer/data_layer.dart';
import 'package:tarot_again/util/util.dart';

part 'layout_bloc.freezed.dart';
part 'layout_bloc.g.dart';

/// layout_event contains all of the events for this bloc
part 'layout_event.dart';

/// layout_state contains state for this bloc
part 'layout_state.dart';

class LayoutBloc extends HydratedBloc<LayoutEvent, LayoutState> with Logging {
  late final LayoutRepository layoutRepository;

  LayoutBloc._() : super(const LayoutState()) {
    layoutRepository = sl<LayoutRepository>();

    on<LayoutStarting>((event, emit) async {
      await layoutRepository.cacheLayouts();

      emit(state.copyWith(layoutNames: layoutRepository.layoutDisplayNames));
    });

    on<SetNewLayout>((SetNewLayout event, emit) {
      verbose("received SetNewLayout, ${event.newLayout}");

      final TarotLayout layout = layoutRepository.getLayoutByDisplayName(
        event.newLayout,
      );
      verbose("  layout is $layout after lookup.");

      emit(
        state.copyWith(
          currentLayoutName: event.newLayout,
          currentLayout: layout,
        ),
      );
    });

    on<DealCards>((event, emit) {
      verbose("on<DealCards> handler");
    });

    add(LayoutStarting());
  }

  @override
  LayoutState? fromJson(Map<String, dynamic> json) =>
      LayoutState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(LayoutState state) => state.toJson();

  factory LayoutBloc() {
    if (!sl.isRegistered<LayoutBloc>()) {
      sl.registerSingleton<LayoutBloc>(LayoutBloc._());
    }

    return sl<LayoutBloc>();
  }
}
