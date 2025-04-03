import 'package:tarot_again/util/util.dart';

final IList<String> minorArcanaSuits =
    <String>["Wands", "Cups", "Swords", "Pentacles"].lock;

@JsonEnum()
enum Suits { wands, cups, swords, pentacles }

@JsonEnum()
enum Pips {
  ace,
  two,
  three,
  four,
  five,
  six,
  seven,
  eight,
  nine,
  ten,
  page,
  knight,
  queen,
  king,
}

final IList<String> minorArcanaNames = IList([
  "Ace",
  "Two",
  "Three",
  "Four",
  "Five",
  "Six",
  "Seven",
  "Eight",
  "Nine",
  "Ten",
  "Page",
  "Knight",
  "Queen",
  "King",
]);

@JsonEnum(valueField: 'name')
enum MajorArcana {
  fool(name: "The Fool", romanNumber: "0"),
  magician(name: "The Magician", romanNumber: "I"),
  highPriestess(name: "The High Priestess", romanNumber: "II"),
  empress(name: "The Empress", romanNumber: "III"),
  emperor(name: "The Emperor", romanNumber: "IV"),
  hierophant(name: "The Hierophant", romanNumber: "V"),
  lovers(name: "The Lovers", romanNumber: "VI"),
  chariot(name: "The Chariot", romanNumber: "VII"),
  strength(name: "Strength", romanNumber: "VIII"),
  hermit(name: "The Hermit", romanNumber: "IX"),
  wheelOfFortune(name: "The Wheel of Fortune", romanNumber: "X"),
  justice(name: "Justice", romanNumber: "XI"),
  hangedMan(name: "The Hanged Man", romanNumber: "XII"),
  death(name: "Death", romanNumber: "XIII"),
  temperance(name: "Temperance", romanNumber: "XIV"),
  devil(name: "The Devil", romanNumber: "XV"),
  tower(name: "The Tower", romanNumber: "XVI"),
  star(name: "The Star", romanNumber: "XVII"),
  moon(name: "The Moon", romanNumber: "XVIII"),
  sun(name: "The Sun", romanNumber: "XIX"),
  judgment(name: "Judgment", romanNumber: "XX"),
  theWorld(name: "The World", romanNumber: "XXI");

  final String name;
  final String romanNumber;

  const MajorArcana({required this.name, required this.romanNumber});
}
