import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:gap/gap.dart';
import 'package:gpt_markdown/gpt_markdown.dart';
import 'package:tarot_again/util/util.dart';

import '../card_widget/card_widget.dart';

class DetailHostWidget extends StatelessWidget {
  final int slotIndex;

  const DetailHostWidget({super.key, required this.slotIndex});

  @override
  Widget build(BuildContext context) => Center(
    child: Column(
      children: [
        Row(
          children: [
            BackButton(onPressed: () => context.goNamed("home")),
            Spacer(),
            CloseButton(onPressed: () => context.goNamed("home")),
          ],
        ),
        Expanded(child: DetailPopupMain(slotIndex: slotIndex)),
      ],
    ),
  );
}

class DetailPopupMain extends StatelessWidget {
  final int slotIndex;

  DetailPopupMain({super.key, required this.slotIndex}) {
    log("DetailPopupMain");
  }

  String _meaning(String orientation, Option<String> meaning) =>
      "## $orientation meaning ${meaning.fold(() => 'undefined', (it) => '\n\n$it')}";

  @override
  Widget build(BuildContext context) =>
      ComputedsManager.slotKeys.value[slotIndex].currentState.letWithElse(
        (PositionSlotWidgetState it) => Center(
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: CardWidget(slotState: it.slotState),
              ),
              Gap(50),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GptMarkdown("# ${it.slotState.deckCard.displayName}"),
                    Gap(20),
                    GptMarkdown(
                      _meaning("Upright", it.slotState.assets.uprightMeaning),
                    ),
                    Gap(100),
                    GptMarkdown(
                      _meaning("Reversed", it.slotState.assets.reversedMeaning),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        orElse: Placeholder(child: Text("Card data not found")),
      );
}
