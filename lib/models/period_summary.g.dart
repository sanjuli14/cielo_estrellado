// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'period_summary.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PeriodSummaryAdapter extends TypeAdapter<PeriodSummary> {
  @override
  final int typeId = 2;

  @override
  PeriodSummary read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PeriodSummary(
      start: fields[0] as DateTime,
      end: fields[1] as DateTime,
      totalMinutes: fields[2] as int,
      sessions: fields[3] as int,
      averageMinutesPerDay: fields[4] as double,
      bestDay: fields[5] as DayStat?,
      worstDay: fields[6] as DayStat?,
      byDay: (fields[7] as List).cast<DayStat>(),
    );
  }

  @override
  void write(BinaryWriter writer, PeriodSummary obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.start)
      ..writeByte(1)
      ..write(obj.end)
      ..writeByte(2)
      ..write(obj.totalMinutes)
      ..writeByte(3)
      ..write(obj.sessions)
      ..writeByte(4)
      ..write(obj.averageMinutesPerDay)
      ..writeByte(5)
      ..write(obj.bestDay)
      ..writeByte(6)
      ..write(obj.worstDay)
      ..writeByte(7)
      ..write(obj.byDay);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PeriodSummaryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
