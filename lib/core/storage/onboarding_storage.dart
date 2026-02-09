import 'package:hive/hive.dart';

class OnboardingStorage {
  static const String _boxName = 'onboarding_prefs';
  static const String _completedKey = 'onboarding_completed';

  static Future<void> init() async {
    await Hive.openBox(_boxName);
  }

  static bool isOnboardingCompleted() {
    final box = Hive.box(_boxName);
    return box.get(_completedKey, defaultValue: false) as bool;
  }

  static Future<void> setOnboardingCompleted() async {
    final box = Hive.box(_boxName);
    await box.put(_completedKey, true);
  }

  static Future<void> resetOnboarding() async {
    final box = Hive.box(_boxName);
    await box.put(_completedKey, false);
  }
}
