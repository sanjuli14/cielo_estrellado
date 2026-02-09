// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'life_quest.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LifeQuestAdapter extends TypeAdapter<LifeQuest> {
  @override
  final int typeId = 10;

  @override
  LifeQuest read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LifeQuest(
      id: fields[0] as String,
      title: fields[1] as String,
      description: fields[2] as String,
      levels: (fields[3] as List).cast<QuestLevel>(),
      currentLevelIndex: fields[4] as int,
      isCompleted: fields[5] as bool,
      category: fields[6] as String,
      type: fields[7] as String?,
      lastReset: fields[8] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, LifeQuest obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.levels)
      ..writeByte(4)
      ..write(obj.currentLevelIndex)
      ..writeByte(5)
      ..write(obj.isCompleted)
      ..writeByte(6)
      ..write(obj.category)
      ..writeByte(7)
      ..write(obj.type)
      ..writeByte(8)
      ..write(obj.lastReset);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LifeQuestAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
