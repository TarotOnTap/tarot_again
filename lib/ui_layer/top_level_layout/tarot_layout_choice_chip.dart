import 'package:tarot_again/util/flutter_util.dart';
import 'package:tarot_again/util/util.dart';

class TarotLayoutChoiceChip({
  super.key,
  required final HivezPersistedSignal<TarotLayout> signal,
  required final String chipText,
}) extends StatelessWidget with Logging {
  @override
  Widget build(BuildContext context) {
    return SignalBuilder(
      builder: (BuildContext context) => ChoiceChip(
        label: Text(chipText),
        selected: signal.value.displayName == chipText,
        onSelected: (bool selected) {
          if (selected) {
            signal.value = sl<LayoutManager>().getLayoutByDisplayName(chipText);
          }
        },
      ),
    );
  }
}
