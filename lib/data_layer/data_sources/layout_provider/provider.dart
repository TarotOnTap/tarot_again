import 'package:tarot_again/data_layer/data_layer.dart';
import 'package:tarot_again/util/util.dart';

/// Layouts are assets that describe how many cards are needed, and where to
/// locate those cards on the screen, they also provide information on the meanings
/// of the slots.
/// Inside a layout, a card (DealtCard) will be assigned to each layout slot by
/// the LayoutRepository - not here.
///

class LayoutProvider extends BaseProvider with Logging {
  Layout? currentLayout;

  LayoutProvider();

  static Future<void> initialize() async {
    if (!sl.isRegistered<LayoutProvider>()) {
      sl.registerSingleton<LayoutProvider>(LayoutProvider());
    }
  }

  Future<Layout> loadLayout(String layoutName) async {
    return Future<Layout>.value(Layout.nullLayout()); // placeholder value
  }
}
