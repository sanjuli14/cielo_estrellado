import 'package:hive/hive.dart';

part 'mission.g.dart';

@HiveType(typeId: 6)
enum MissionType {
  @HiveField(0)
  daily,
  @HiveField(1)
  weekly,
  @HiveField(2)
  milestone,
}

@HiveType(typeId: 7)
class Mission extends HiveObject {
  @HiveField(0)
  final String id;
  
  @HiveField(1)
  final String titleKey; // For localization
  
  @HiveField(2)
  final String descriptionKey; // For localization
  
  @HiveField(3)
  final double targetValue;
  
  @HiveField(4)
  final double currentValue;
  
  @HiveField(5)
  final MissionType type;
  
  @HiveField(6)
  final bool isCompleted;
  
  @HiveField(7)
  final DateTime? lastReset;

  Mission({
    required this.id,
    required this.titleKey,
    required this.descriptionKey,
    required this.targetValue,
    this.currentValue = 0,
    required this.type,
    this.isCompleted = false,
    this.lastReset,
  });

  Mission copyWith({
    double? currentValue,
    bool? isCompleted,
    DateTime? lastReset,
  }) {
    return Mission(
      id: id,
      titleKey: titleKey,
      descriptionKey: descriptionKey,
      targetValue: targetValue,
      currentValue: currentValue ?? this.currentValue,
      type: type,
      isCompleted: isCompleted ?? this.isCompleted,
      lastReset: lastReset ?? this.lastReset,
    );
  }
}
