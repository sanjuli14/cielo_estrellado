// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quest_task.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuestTaskAdapter extends TypeAdapter<QuestTask> {
  @override
  final int typeId = 12;

  @override
  QuestTask read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QuestTask(
      id: fields[0] as String,
      description: fields[1] as String,
      isCompleted: fields[2] as bool,
      xpReward: fields[3] as int,
      currentValue: fields[4] as double?,
      targetValue: fields[5] as double?,
      unit: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, QuestTask obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.isCompleted)
      ..writeByte(3)
      ..write(obj.xpReward)
      ..writeByte(4)
      ..write(obj.currentValue)
      ..writeByte(5)
      ..write(obj.targetValue)
      ..writeByte(6)
      ..write(obj.unit);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuestTaskAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
