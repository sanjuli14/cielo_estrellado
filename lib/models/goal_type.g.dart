// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GoalTypeAdapter extends TypeAdapter<GoalType> {
  @override
  final int typeId = 4;

  @override
  GoalType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return GoalType.starsPerMonth;
      default:
        return GoalType.consecutiveDays;
    }
  }

  @override
  void write(BinaryWriter writer, GoalType obj) {
    switch (obj) {
      case GoalType.starsPerMonth:
        writer.writeByte(0);
        break;
      case GoalType.consecutiveDays:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GoalTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
