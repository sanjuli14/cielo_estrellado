// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Focus Night';

  @override
  String get splashEveryMinute => 'Every Minute Matters';

  @override
  String get splashEveryStar => 'Every Star Counts';

  @override
  String get homeActivateFocus => 'Activate your Focus';

  @override
  String homeLastSession(Object duration, Object stars) {
    return 'Last session: $duration min — $stars stars';
  }

  @override
  String get homeSessionCompleted => 'Session completed!';

  @override
  String homeMinutesFocus(Object minutes) {
    return '$minutes minutes of focus';
  }

  @override
  String homeStarsGenerated(Object stars) {
    return '$stars stars generated';
  }

  @override
  String get homeShareText => 'Today\'s sky is complete. Share it with friends';

  @override
  String get homeSwipeUpStats => 'Swipe up to see statistics';

  @override
  String get homeMuteTooltip => 'Mute music';

  @override
  String get homeUnmuteTooltip => 'Unmute music';

  @override
  String get homeReminderTooltip => 'Set daily reminder';

  @override
  String get homeReminderTitle => 'It\'s time to see the stars';

  @override
  String get homeReminderBody =>
      'Focus while you work, and generate a bright sky';

  @override
  String homeReminderSet(Object time) {
    return 'Daily reminder set at $time';
  }

  @override
  String get homeReminderDenied => 'Notification permissions denied';

  @override
  String get statsTitle => 'Statistics';

  @override
  String get statsDailyHours => 'Daily hours (last 7 days)';

  @override
  String get statsMonthlyStars => 'Monthly stars';

  @override
  String get statsNoData => 'No data available';

  @override
  String statsError(Object error) {
    return 'Error: $error';
  }

  @override
  String get statsUnitMin => 'min';

  @override
  String get statsUnitStars => 'stars';

  @override
  String constellationUnlocked(Object stars) {
    return 'Unlocked at $stars stars';
  }

  @override
  String get notifChannelName => 'Daily Reminders';

  @override
  String get notifChannelDesc => 'Channel for application usage reminders';
}
