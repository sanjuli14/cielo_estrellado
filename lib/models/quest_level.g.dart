// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quest_level.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuestLevelAdapter extends TypeAdapter<QuestLevel> {
  @override
  final int typeId = 11;

  @override
  QuestLevel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QuestLevel(
      id: fields[0] as String,
      name: fields[1] as String,
      tasks: (fields[2] as List).cast<QuestTask>(),
      xpReward: fields[3] as int,
      constellationId: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, QuestLevel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.tasks)
      ..writeByte(3)
      ..write(obj.xpReward)
      ..writeByte(4)
      ..write(obj.constellationId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuestLevelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
