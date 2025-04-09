import 'package:tarot_again/util/util.dart';

import 'bulk_card_control_bloc/bulk_card_control_bloc.dart';
import 'layout_bloc/layout_bloc.dart';

Future<void> initializeBlocs() async {
  await BulkCardControlBloc.initialize();

  await LayoutBloc.initialize();
}
