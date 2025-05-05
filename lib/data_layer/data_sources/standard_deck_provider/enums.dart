import 'package:tarot_again/util/util.dart';

@JsonEnum()
enum Suits {
  wands(displayName: "Wands"),
  cups(displayName: "Cups"),
  swords(displayName: "Swords"),
  pentacles(displayName: "Pentacles");

  const Suits({required this.displayName});

  final String displayName;
}

@JsonEnum()
enum Pips {
  ace(displayName: "Ace"),
  two(displayName: "Two"),
  three(displayName: "Three"),
  four(displayName: "Four"),
  five(displayName: "Five"),
  six(displayName: "Six"),
  seven(displayName: "Seven"),
  eight(displayName: "Eight"),
  nine(displayName: "Nine"),
  ten(displayName: "Ten"),
  page(displayName: "Page"),
  knight(displayName: "Knight"),
  queen(displayName: "Queen"),
  king(displayName: "King");

  const Pips({required this.displayName});

  final String displayName;
}

@JsonEnum()
enum MajorArcana {
  fool(displayName: "The Fool", romanNumber: "0"),
  magician(displayName: "The Magician", romanNumber: "I"),
  highPriestess(displayName: "The High Priestess", romanNumber: "II"),
  empress(displayName: "The Empress", romanNumber: "III"),
  emperor(displayName: "The Emperor", romanNumber: "IV"),
  hierophant(displayName: "The Hierophant", romanNumber: "V"),
  lovers(displayName: "The Lovers", romanNumber: "VI"),
  chariot(displayName: "The Chariot", romanNumber: "VII"),
  strength(displayName: "Strength", romanNumber: "VIII"),
  hermit(displayName: "The Hermit", romanNumber: "IX"),
  wheelOfFortune(displayName: "The Wheel of Fortune", romanNumber: "X"),
  justice(displayName: "Justice", romanNumber: "XI"),
  hangedMan(displayName: "The Hanged Man", romanNumber: "XII"),
  death(displayName: "Death", romanNumber: "XIII"),
  temperance(displayName: "Temperance", romanNumber: "XIV"),
  devil(displayName: "The Devil", romanNumber: "XV"),
  tower(displayName: "The Tower", romanNumber: "XVI"),
  star(displayName: "The Star", romanNumber: "XVII"),
  moon(displayName: "The Moon", romanNumber: "XVIII"),
  sun(displayName: "The Sun", romanNumber: "XIX"),
  judgment(displayName: "Judgment", romanNumber: "XX"),
  theWorld(displayName: "The World", romanNumber: "XXI");

  final String displayName;
  final String romanNumber;

  const MajorArcana({required this.displayName, required this.romanNumber});
}
