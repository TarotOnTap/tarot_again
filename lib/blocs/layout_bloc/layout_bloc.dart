import 'package:tarot_again/data_layer/data_layer.dart';
import 'package:tarot_again/util/util.dart';

part 'layout_bloc.freezed.dart';
part 'layout_bloc.g.dart';
part 'layout_event.dart';
part 'layout_state.dart';

class LayoutBloc extends HydratedBloc<LayoutEvent, LayoutState> with Logging {
  late final LayoutRepository layoutRepository;

  LayoutBloc._() : super(const LayoutState.initial()) {
    layoutRepository = sl<LayoutRepository>();

    on<Starting>((event, emit) async {
      emit(state.copyWith(layoutNames: layoutRepository.listLayouts));
    });

    on<SetNewLayout>((SetNewLayout event, emit) {
      final layoutNames = layoutRepository.layoutDisplayNames;
      final TarotLayout layout = layoutRepository.getLayoutByDisplayName(
        event.newLayout,
      );

      emit(
        LayoutState.layoutStateReadyToDeal(
          currentLayoutName: event.newLayout,
          currentLayout: layout,
          layoutNames: layoutNames,
        ),
      );
    });

    add(LayoutEvent.starting());
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
