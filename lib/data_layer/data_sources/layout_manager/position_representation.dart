import 'package:align_positioned/align_positioned.dart'; // to get a few types
import 'package:flutter/material.dart' show Alignment;
import 'package:tarot_again/util/util.dart';

// that are used

part 'position_representation.freezed.dart'; // j
//
part 'position_representation.g.dart';

@immutable
class AlignmentEnumConverter implements JsonConverter<Alignment, String> {
  const AlignmentEnumConverter();

  Alignment? _parseNumerics(String numerics) {
    // this method works with alignments of the form:
    // Alignment(0.3, 0.1) and "0.3, 0.1" - either form will produce the
    // arbitrary alignment specified.

    // both forms have a comma separating the values, so start with that.
    final split = numerics.split(",");

    if (split.length != 2) {
      return null;
    }

    // if the first subsegment contains "Alignment(", get rid of that and leave
    // the number.
    if (split[0].startsWith("Alignment(")) {
      split[0] = split[0].replaceAll("Alignment(", "");
    }

    // likewise, if the second subsegment ends with ")", remove that
    if (split[1].endsWith(")")) {
      split[1] = split[1].replaceAll(")", "");
    }

    // now we have a list of two strings, something like [ "0.3", " 0.5" ]
    // these should convert to doubles; if they don't, return Alignment.center
    // as our default.

    double? x, y;

    x = double.tryParse(split[0].trim());
    y = double.tryParse(split[1].trim());

    if (x != null && y != null) {
      return Alignment(x, y);
    } else {
      return null; //
    }
  }

  Alignment? _parseString(String jsonInput) {
    String json;

    if (jsonInput.startsWith("Alignment.")) {
      json = jsonInput.replaceAll("Alignment.", ""); // convert it just
      // to the short form, which is handled next
    } else {
      json = jsonInput;
    }

    return switch (json) {
      "bottomLeft" => Alignment.bottomLeft,
      "bottomCenter" => Alignment.bottomCenter,
      "bottomRight" => Alignment.bottomRight,

      "center" => Alignment.center,
      "centerLeft" => Alignment.centerLeft,
      "centerRight" => Alignment.centerRight,
      "topLeft" => Alignment.topLeft,
      "topCenter" => Alignment.topCenter,
      "topRight" => Alignment.topRight,
      _ => null,
    };
  }

  /// fromJson works with three possible variations of an alignment specifier:
  /// first, it tries to parse an arbitrary Alignment value like Alignment(0.2, 0.8)
  /// second, it tries to parse a string like "centerLeft"
  /// third, it tries to parse a string like "Alignment.centerLeft" (which is
  /// what an Alignment.centerLeft is converted to - layouts created in the
  /// app will write this out.
  /// The other form, "centerLeft" is for hand-written layouts.
  @override
  Alignment fromJson(String json) =>
      _parseNumerics(json) ?? _parseString(json) ?? Alignment.center;

  @override
  String toJson(Alignment object) => object.toString();
}

@immutable
class WinsEnumConverter implements JsonConverter<Wins, String> {
  const WinsEnumConverter();

  @override
  String toJson(Wins object) => object.toString();

  @override
  Wins fromJson(String json) => switch (json) {
    "min" => Wins.min,
    "max" => Wins.max,
    _ => Wins.min,
  };
}

class TouchEnumConverter implements JsonConverter<Touch, String> {
  const TouchEnumConverter();

  @override
  String toJson(Touch object) => object.toString();

  @override
  Touch fromJson(String json) => switch (json) {
    "inside" => Touch.inside,
    "outside" => Touch.outside,
    "middle" => Touch.middle,
    _ => Touch.inside,
  };
}

@freezed
abstract class PositionRepresentation with _$PositionRepresentation {
  PositionRepresentation._();

  factory PositionRepresentation({
    required String name,
    int?
    positionIndex, // most of the time, position id is defined by this item's
    // list index, but it can be assigned differently if needed.
    int?
    zIndex, // likewise, most of the time, z index is defined by this item's
    // list index, but it can be assigned differently if needed.
    @AlignmentEnumConverter() required Alignment alignment,
    double? dx,
    double? dy,
    double? moveByChildWidth,
    double? moveByChildHeight,
    double? moveByContainerWidth,
    double? moveByContainerHeight,
    double? moveVerticallyByChildWidth,
    double? moveHorizontallyByChildHeight,
    double? moveVerticallyByContainerWidth,
    double? moveHorizontallyByContainerHeight,
    double? childWidth,
    double? childHeight,
    double? minChildWidth,
    double? minChildHeight,
    double? maxChildWidth,
    double? maxChildHeight,
    double? childWidthRatio,
    double? childHeightRatio,
    double? minChildWidthRatio,
    double? minChildHeightRatio,
    double? maxChildWidthRatio,
    double? maxChildHeightRatio,
    double? rotateDegrees,
    // Matrix4Transform? matrix4Transform, // TODO: write a converter
    @Default(Wins.min) @WinsEnumConverter() Wins? wins,
    @Default(Touch.inside) @TouchEnumConverter() Touch? touch,
    @Default("") String popUpDescription,
  }) = _PositionRepresentation;

  factory PositionRepresentation.fromJson(Map<String, dynamic> json) =>
      _$PositionRepresentationFromJson(json);
}
