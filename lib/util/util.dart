import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:watch_it/watch_it.dart';

export 'dart:async';

export 'package:async/async.dart';
export 'package:change_case/change_case.dart';
export 'package:equatable/equatable.dart';
export 'package:fast_immutable_collections/fast_immutable_collections.dart';
export 'package:flutter_bloc/flutter_bloc.dart';
// export 'package:fpdart/fpdart.dart';
export 'package:freezed_annotation/freezed_annotation.dart';
export 'package:hydrated_bloc/hydrated_bloc.dart';
export 'package:json_annotation/json_annotation.dart';
export 'package:meta/meta.dart';
export 'package:path_provider/path_provider.dart';
export 'package:tarot_again/gen/assets.gen.dart';
export 'package:watch_it/watch_it.dart';

export 'logging.dart';

AsyncSnapshot<BlocStateType>
watchBloc<BlocType extends BlocBase, BlocStateType>(
  BlocType Function(BlocType)? select, {
  BlocType? bloc,
  BlocStateType? initialState,
  bool preserveState = true,
  String? instanceName,
  GetIt? getIt,
}) {
  BlocType targetBloc;

  if (select != null) {
    targetBloc = di<BlocType>();
  } else {
    targetBloc = bloc!;
  }

  return watchStream(
    null,
    target: targetBloc.stream,
    initialValue: initialState ?? targetBloc.state,
    preserveState: preserveState,
    instanceName: instanceName,
    getIt: getIt,
  );
}
