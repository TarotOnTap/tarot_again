import 'package:tarot_again/blocs/blocs.dart';
import 'package:tarot_again/util/util.dart';

class LayoutRepository {
  late final BulkCardControlBloc bccBloc;

  LayoutRepository() {
    bccBloc = sl<BulkCardControlBloc>();
  }
}
