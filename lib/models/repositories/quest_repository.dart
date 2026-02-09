import 'package:cielo_estrellado/models/adventure_diary_entry.dart';
import 'package:cielo_estrellado/models/life_quest.dart';
import 'package:cielo_estrellado/models/user_quest_stats.dart';
import 'package:hive_flutter/hive_flutter.dart';

class QuestRepository {
  static const String questBoxName = 'life_quests';
  static const String statsBoxName = 'user_quest_stats';
  static const String diaryBoxName = 'adventure_diary';

  Future<Box<LifeQuest>> get questBox async => Hive.box<LifeQuest>(questBoxName);
  Future<Box<UserQuestStats>> get statsBox async => Hive.box<UserQuestStats>(statsBoxName);
  Future<Box<AdventureDiaryEntry>> get diaryBox async => Hive.box<AdventureDiaryEntry>(diaryBoxName);

  // Life Quests
  Future<void> saveQuest(LifeQuest quest) async {
    final b = await questBox;
    await b.put(quest.id, quest);
  }

  Future<List<LifeQuest>> getAllQuests() async {
    final b = await questBox;
    return b.values.toList();
  }

  Stream<List<LifeQuest>> watchQuests() async* {
    final b = await questBox;
    yield b.values.toList();
    yield* b.watch().map((_) => b.values.toList());
  }

  // Stats
  Future<void> saveStats(UserQuestStats stats) async {
    final b = await statsBox;
    await b.put('global', stats);
  }

  Future<UserQuestStats> getStats() async {
    final b = await statsBox;
    return b.get('global') ?? UserQuestStats();
  }

  Stream<UserQuestStats> watchStats() async* {
    final b = await statsBox;
    yield await getStats();
    yield* b.watch(key: 'global').map((event) => event.value as UserQuestStats? ?? UserQuestStats());
  }

  // Diary
  Future<void> saveDiaryEntry(AdventureDiaryEntry entry) async {
    final b = await diaryBox;
    await b.put(entry.id, entry);
  }

  Future<List<AdventureDiaryEntry>> getDiaryEntries() async {
    final b = await diaryBox;
    final list = b.values.toList();
    list.sort((a, b) => b.date.compareTo(a.date));
    return list;
  }

  Stream<List<AdventureDiaryEntry>> watchDiary() async* {
    final b = await diaryBox;
    yield await getDiaryEntries();
    yield* b.watch().asyncMap((_) => getDiaryEntries());
  }

  Future<void> clearQuests() async {
    final b = await questBox;
    await b.clear();
  }
}
