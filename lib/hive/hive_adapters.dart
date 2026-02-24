import 'package:align_positioned/align_positioned.dart';
import 'package:flutter/material.dart' show Alignment;
// import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:hivez_flutter/hivez_flutter.dart';
import 'package:tarot_again/data_layer/data_sources/data_sources.dart'; // keep this here
// import 'package:tarot_again/data_layer/data_sources/randoms_provider/types.dart';
import 'package:tarot_again/reactives/types.dart';

@GenerateAdapters([
  AdapterSpec<Wins>(),
  AdapterSpec<Touch>(),
  AdapterSpec<StandardTarotDecks>(),
  AdapterSpec<DeckTypesEnum>(),
  AdapterSpec<ShowingFaceEnum>(),
  AdapterSpec<ReversalEnum>(),
  AdapterSpec<AppSettings>(),
  AdapterSpec<HiveService>(),
  AdapterSpec<RandomGenerators>(),
  AdapterSpec<AssetManager>(),
  AdapterSpec<Alignment>(),
  AdapterSpec<PositionRepresentation>(),
  AdapterSpec<SimpleGrid>(),
  AdapterSpec<NewTarotLayout>(),
  // AdapterSpec<List<PositionRepresentation>
  // >(),
  // AdapterSpec<Map<String, PositionRepresentation>>(),
  // AdapterSpec<MappedListIterable<String, PositionRepresentation>>(),
])
part 'hive_adapters.g.dart';
