import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tarot_again/blocs/blocs.dart';
import 'package:tarot_again/data_layer/data_layer.dart';
import 'package:tarot_again/util/util.dart';

// import 'package:toastification/toastification.dart';

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
      builder:
          (context, child) => Container(
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
    verbose("_CardColorBackState.initState()");
    super.initState();

    controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    verbose("  created AnimationController");

    colorAnimation = colorCycle.animate(controller)
      ..addStatusListener(animationStatusListener);
    verbose("  created colorAnimation");

    controller.forward();
  }

  @override
  void dispose() {
    verbose("in _CardColorBackState.dispose()");
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedColorCardBackWidget(animation: colorAnimation);
  }

  void animationStatusListener(AnimationStatus status) {
    verbose("animationStatusListener; status is $status");
    if (status == AnimationStatus.completed) {
      verbose("  completed.");
      setState(() {
        colorCycle.begin = genRandomColor();
        verbose("  set colorCycle to $colorCycle; calling controller.reverse");
        controller.reverse();
      });
    } else if (status == AnimationStatus.dismissed) {
      verbose("  dismissted.");
      setState(() {
        colorCycle.end = genRandomColor();
        verbose("  set colorCycle to $colorCycle; calling controller.forward");
        controller.forward();
      });
    }
  }
}

@immutable
class CardWidget extends StatelessWidget {
  final int index;
  final SlotWidgetStateDealt swState;

  const CardWidget({super.key, required this.index, required this.swState});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BulkCardControlBloc, BulkCardControlState>(
      builder:
          (context, bcState) => RotatedBox(
            quarterTurns:
                bcState.reversalsAllowed &&
                        switch (swState.card) {
                          DeckCard dc => dc.reversed,
                          _ => false,
                        }
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
              child: switch (swState) {
                SlotWidgetStateDealt sd => switch (sd.card) {
                  DeckCard dc => DeckCardWidget(card: dc),
                  _ => Placeholder(child: Text("Card is not a DeckCard")),
                },
              },
            ),
          ),
    );
  }
}
