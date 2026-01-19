import 'package:hive/hive.dart';

part 'sessions.g.dart'; // <- exacto, coincide con el nombre del archivo .g.dart

@HiveType(typeId: 0)
class Session extends HiveObject {

  @HiveField(0)
  int id;

  @HiveField(1)
  DateTime startTime;

  @HiveField(2)
  DateTime endTime;

  @HiveField(3)
  int durationMinutes;

  @HiveField(4)
  int starsGenerated;

  Session({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.durationMinutes,
    required this.starsGenerated,
  });
}
