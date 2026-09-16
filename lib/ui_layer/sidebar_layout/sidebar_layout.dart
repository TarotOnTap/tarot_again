import 'package:flutter/material.dart';
import 'package:gpt_markdown/gpt_markdown.dart';
import 'package:tarot_again/util/util.dart';

class SidebarLayout extends StatelessWidget {
  const SidebarLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.topCenter,
      child: LayoutDescription(),
    );
  }
}

class LayoutDescription extends StatelessWidget {
  const LayoutDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return SignalBuilder(
      builder: (context) {
        String markDown = switch (ComputedsManager
            .tarotLayoutDescription
            .value) {
          AsyncData(value: final data) => data.fold(
            () => "# No Data",
            (md) => md,
          ),
          AsyncError(error: final error, stackTrace: _) => "# Error '$error'",
          _ => "### data loading",
        };

        return Padding(
          padding: EdgeInsets.all(5),
          child: Align(
            alignment: Alignment.topLeft,
            child: GptMarkdown(markDown),
          ),
        );
      },
    );
  }
}
