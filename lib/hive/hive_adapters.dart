import 'package:align_positioned/align_positioned.dart';
import 'package:flutter/material.dart' show Alignment;
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:tarot_again/data_layer/data_sources/layout_manager/types.dart';
import 'package:tarot_again/data_layer/data_sources/randoms_provider/types.dart';
import 'package:tarot_again/reactives/types.dart';

@GenerateAdapters([
  AdapterSpec<StandardTarotDecks>(),
  AdapterSpec<DeckTypesEnum>(),
  AdapterSpec<ShowingFaceEnum>(),
  AdapterSpec<ReversalEnum>(),
  AdapterSpec<RandomGenerators>(),
  AdapterSpec<Alignment>(),
  AdapterSpec<PositionRepresentation>(),
  AdapterSpec<SimpleGrid>(),
  AdapterSpec<NewTarotLayout>(),
])
part 'hive_adapters.g.dart';
