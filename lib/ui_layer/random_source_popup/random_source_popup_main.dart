import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
// import 'package:gpt_markdown/gpt_markdown.dart';
import 'package:tarot_again/util/util.dart';

// import '../card_widget/card_widget.dart';

class RandomSourcePopupMain<T> extends PopupRoute<T> {
  @override
  Color? get barrierColor => Colors.black.withAlpha(0x50);

  // This allows the popup to be dismissed by tapping the scrim or by pressing
  // the escape key on the keyboard.
  @override
  bool get barrierDismissible => true;

  @override
  bool get fullscreenDialog => false;

  @override
  String? get barrierLabel => 'Dismissible Dialog';

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);

  RandomSourcePopupMain({
    super.settings,
    super.requestFocus,
    super.filter,
    super.traversalEdgeBehavior,
    super.directionalTraversalEdgeBehavior,
  });

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) => UnconstrainedBox(
    child: Container(
      // color: Colors.white,
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Select a source of randomness",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Gap(10.0),
            /* Expanded(
              child: */
            Wrap(
              spacing: 5.0,
              children: List<Widget>.generate(RandomGenerators.values.length, (
                int index,
              ) {
                return ChoiceChip(
                  label: Text(RandomGenerators.values[index].displayName),
                  selected:
                      SignalsManager.currentRandomGenerator.value.index ==
                      index,
                  onSelected: (bool selected) {
                    SignalsManager.currentRandomGenerator.value =
                        RandomGenerators.values[index];
                  },
                );
              }).toList(),
            ),
            /* ), */
          ],
        ),
      ),
    ),
    /* ), */
    /* ), // sizedBox */
  );
}
