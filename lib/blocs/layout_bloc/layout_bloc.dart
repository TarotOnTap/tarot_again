import 'package:tarot_again/data_layer/data_layer.dart';
import 'package:tarot_again/util/util.dart';

part 'layout_bloc.freezed.dart';
part 'layout_bloc.g.dart';
part 'layout_event.dart';
part 'layout_state.dart';

class LayoutBloc extends HydratedBloc<LayoutEvent, LayoutState> {
  LayoutBloc() : super(const LayoutState.initial()) {
    on<LayoutEvent>((event, emit) {
      // TODO: implement event handler
    });
  }

  @override
  LayoutState? fromJson(Map<String, dynamic> json) =>
      LayoutState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(LayoutState state) => state.toJson();

  static Future<void> initialize() async {
    if (!sl.isRegistered<LayoutBloc>()) {
      sl.registerSingleton(LayoutBloc());
    }
  }
}
