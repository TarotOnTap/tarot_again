// import 'package:align_positioned/align_positioned.dart';
import 'package:flutter/material.dart';
import 'package:gpt_markdown/gpt_markdown.dart';
// import 'layout_widget/layout_widget.dart';

class SidebarLayout extends StatelessWidget {
  const SidebarLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class LayoutDescription extends StatelessWidget {
  const LayoutDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return GptMarkdown('''
    * This is a unordered list.
    ''', style: const TextStyle(color: Colors.red));
  }
}
