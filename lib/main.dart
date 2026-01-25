import 'package:cielo_estrellado/models/day_stats.dart';
import 'package:cielo_estrellado/models/period_summary.dart';
import 'package:cielo_estrellado/models/sessions.dart';
import 'package:cielo_estrellado/presentation/screen/home/home_screen.dart';
import 'package:cielo_estrellado/presentation/screen/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'core/theme/app_theme.dart';
import 'package:cielo_estrellado/core/notifications/notification_service.dart';
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
  await Hive.openBox<Session>('sessions');

  runApp(const ProviderScope(child: NightTimerApp()));
}

class NightTimerApp extends StatelessWidget {
  const NightTimerApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Focus Night',
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
