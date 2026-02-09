import 'package:cielo_estrellado/models/adventure_diary_entry.dart';
import 'package:cielo_estrellado/models/day_stats.dart';
import 'package:cielo_estrellado/models/goal.dart';
import 'package:cielo_estrellado/models/goal_type.dart';
import 'package:cielo_estrellado/models/life_quest.dart';
import 'package:cielo_estrellado/models/mission.dart';
import 'package:cielo_estrellado/models/period_summary.dart';
import 'package:cielo_estrellado/models/quest_level.dart';
import 'package:cielo_estrellado/models/quest_task.dart';
import 'package:cielo_estrellado/models/sessions.dart';
import 'package:cielo_estrellado/models/user_quest_stats.dart';
import 'package:cielo_estrellado/models/repositories/quest_repository.dart';
import 'package:cielo_estrellado/presentation/screen/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'core/theme/app_theme.dart';
import 'package:cielo_estrellado/core/notifications/notification_service.dart';
import 'package:cielo_estrellado/core/storage/onboarding_storage.dart';
import 'package:cielo_estrellado/l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('en', null);
  await initializeDateFormatting('es', null);
  await Hive.initFlutter();
  
  await NotificationService().init();

  Hive.registerAdapter(SessionAdapter());
  Hive.registerAdapter(DayStatAdapter());
  Hive.registerAdapter(PeriodSummaryAdapter());
  Hive.registerAdapter(GoalAdapter());
  Hive.registerAdapter(GoalTypeAdapter());
  Hive.registerAdapter(MissionAdapter());
  Hive.registerAdapter(MissionTypeAdapter());
  
  // Life Quests adapters
  Hive.registerAdapter(LifeQuestAdapter());
  Hive.registerAdapter(QuestLevelAdapter());
  Hive.registerAdapter(QuestTaskAdapter());
  Hive.registerAdapter(UserQuestStatsAdapter());
  Hive.registerAdapter(AdventureDiaryEntryAdapter());

  await Hive.openBox<Session>('sessions');
  await Hive.openBox<Mission>('missions');
  
  // Life Quests boxes - Safe open
  try {
    await Hive.openBox<LifeQuest>(QuestRepository.questBoxName);
    await Hive.openBox<UserQuestStats>(QuestRepository.statsBoxName);
    await Hive.openBox<AdventureDiaryEntry>(QuestRepository.diaryBoxName);
  } catch (e) {
    debugPrint('Error opening mission boxes, resetting data: $e');
    try {
      await Hive.deleteBoxFromDisk(QuestRepository.questBoxName);
    } catch (_) {}
    try {
      await Hive.deleteBoxFromDisk(QuestRepository.statsBoxName);
    } catch (_) {}
    try {
      await Hive.deleteBoxFromDisk(QuestRepository.diaryBoxName);
    } catch (_) {}
    
    await Hive.openBox<LifeQuest>(QuestRepository.questBoxName);
    await Hive.openBox<UserQuestStats>(QuestRepository.statsBoxName);
    await Hive.openBox<AdventureDiaryEntry>(QuestRepository.diaryBoxName);
  }
  
  // Initialize onboarding storage
  await OnboardingStorage.init();

  runApp(const ProviderScope(child: NightTimerApp()));
}

class NightTimerApp extends StatelessWidget {
  const NightTimerApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('es'),
      ],
      home: const SplashScreen(),
    );
  }
}
