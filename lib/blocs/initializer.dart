import 'package:tarot_again/util/util.dart';

import 'bulk_card_control_bloc/bulk_card_control_bloc.dart';

Future<void> initializeBlocs() async {
  initializeBulkCardControlBloc();

  return Future<void>.value();
}
