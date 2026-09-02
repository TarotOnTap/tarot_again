import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tarot_again/util/util.dart';

/// Layouts are assets that describe how many cards are needed, and where to
/// locate those cards on the screen, they also provide information on the meanings
/// of the slots.
/// Inside a layout, a card (DealtCard) will be assigned to each layout slot by
/// the LayoutRepository - not here.
///

typedef LayoutAssetCache = IMap<String, TarotLayout>;

@singleton
class LayoutManager with Logging {
  // LayoutManager() {
  //   verbose("LayoutManager.LayoutManager");
  // }

  Future<void> generateLayoutsFile(String? fileName) async {
    if (fileName != null) {
      final layoutString = generateLayouts();
      verbose(" generated layout: layout string is\n$layoutString");

      File outputFile = File(fileName);
      try {
        await outputFile.writeAsString(layoutString);
      } catch (e) {
        error(
          "  error writing to File object for  file $fileName, error is $e",
        );
      }
    }
  }

  TarotLayout getLayoutByLayoutName(String name) =>
      SignalsManager.tarotLayoutsByName.value[name] ?? TarotLayout.nullLayout();

  void setLayoutByLayoutName(String name) =>
      SignalsManager.tarotLayout.value = getLayoutByLayoutName(name);

  TarotLayout getLayoutByDisplayName(String displayName) =>
      ComputedsManager.layoutsByDisplayName.value[displayName] ??
      TarotLayout.nullLayout();

  void setLayoutByDisplayName(String displayName) =>
      SignalsManager.tarotLayout.value = getLayoutByDisplayName(displayName);

  Future<String> loadCurrentLayoutDescription() async {
    return Future.value("#Description#");
  }

  /// Generate layouts is a utility function that is going to generate a few sample
  /// layouts using the NewTarotLayout class, and then write them to a json String.
  String generateLayouts() {
    LayoutList layouts = LayoutList(
      layouts: <TarotLayout>[
        TarotLayout.simpleGrid(
          displayName: "All Cards",
          name: "allCards",
          numCards: 78,
          layoutType: "SimpleGrid",
          mdLayoutDescription: "# All Cards in a grid\n\nThis is for testing and demonstration purposes, not a real layout.",
        ),
        NewTarotLayout(
          name: "pastPresentFuture",
          displayName: "Past, Present, Future",
          layoutType: "NewTarotLayout",
          positions: IList<PositionRepresentation>([
            PositionRepresentation(
              name: "Past",
              alignment: Alignment.centerLeft,
              moveByContainerWidth: 0.25,
              moveByChildWidth: -0.5,
              popUpDescription: "representing a past - event, situation, relationship, that is relevant to your question",
            ),
            PositionRepresentation(
              name: "Present",
              alignment: Alignment.centerLeft,
              moveByContainerWidth: 0.25,
              moveByChildWidth: -0.5,
              popUpDescription: "representing the present - event, situation, relationship, that is relevant to your question",
            ),
            PositionRepresentation(
              name: "Future",
              alignment: Alignment.centerLeft,
              moveByContainerWidth: 0.75,
              moveByChildWidth: -0.5,
              popUpDescription: "representing a possible future - event, situation, relationship, that is relevant to your question",
            ),
          ]),
          mdLayoutDescription: "# Past, Present, Future\n\nThe **Past, Present, Future** layout is a way to ask the cards about how the past, present, and future affect the subject of the question - the subject could be a person, a place, an event, or a situation of interest.\n\n[Wikipedia](https://en.wikipedia.org/).",
        ),
        NewTarotLayout(
          name: "Four-by",
          displayName: "Four-by",
          layoutType: "NewTarotLayout",
          mdLayoutDescription: "# Example 1\n* a four-card grid",
          positions: IList<PositionRepresentation>([
            PositionRepresentation(
              name: "Top-left",
              alignment: Alignment.centerLeft,
              moveByContainerWidth: 0.25,
              moveByContainerHeight: 0.25,
              moveByChildWidth: -0.5,
              moveByChildHeight: -0.5,
              popUpDescription: "Top-left card",
            ),
            PositionRepresentation(
              name: "Top-right",
              alignment: Alignment.centerLeft,
              moveByContainerWidth: 0.75,
              moveByContainerHeight: 0.25,
              moveByChildWidth: -0.5,
              moveByChildHeight: -0.5,
              popUpDescription: "Top-right card",
            ),
            PositionRepresentation(
              name: "Bottom-left",
              alignment: Alignment.centerLeft,
              moveByContainerWidth: 0.25,
              moveByChildWidth: -0.5,
              moveByContainerHeight: 0.75,
              moveByChildHeight: -0.5,
              popUpDescription: "Bottom-left card",
            ),
            PositionRepresentation(
              name: "Bottom-right",
              alignment: Alignment.centerLeft,
              moveByContainerWidth: 0.75,
              moveByChildWidth: -0.5,
              moveByContainerHeight: 0.75,
              moveByChildHeight: -0.5,
              popUpDescription: "Bottom-right card",
            ),
          ]),
        ),
      ].lock,
    );

    return JsonEncoder.withIndent('  ').convert(layouts.toJson());
  }
}
