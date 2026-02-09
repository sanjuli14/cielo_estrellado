// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'adventure_diary_entry.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AdventureDiaryEntryAdapter extends TypeAdapter<AdventureDiaryEntry> {
  @override
  final int typeId = 14;

  @override
  AdventureDiaryEntry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AdventureDiaryEntry(
      id: fields[0] as String,
      date: fields[1] as DateTime,
      title: fields[2] as String,
      description: fields[3] as String,
      type: fields[4] as String,
      xpGained: fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, AdventureDiaryEntry obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.type)
      ..writeByte(5)
      ..write(obj.xpGained);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AdventureDiaryEntryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
