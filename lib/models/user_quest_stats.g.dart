// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_quest_stats.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserQuestStatsAdapter extends TypeAdapter<UserQuestStats> {
  @override
  final int typeId = 13;

  @override
  UserQuestStats read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserQuestStats(
      totalXp: fields[0] as int,
      level: fields[1] as int,
      completedQuestsCount: fields[2] as int,
      completedTasksCount: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, UserQuestStats obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.totalXp)
      ..writeByte(1)
      ..write(obj.level)
      ..writeByte(2)
      ..write(obj.completedQuestsCount)
      ..writeByte(3)
      ..write(obj.completedTasksCount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserQuestStatsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
