// import 'package:align_positioned/align_positioned.dart';
import 'package:flutter/material.dart';
import 'package:gpt_markdown/gpt_markdown.dart';
// import 'layout_widget/layout_widget.dart';
import 'package:tarot_again/util/util.dart';

class SidebarLayout extends StatelessWidget {
  const SidebarLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return const LayoutDescription();
  }
}

class LayoutDescription extends StatelessWidget {
  const LayoutDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return Watch(
      //TODO: wrap the markdown into a top-aligned layout so that its contents start at the top
      // TODO: of its widget, rather than the center.
      (context) => GptMarkdown(
        SignalsManager.tarotLayout.value!.mdLayoutDescription ?? "",
        // style: Theme.of(context).textTheme,
      ),
    );
  }
}
