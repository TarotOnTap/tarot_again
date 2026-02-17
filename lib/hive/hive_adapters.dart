import 'package:flutter/material.dart' show Alignment;
import 'package:hive_ce/hive_ce.dart';
import 'package:tarot_again/data_layer/data_sources/layout_manager/types.dart';
import 'package:tarot_again/reactives/types.dart';

@GenerateAdapters([
  AdapterSpec<StandardTarotDecks>(),
  AdapterSpec<DeckTypesEnum>(),
  AdapterSpec<ShowingFaceEnum>(),
  AdapterSpec<ReversalEnum>(),
  AdapterSpec<Alignment>(),
  AdapterSpec<PositionRepresentation>(),
  AdapterSpec<TarotLayout>(),
])
part 'hive_adapters.g.dart';
