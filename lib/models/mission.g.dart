// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mission.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MissionAdapter extends TypeAdapter<Mission> {
  @override
  final int typeId = 7;

  @override
  Mission read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Mission(
      id: fields[0] as String,
      titleKey: fields[1] as String,
      descriptionKey: fields[2] as String,
      targetValue: fields[3] as double,
      currentValue: fields[4] as double,
      type: fields[5] as MissionType,
      isCompleted: fields[6] as bool,
      lastReset: fields[7] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, Mission obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.titleKey)
      ..writeByte(2)
      ..write(obj.descriptionKey)
      ..writeByte(3)
      ..write(obj.targetValue)
      ..writeByte(4)
      ..write(obj.currentValue)
      ..writeByte(5)
      ..write(obj.type)
      ..writeByte(6)
      ..write(obj.isCompleted)
      ..writeByte(7)
      ..write(obj.lastReset);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MissionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MissionTypeAdapter extends TypeAdapter<MissionType> {
  @override
  final int typeId = 6;

  @override
  MissionType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return MissionType.daily;
      case 1:
        return MissionType.weekly;
      case 2:
        return MissionType.milestone;
      default:
        return MissionType.daily;
    }
  }

  @override
  void write(BinaryWriter writer, MissionType obj) {
    switch (obj) {
      case MissionType.daily:
        writer.writeByte(0);
        break;
      case MissionType.weekly:
        writer.writeByte(1);
        break;
      case MissionType.milestone:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MissionTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
