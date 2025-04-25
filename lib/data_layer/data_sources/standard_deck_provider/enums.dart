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

@JsonEnum()
enum MajorArcana {
  fool(cardName: "The Fool", romanNumber: "0"),
  magician(cardName: "The Magician", romanNumber: "I"),
  highPriestess(cardName: "The High Priestess", romanNumber: "II"),
  empress(cardName: "The Empress", romanNumber: "III"),
  emperor(cardName: "The Emperor", romanNumber: "IV"),
  hierophant(cardName: "The Hierophant", romanNumber: "V"),
  lovers(cardName: "The Lovers", romanNumber: "VI"),
  chariot(cardName: "The Chariot", romanNumber: "VII"),
  strength(cardName: "Strength", romanNumber: "VIII"),
  hermit(cardName: "The Hermit", romanNumber: "IX"),
  wheelOfFortune(cardName: "The Wheel of Fortune", romanNumber: "X"),
  justice(cardName: "Justice", romanNumber: "XI"),
  hangedMan(cardName: "The Hanged Man", romanNumber: "XII"),
  death(cardName: "Death", romanNumber: "XIII"),
  temperance(cardName: "Temperance", romanNumber: "XIV"),
  devil(cardName: "The Devil", romanNumber: "XV"),
  tower(cardName: "The Tower", romanNumber: "XVI"),
  star(cardName: "The Star", romanNumber: "XVII"),
  moon(cardName: "The Moon", romanNumber: "XVIII"),
  sun(cardName: "The Sun", romanNumber: "XIX"),
  judgment(cardName: "Judgment", romanNumber: "XX"),
  theWorld(cardName: "The World", romanNumber: "XXI");

  final String cardName;
  final String romanNumber;

  const MajorArcana({required this.cardName, required this.romanNumber});
}
