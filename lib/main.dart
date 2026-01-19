import 'package:cielo_estrellado/models/sessions.dart';
import 'package:cielo_estrellado/presentation/screen/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(SessionAdapter());
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
      home: const HomeScreen(),
    );
  }
}
