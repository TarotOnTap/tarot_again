import 'package:flutter/material.dart';
import 'package:tarot_again/blocs/blocs.dart';
import 'package:tarot_again/data_layer/data_layer.dart';
import 'package:tarot_again/util/util.dart';

part 'layout_bloc.freezed.dart';
part 'layout_bloc.g.dart';

/// layout_event contains all of the events for this bloc
part 'layout_event.dart';

/// layout_state contains state for this bloc
part 'layout_state.dart';

/// extension [RangeGen] on [int]
/// very simple extension, with one method.
extension RangeGen on int {
  /// [range] is a generator that produces values from 0 up to the int it's applied to.
  /// it's useful replacing a for (var i=0; i<someInt; i++) (and that's all its useful for)
  Iterable<int> range() sync* {
    for (var i = 0; i < this; i++) {
      yield i;
    }
  }
}

class LayoutBloc extends HydratedBloc<LayoutEvent, LayoutState> with Logging {
  late final LayoutRepository layoutRepository;

  LayoutBloc._() : super(const LayoutState()) {
    layoutRepository = sl<LayoutRepository>();

    on<SetLayoutNames>(
      (event, emit) => emit(
        state.copyWith(layoutNames: IList<String>(event.newLayoutNames)),
      ),
    );

    on<SetNewLayout>((SetNewLayout event, emit) {
      verbose("received SetNewLayout, ${event.newLayout}");

      final TarotLayout layout = layoutRepository.getLayoutByDisplayName(
        event.newLayout,
      );

      emit(
        state.copyWith(
          currentLayoutName: event.newLayout,
          currentLayout: layout,
        ),
      );
    });
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
