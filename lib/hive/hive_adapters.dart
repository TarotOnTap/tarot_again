import 'package:hive_ce/hive_ce.dart';
import 'package:tarot_again/reactives/types.dart';

@GenerateAdapters([
  AdapterSpec<StandardTarotDecks>(),
  AdapterSpec<DeckTypesEnum>(),
  AdapterSpec<ShowingFaceEnum>(),
  AdapterSpec<ReversalEnum>(),
])
part 'hive_adapters.g.dart';
