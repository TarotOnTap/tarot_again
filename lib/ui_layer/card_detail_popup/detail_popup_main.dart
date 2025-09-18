import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart' hide State;
import 'package:gap/gap.dart';
import 'package:gpt_markdown/gpt_markdown.dart';
import 'package:tarot_again/util/util.dart';

import '../card_widget/card_widget.dart';

class DetailHostWidget extends StatefulWidget {
  final int slotIndex;
  late final Duration _duration;

  DetailHostWidget({super.key, required this.slotIndex, double? duration}) {
    duration = duration ?? 0.3;
    _duration = Duration(milliseconds: (duration * 1000).toInt());
  }

  @override
  State<DetailHostWidget> createState() => _DetailHostWidgetState();
}

class _DetailHostWidgetState extends State<DetailHostWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late DetailPopupMain _popup;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this, // the SingleTickerProviderStateMixin
      duration: widget._duration,
    );

    _popup = DetailPopupMain(slotIndex: widget.slotIndex);
  }

  @override
  void didUpdateWidget(DetailHostWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _controller.duration = widget._duration;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _popup.buildPage(context, _controller, _controller);
  }
}

class DetailPopupMain<T> extends PopupRoute<T> {
  final int slotIndex;

  @override
  Color? get barrierColor => Colors.black.withAlpha(0x50);

  // This allows the popup to be dismissed by tapping the scrim or by pressing
  // the escape key on the keyboard.
  @override
  bool get barrierDismissible => true;

  @override
  String? get barrierLabel => 'Dismissible Dialog';

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);

  DetailPopupMain({
    super.settings,
    super.requestFocus,
    super.filter,
    super.traversalEdgeBehavior,
    super.directionalTraversalEdgeBehavior,
    required this.slotIndex,
  });

  // DetailPopupMain({super.key, required this.slotIndex}) {
  //   log("DetailPopupMain");
  // }

  String _meaning(String orientation, Option<String> meaning) =>
      "## $orientation meaning ${meaning.fold(() => 'undefined', (it) => '\n\n$it')}";

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) => ComputedsManager.slotKeys.value[slotIndex].currentState.letWithElse(
    (PositionSlotWidgetState it) => UnconstrainedBox(
      child: SizedBox(
        width: 800,
        height: 600,
        child: Container(
          // TODO: turn this container into a material Card? It might look better.
          color: Colors.white,
          child: Center(
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: CardWidget(slotState: it.slotState),
                  ),
                ),
                Gap(50),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: GptMarkdown(
                            "# ${it.slotState.deckCard.displayName}",
                          ),
                        ),
                        Gap(20),
                        Expanded(
                          child: GptMarkdown(
                            _meaning(
                              "Upright",
                              it.slotState.assets.uprightMeaning,
                            ),
                          ),
                        ),
                        Gap(100),
                        Expanded(
                          child: GptMarkdown(
                            _meaning(
                              "Reversed",
                              it.slotState.assets.reversedMeaning,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
    orElse: Placeholder(child: Text("Card data not found")),
  );
}
