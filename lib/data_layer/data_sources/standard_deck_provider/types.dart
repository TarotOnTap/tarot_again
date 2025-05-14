import 'package:tarot_again/util/util.dart';

@JsonEnum()
enum RomanNumerals {
  none,
  zero,
  i,
  ii,
  iii,
  iv,
  v,
  vi,
  vii,
  viii,
  ix,
  x,
  xi,
  xii,
  xiii,
  xiv,
  xv,
  xvi,
  xvii,
  xviii,
  xix,
  xx,
  xxi,
  // xxii,
}

@JsonEnum()
enum Arcana { major, minor }

@JsonEnum()
enum TarotDeckCards {
  fool(
    displayName: "The Fool",
    romanNumber: RomanNumerals.zero,
    arcana: Arcana.major,
  ),
  magician(
    displayName: "The Magician",
    romanNumber: RomanNumerals.i,
    arcana: Arcana.major,
  ),
  highPriestess(
    displayName: "The High Priestess",
    romanNumber: RomanNumerals.ii,
    arcana: Arcana.major,
  ),
  empress(
    displayName: "The Empress",
    romanNumber: RomanNumerals.iii,
    arcana: Arcana.major,
  ),
  emperor(
    displayName: "The Emperor",
    romanNumber: RomanNumerals.iv,
    arcana: Arcana.major,
  ),
  hierophant(
    displayName: "The Hierophant",
    romanNumber: RomanNumerals.v,
    arcana: Arcana.major,
  ),
  lovers(
    displayName: "The Lovers",
    romanNumber: RomanNumerals.vi,
    arcana: Arcana.major,
  ),
  chariot(
    displayName: "The Chariot",
    romanNumber: RomanNumerals.vii,
    arcana: Arcana.major,
  ),
  strength(
    displayName: "Strength",
    romanNumber: RomanNumerals.viii,
    arcana: Arcana.major,
  ),
  hermit(
    displayName: "The Hermit",
    romanNumber: RomanNumerals.ix,
    arcana: Arcana.major,
  ),
  wheelOfFortune(
    displayName: "The Wheel of Fortune",
    romanNumber: RomanNumerals.x,
    arcana: Arcana.major,
  ),
  justice(
    displayName: "Justice",
    romanNumber: RomanNumerals.xi,
    arcana: Arcana.major,
  ),
  hangedMan(
    displayName: "The Hanged Man",
    romanNumber: RomanNumerals.xii,
    arcana: Arcana.major,
  ),
  death(
    displayName: "Death",
    romanNumber: RomanNumerals.xiii,
    arcana: Arcana.major,
  ),
  temperance(
    displayName: "Temperance",
    romanNumber: RomanNumerals.xiv,
    arcana: Arcana.major,
  ),
  devil(
    displayName: "The Devil",
    romanNumber: RomanNumerals.xv,
    arcana: Arcana.major,
  ),
  tower(
    displayName: "The Tower",
    romanNumber: RomanNumerals.xvi,
    arcana: Arcana.major,
  ),
  star(
    displayName: "The Star",
    romanNumber: RomanNumerals.xvii,
    arcana: Arcana.major,
  ),
  moon(
    displayName: "The Moon",
    romanNumber: RomanNumerals.xviii,
    arcana: Arcana.major,
  ),
  sun(
    displayName: "The Sun",
    romanNumber: RomanNumerals.xix,
    arcana: Arcana.major,
  ),
  judgment(
    displayName: "Judgment",
    romanNumber: RomanNumerals.xx,
    arcana: Arcana.major,
  ),
  theWorld(
    displayName: "The World",
    romanNumber: RomanNumerals.xxi,
    arcana: Arcana.major,
  ),
  aceWands(
    displayName: "Ace of Wands",
    arcana: Arcana.minor,
    suit: Suits.wands,
    pips: Pips.ace,
  ),
  twoWands(
    displayName: "Two of Wands",
    arcana: Arcana.minor,
    suit: Suits.wands,
    pips: Pips.two,
  ),
  threeWands(
    displayName: "Three of Wands",
    arcana: Arcana.minor,
    suit: Suits.wands,
    pips: Pips.three,
  ),
  fourWands(
    displayName: "Four of Wands",
    arcana: Arcana.minor,
    suit: Suits.wands,
    pips: Pips.four,
  ),
  fiveWands(
    displayName: "Five of Wands",
    arcana: Arcana.minor,
    suit: Suits.wands,
    pips: Pips.five,
  ),
  sixWands(
    displayName: "Six of Wands",
    arcana: Arcana.minor,
    suit: Suits.wands,
    pips: Pips.six,
  ),
  sevenWands(
    displayName: "Seven of Wands",
    arcana: Arcana.minor,
    suit: Suits.wands,
    pips: Pips.seven,
  ),
  eightWands(
    displayName: "Eight of Wands",
    arcana: Arcana.minor,
    suit: Suits.wands,
    pips: Pips.eight,
  ),
  nineWands(
    displayName: "Nine of Wands",
    arcana: Arcana.minor,
    suit: Suits.wands,
    pips: Pips.nine,
  ),
  tenWands(
    displayName: "Ten of Wands",
    arcana: Arcana.minor,
    suit: Suits.wands,
    pips: Pips.ten,
  ),
  pageWands(
    displayName: "Page of Wands",
    arcana: Arcana.minor,
    suit: Suits.wands,
    pips: Pips.page,
  ),
  knightWands(
    displayName: "Knight of Wands",
    arcana: Arcana.minor,
    suit: Suits.wands,
    pips: Pips.knight,
  ),
  queenWands(
    displayName: "Queen of Wands",
    arcana: Arcana.minor,
    suit: Suits.wands,
    pips: Pips.queen,
  ),
  kingWands(
    displayName: "King of Wands",
    arcana: Arcana.minor,
    suit: Suits.wands,
    pips: Pips.king,
  ),
  aceCups(
    displayName: "Ace of Cups",
    arcana: Arcana.minor,
    suit: Suits.cups,
    pips: Pips.ace,
  ),
  twoCups(
    displayName: "Two of Cups",
    arcana: Arcana.minor,
    suit: Suits.cups,
    pips: Pips.two,
  ),
  threeCups(
    displayName: "Three of Cups",
    arcana: Arcana.minor,
    suit: Suits.cups,
    pips: Pips.three,
  ),
  fourCups(
    displayName: "Four of Cups",
    arcana: Arcana.minor,
    suit: Suits.cups,
    pips: Pips.four,
  ),
  fiveCups(
    displayName: "Five of Cups",
    arcana: Arcana.minor,
    suit: Suits.cups,
    pips: Pips.five,
  ),
  sixCups(
    displayName: "Six of Cups",
    arcana: Arcana.minor,
    suit: Suits.cups,
    pips: Pips.six,
  ),
  sevenCups(
    displayName: "Seven of Cups",
    arcana: Arcana.minor,
    suit: Suits.cups,
    pips: Pips.seven,
  ),
  eightCups(
    displayName: "Eight of Cups",
    arcana: Arcana.minor,
    suit: Suits.cups,
    pips: Pips.eight,
  ),
  nineCups(
    displayName: "Nine of Cups",
    arcana: Arcana.minor,
    suit: Suits.cups,
    pips: Pips.nine,
  ),
  tenCups(
    displayName: "Ten of Cups",
    arcana: Arcana.minor,
    suit: Suits.cups,
    pips: Pips.ten,
  ),
  pageCups(
    displayName: "Page of Cups",
    arcana: Arcana.minor,
    suit: Suits.cups,
    pips: Pips.page,
  ),
  knightCups(
    displayName: "Knight of Cups",
    arcana: Arcana.minor,
    suit: Suits.cups,
    pips: Pips.knight,
  ),
  queenCups(
    displayName: "Queen of Cups",
    arcana: Arcana.minor,
    suit: Suits.cups,
    pips: Pips.queen,
  ),
  kingCups(
    displayName: "King of Cups",
    arcana: Arcana.minor,
    suit: Suits.cups,
    pips: Pips.king,
  ),
  aceSwords(
    displayName: "Ace of Swords",
    arcana: Arcana.minor,
    suit: Suits.swords,
    pips: Pips.ace,
  ),
  twoSwords(
    displayName: "Two of Swords",
    arcana: Arcana.minor,
    suit: Suits.swords,
    pips: Pips.two,
  ),
  threeSwords(
    displayName: "Three of Swords",
    arcana: Arcana.minor,
    suit: Suits.swords,
    pips: Pips.three,
  ),
  fourSwords(
    displayName: "Four of Swords",
    arcana: Arcana.minor,
    suit: Suits.swords,
    pips: Pips.four,
  ),
  fiveSwords(
    displayName: "Five of Swords",
    arcana: Arcana.minor,
    suit: Suits.swords,
    pips: Pips.five,
  ),
  sixSwords(
    displayName: "Six of Swords",
    arcana: Arcana.minor,
    suit: Suits.swords,
    pips: Pips.seven,
  ),
  sevenSwords(
    displayName: "Seven of Swords",
    arcana: Arcana.minor,
    suit: Suits.swords,
    pips: Pips.seven,
  ),
  eightSwords(
    displayName: "Eight of Swords",
    arcana: Arcana.minor,
    suit: Suits.swords,
    pips: Pips.eight,
  ),
  nineSwords(
    displayName: "Nine of Swords",
    arcana: Arcana.minor,
    suit: Suits.swords,
    pips: Pips.nine,
  ),
  tenSwords(
    displayName: "Ten of Swords",
    arcana: Arcana.minor,
    suit: Suits.swords,
    pips: Pips.ten,
  ),
  pageSwords(
    displayName: "Page of Swords",
    arcana: Arcana.minor,
    suit: Suits.swords,
    pips: Pips.page,
  ),
  knightSwords(
    displayName: "Knight of Swords",
    arcana: Arcana.minor,
    suit: Suits.swords,
    pips: Pips.knight,
  ),
  queenSwords(
    displayName: "Queen of Swords",
    arcana: Arcana.minor,
    suit: Suits.swords,
    pips: Pips.queen,
  ),
  kingSwords(
    displayName: "King of Swords",
    arcana: Arcana.minor,
    suit: Suits.swords,
    pips: Pips.king,
  ),
  acePentacles(
    displayName: "Ace of Pentacles",
    arcana: Arcana.minor,
    suit: Suits.pentacles,
    pips: Pips.ace,
  ),
  twoPentacles(
    displayName: "Two of Pentacles",
    arcana: Arcana.minor,
    suit: Suits.pentacles,
    pips: Pips.two,
  ),
  threePentacles(
    displayName: "Three of Pentacles",
    arcana: Arcana.minor,
    suit: Suits.pentacles,
    pips: Pips.three,
  ),
  fourPentacles(
    displayName: "Four of Pentacles",
    arcana: Arcana.minor,
    suit: Suits.pentacles,
    pips: Pips.four,
  ),
  fivePentacles(
    displayName: "Five of Pentacles",
    arcana: Arcana.minor,
    suit: Suits.pentacles,
    pips: Pips.five,
  ),
  sixPentacles(
    displayName: "Six of Pentacles",
    arcana: Arcana.minor,
    suit: Suits.pentacles,
    pips: Pips.six,
  ),
  sevenPentacles(
    displayName: "Seven of Pentacles",
    arcana: Arcana.minor,
    suit: Suits.pentacles,
    pips: Pips.seven,
  ),
  eightPentacles(
    displayName: "Eight of Pentacles",
    arcana: Arcana.minor,
    suit: Suits.pentacles,
    pips: Pips.eight,
  ),
  ninePentacles(
    displayName: "Nine of Pentacles",
    arcana: Arcana.minor,
    suit: Suits.pentacles,
    pips: Pips.nine,
  ),
  tenPentacles(
    displayName: "Ten of Pentacles",
    arcana: Arcana.minor,
    suit: Suits.pentacles,
    pips: Pips.ten,
  ),
  pagePentacles(
    displayName: "Page of Pentacles",
    arcana: Arcana.minor,
    suit: Suits.pentacles,
    pips: Pips.page,
  ),
  knightPentacles(
    displayName: "Knight of Pentacles",
    arcana: Arcana.minor,
    suit: Suits.pentacles,
    pips: Pips.knight,
  ),
  queenPentacles(
    displayName: "Queen of Pentacles",
    arcana: Arcana.minor,
    suit: Suits.pentacles,
    pips: Pips.queen,
  ),
  kingPentacles(
    displayName: "King of Pentacles",
    arcana: Arcana.minor,
    suit: Suits.pentacles,
    pips: Pips.king,
  );

  final String displayName;
  final RomanNumerals romanNumber;
  final Arcana arcana;
  final Suits suit;
  final Pips pips;

  const TarotDeckCards({
    required this.displayName,
    this.romanNumber = RomanNumerals.none,
    required this.arcana,
    this.suit = Suits.none,
    this.pips = Pips.none,
  });
}

@JsonEnum()
enum Suits { none, wands, cups, swords, pentacles }

@JsonEnum()
enum Pips {
  none,
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
