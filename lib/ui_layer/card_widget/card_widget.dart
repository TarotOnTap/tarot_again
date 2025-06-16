import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tarot_again/ui_layer/card_widget/tc_arcana_widget.dart';
import 'package:tarot_again/util/util.dart';

export 'position_slot_widget.dart';

// part 'deck_empty_widget.dart'; // keep
// part 'deck_initial_widget.dart'; // keep

@immutable
class AnimatedColorCardBackWidget extends StatelessWidget {
  final Widget? child;
  final Animation<Color?> animation;

  const AnimatedColorCardBackWidget({
    super.key,
    required this.animation,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) => Container(
        decoration: BoxDecoration(
          color: animation.value,
          border: Border.all(width: 1),
          borderRadius: BorderRadius.circular(3),
        ),
        child: child,
      ),
    );
  }
}

Color genRandomColor() {
  final Random rand = Random.secure();
  int r = rand.nextInt(256);
  int g = rand.nextInt(256);
  int b = rand.nextInt(256);
  int a = rand.nextInt(256);

  return Color.fromARGB(a, r, g, b);
}

class CardColorBack extends StatefulWidget {
  const CardColorBack({super.key});

  @override
  State<CardColorBack> createState() => _CardColorBackState();
}

class _CardColorBackState extends State<CardColorBack>
    with SingleTickerProviderStateMixin, Logging {
  final ColorTween colorCycle = ColorTween(
    begin: genRandomColor(),
    end: genRandomColor(),
  );

  late final Animation<Color?> colorAnimation;

  late final AnimationController controller;

  @override
  void initState() {
    super.initState();

    final bias = Random.secure().nextInt(1000) - 500;
    final duration = Duration(milliseconds: 3000 + bias);

    controller = AnimationController(duration: duration, vsync: this);

    colorAnimation = colorCycle.animate(controller)
      ..addStatusListener(animationStatusListener);

    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedColorCardBackWidget(animation: colorAnimation);
  }

  void animationStatusListener(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      setState(() {
        colorCycle.begin = genRandomColor();
        controller.reverse();
      });
    } else if (status == AnimationStatus.dismissed) {
      setState(() {
        colorCycle.end = genRandomColor();
        controller.forward();
      });
    }
  }
}

@immutable
class CardWidget extends StatelessWidget {
  final SlotState slotState;

  const CardWidget({super.key, required this.slotState});

  @override
  Widget build(BuildContext context) {
    return Watch(
      (context) => RotatedBox(
        quarterTurns:
            SignalsManager.reversalsAllowed.value &&
                slotState.reversal == ReversalEnum.reversed
            ? 2
            : 0,
        child: Container(
          padding: const EdgeInsets.all(1.0),
          alignment: Alignment.center,
          child: TCArcanaWidget(slotState: slotState),
        ),
      ),
      debugLabel: "CardWidget",
    );
  }
}
