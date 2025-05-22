import 'package:tarot_again/data_layer/repositories/types.dart';
import 'package:tarot_again/managers/session_manager/types.dart';
import 'package:tarot_again/util/util.dart';

class LayoutRepository extends SingletonRepository {
  final LoggingSignal<TarotLayout> tarotLayout = loggingSignal<TarotLayout>(
    TarotLayout.nullLayout(),
    name: "tarotLayout",
  );

  TarotLayout getLayoutByLayoutName(String name) =>
      sl<LayoutProvider>().layoutsByName.value[name] ??
      TarotLayout.nullLayout(displayName: "No Such Layout");

  void setLayoutByLayoutName(String name) =>
      tarotLayout.value = getLayoutByLayoutName(name);

  TarotLayout getLayoutByDisplayName(String displayName) =>
      sl<LayoutProvider>().layoutsByDisplayName.value[displayName] ??
      TarotLayout.nullLayout(displayName: "No Such Layout");

  void setLayoutByDisplayName(String displayName) =>
      tarotLayout.value = getLayoutByDisplayName(displayName);
}
