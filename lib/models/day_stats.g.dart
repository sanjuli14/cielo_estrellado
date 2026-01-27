// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'day_stats.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DayStatAdapter extends TypeAdapter<DayStat> {
  @override
  final int typeId = 1;

  @override
  DayStat read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DayStat(
      day: fields[0] as DateTime,
      sessions: fields[1] as int,
      minutes: fields[2] as int,
      starsGenerated: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, DayStat obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.day)
      ..writeByte(1)
      ..write(obj.sessions)
      ..writeByte(2)
      ..write(obj.minutes)
      ..writeByte(3)
      ..write(obj.starsGenerated);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DayStatAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
