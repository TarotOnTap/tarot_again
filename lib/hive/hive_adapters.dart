import 'package:align_positioned/align_positioned.dart';
import 'package:flutter/material.dart' show Alignment;
import 'package:hivez_flutter/hivez_flutter.dart';
import 'package:tarot_again/util/util.dart';

part 'hive_adapters.g.dart';

class IListAdapter<T extends TypeAdapter> extends TypeAdapter<IList<T>> {
  @override
  final typeId = 100;

  @override
  IList<T> read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final IMap<int, T> fields = IMap<int, T>({
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    });
    return fields.toValueIList();
  }

  @override
  void write(BinaryWriter writer, IList list) {
    writer.writeUint32(list.length);

    for (var i = 0; i < list.length; i++) {
      writer.write(list[i]);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class NewTarotLayoutAdapter extends TypeAdapter<NewTarotLayout> {
  @override
  final typeId = 101;

  @override
  NewTarotLayout read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NewTarotLayout(
      name: fields[0] as String,
      displayName: fields[1] as String,
      layoutType: fields[2] as String,
      positions:
          ((fields[4] as IList<PositionRepresentation>)
                  .cast<PositionRepresentation>())
              as IList<PositionRepresentation>,
      mdLayoutDescription: fields[3] as String?,
      attribution: fields[5] as String?,
      url: fields[6] as String?,
      documentation: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, NewTarotLayout obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.displayName)
      ..writeByte(2)
      ..write(obj.layoutType)
      ..writeByte(3)
      ..write(obj.mdLayoutDescription)
      ..writeByte(4)
      ..write(obj.positions)
      ..writeByte(5)
      ..write(obj.attribution)
      ..writeByte(6)
      ..write(obj.url)
      ..writeByte(7)
      ..write(obj.documentation);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NewTarotLayoutAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

@GenerateAdapters([
  AdapterSpec<Wins>(),
  AdapterSpec<Touch>(),
  AdapterSpec<StandardTarotDecks>(),
  AdapterSpec<DeckTypesEnum>(),
  AdapterSpec<ShowingFaceEnum>(),
  AdapterSpec<ReversalEnum>(),
  // AdapterSpec<AppSettings>(),
  AdapterSpec<HiveService>(),
  AdapterSpec<RandomGenerators>(),
  AdapterSpec<AssetManager>(),
  AdapterSpec<Alignment>(),
  AdapterSpec<PositionRepresentation>(),
  AdapterSpec<SimpleGrid>(),
  // AdapterSpec<NewTarotLayout>(),
  AdapterSpec<AssetStorageRep>(),
  // AdapterSpec<IList<T>>(),
  // AdapterSpec<Iterable<PositionRepresentation>>(),
  // AdapterSpec<TarotLayout>(),
  // AdapterSpec<LayoutList>(),
  // AdapterSpec<PositionRepresentations>
  // (),
  // AdapterSpec<Map<String, PositionRepresentation>>(),
  // AdapterSpec<MappedListIterable<String, PositionRepresentation>>(),
])
class HiveAdapters {}
