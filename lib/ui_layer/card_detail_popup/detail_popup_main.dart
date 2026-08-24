import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart' hide State;
import 'package:gpt_markdown/gpt_markdown.dart';
import 'package:tarot_again/util/util.dart';

import '../card_widget/card_widget.dart';

@immutable
class DetailPopupMainWidget extends SignalWidget {
  const DetailPopupMainWidget({super.key, required this.slotIndex});

  final int slotIndex;

  String _meaning(String orientation, Option<String> meaning) =>
      "## $orientation meaning ${meaning.fold(() => 'undefined', (it) => '\n\n$it')}";

  String _displayMd(PositionSlotWidgetState slotData) {
    return "# ${slotData.slotState.deckCard.displayName}\n\n"
        "${_meaning('Upright', slotData.slotState.assets.uprightMeaning)}\n\n"
        "${_meaning('Reversed', slotData.slotState.assets.reversedMeaning)}";
  }

  @override
  Widget build(BuildContext context) {
    return ComputedsManager.slotKeys.value[slotIndex].currentState.letWithElse(
      (PositionSlotWidgetState it) => UnconstrainedBox(
        child: SizedBox(
          width: 800,
          height: 600,
          child: Card(
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
                  // Gap(20),
                  Expanded(
                    child: LayoutBuilder(
                      builder:
                          (
                            BuildContext context,
                            BoxConstraints viewportConstraints,
                          ) => SingleChildScrollView(
                            padding: EdgeInsetsGeometry.only(right: 10.0),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                minHeight: viewportConstraints.maxHeight,
                              ),
                              child: GptMarkdown(_displayMd(it)),
                            ),
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

  // String _meaning(String orientation, Option<String> meaning) =>
  //     "## $orientation meaning ${meaning.fold(() => 'undefined', (it) => '\n\n$it')}";
  //
  // String _displayMd(PositionSlotWidgetState slotData) {
  //   return "# ${slotData.slotState.deckCard.displayName}\n\n"
  //       "${_meaning('Upright', slotData.slotState.assets.uprightMeaning)}\n\n"
  //       "${_meaning('Reversed', slotData.slotState.assets.reversedMeaning)}";
  // }

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) => DetailPopupMainWidget(slotIndex: slotIndex);
  // {
  //   return ComputedsManager.slotKeys.value[slotIndex].currentState.letWithElse(
  //     (PositionSlotWidgetState it) => UnconstrainedBox(
  //       child: SizedBox(
  //         width: 800,
  //         height: 600,
  //         child: Card(
  //           color: Colors.white,
  //           child: Center(
  //             child: Row(
  //               children: [
  //                 Expanded(
  //                   child: Padding(
  //                     padding: EdgeInsets.all(16.0),
  //                     child: CardWidget(slotState: it.slotState),
  //                   ),
  //                 ),
  //                 // Gap(20),
  //                 Expanded(
  //                   child: LayoutBuilder(
  //                     builder:
  //                         (
  //                           BuildContext context,
  //                           BoxConstraints viewportConstraints,
  //                         ) => SingleChildScrollView(
  //                           padding: EdgeInsetsGeometry.only(right: 10.0),
  //                           child: ConstrainedBox(
  //                             constraints: BoxConstraints(
  //                               minHeight: viewportConstraints.maxHeight,
  //                             ),
  //                             child: GptMarkdown(_displayMd(it)),
  //                           ),
  //                         ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //     orElse: Placeholder(child: Text("Card data not found")),
  //   );
  // }
}
