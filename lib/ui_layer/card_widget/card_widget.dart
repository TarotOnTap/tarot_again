import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tarot_again/util/util.dart';

import 'deck_card_widget.dart';

export 'position_slot_widget.dart';

part 'deck_empty_widget.dart';
part 'deck_initial_widget.dart';

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

    controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

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
  final int index;
  final DeckCard deckCard;

  const CardWidget({super.key, required this.index, required this.deckCard});

  @override
  Widget build(BuildContext context) {
    // return BlocBuilder<BulkCardControlBloc, BulkCardControlState>(
    //   builder:
    return Watch(
      (context) => RotatedBox(
        quarterTurns: SessionManager.reversalsAllowed.value && deckCard.reversed
            ? 2
            : 0,
        child: Container(
          // width: 70,
          // height: 120,
          padding: const EdgeInsets.all(1.0),
          // decoration: BoxDecoration(
          //   border: Border.all(width: 1),
          //   borderRadius: BorderRadius.circular(10),
          // ),
          alignment: Alignment.center,
          child: DeckCardWidget(card: deckCard),
        ),
      ),
    );
  }
}
