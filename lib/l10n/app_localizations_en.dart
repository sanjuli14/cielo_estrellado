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
  String get homeReminderTitle => 'Keep your star streak!';

  @override
  String get homeReminderBody =>
      'Come in today so you don\'t lose your consecutive focus days.';

  @override
  String homeReminderSet(Object time) {
    return 'Streak reminder set at $time';
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

  @override
  String get onboardingWelcomeTitle => 'Welcome to Focus Night';

  @override
  String get onboardingWelcomeDesc =>
      'Turn your focus time into a beautiful starry sky full of constellations';

  @override
  String get onboardingStarsTitle => 'Generate Stars';

  @override
  String get onboardingStarsDesc =>
      'Every second of focus generates 3 stars. Work focused and fill your night sky';

  @override
  String get onboardingConstellationsTitle => 'Unlock Constellations';

  @override
  String get onboardingConstellationsDesc =>
      'Accumulate stars to discover 13 beautiful constellations. From Corona Borealis to Ursa Major';

  @override
  String get onboardingGoalsTitle => 'Set Your Goals';

  @override
  String get onboardingGoalsDesc =>
      'Set monthly star goals and maintain streaks of consecutive working days';

  @override
  String get onboardingDistractionsTitle => 'Eliminate Distractions';

  @override
  String get onboardingDistractionsDesc =>
      'Block apps that distract you during your deep focus sessions';

  @override
  String get onboardingProgressTitle => 'Analyze Your Progress';

  @override
  String get onboardingProgressDesc =>
      'Review detailed charts of your weekly and monthly productivity. Improve continuously';

  @override
  String get onboardingSkip => 'Skip';

  @override
  String get onboardingNext => 'Next';

  @override
  String get onboardingStart => 'Start';

  @override
  String get splashCopyright => 'Copyright (c) 2026. All rights reserved';

  @override
  String get blockerTitle => 'App Blocker';

  @override
  String get blockerUsageTitle => '1. Usage Access';

  @override
  String get blockerUsageDesc =>
      'We need to know which app you are currently using.\n\nFind \"Cielo Estrellado\" in the list and enable \"Allow usage access\".';

  @override
  String get blockerUsageBtn => 'Go to Usage Access';

  @override
  String get blockerOverlayTitle => '2. Appear on Top';

  @override
  String get blockerOverlayDesc =>
      'We need to block the screen when you open a restricted app.\n\nFind \"Cielo Estrellado\" and enable \"Allow display over other apps\".';

  @override
  String get blockerOverlayBtn => 'Go to Overlay Permission';

  @override
  String get constName_corona_borealis => 'Corona Borealis';

  @override
  String get constDesc_corona_borealis =>
      'A small and beautiful crown of stars.';

  @override
  String get constName_aries => 'Aries';

  @override
  String get constDesc_aries => 'The Ram. A small but brave constellation.';

  @override
  String get constName_crux => 'Crux';

  @override
  String get constDesc_crux =>
      'Emblematic constellation of the southern hemisphere.';

  @override
  String get constName_scorpius => 'Scorpius';

  @override
  String get constDesc_scorpius => 'Constellation with a hook shape.';

  @override
  String get constName_cygnus => 'Cygnus';

  @override
  String get constDesc_cygnus => 'Also known as the Northern Cross.';

  @override
  String get constName_draco => 'Draco';

  @override
  String get constDesc_draco => 'The Dragon that winds between the bears.';

  @override
  String get constName_lyra => 'Lyra';

  @override
  String get constDesc_lyra => 'Contains Vega, one of the brightest stars.';

  @override
  String get constName_pegasus => 'Pegasus';

  @override
  String get constDesc_pegasus => 'The Great Square of the winged horse.';

  @override
  String get constName_leo => 'Leo';

  @override
  String get constDesc_leo => 'One of the oldest constellations of the zodiac.';

  @override
  String get constName_andromeda => 'Andromeda';

  @override
  String get constDesc_andromeda =>
      'Chained to Pegasus, it contains the neighboring galaxy.';

  @override
  String get constName_orion => 'Orion';

  @override
  String get constDesc_orion =>
      'The Hunter. One of the most recognizable constellations.';

  @override
  String get constName_cassiopeia => 'Cassiopeia';

  @override
  String get constDesc_cassiopeia => 'The Queen. W shape.';

  @override
  String get constName_centaurus => 'Centaurus';

  @override
  String get constDesc_centaurus =>
      'One of the largest and brightest constellations.';

  @override
  String get constName_ursa_major => 'Ursa Major';

  @override
  String get constDesc_ursa_major => 'The Great Bear.';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsSound => 'Sound';

  @override
  String get settingsMuted => 'Muted';

  @override
  String get settingsActive => 'Active';

  @override
  String get settingsStats => 'Statistics';

  @override
  String get settingsStatsDesc => 'Monthly Statistics';

  @override
  String get settingsNotifs => 'Notifications';

  @override
  String get settingsNotifsDesc => 'Set daily reminders';

  @override
  String get settingsGoals => 'Personal Goals';

  @override
  String get settingsGoalsDesc => 'Configure your objectives';

  @override
  String get settingsBlocker => 'App Blocker';

  @override
  String get settingsBlockerDesc => 'Select apps to block';

  @override
  String get statsCatalog => 'Constellations Catalog';

  @override
  String get statsUnlocked => 'Unlocked!';

  @override
  String statsStarsRequired(Object count) {
    return 'Requires $count stars';
  }

  @override
  String get goalsTitle => 'Personal Goals';

  @override
  String get goalsYourProgress => 'Your Progress';

  @override
  String get goalsDefineObjectives => 'Define your productivity objectives';

  @override
  String get goalsSaveBtn => 'Save Goals';

  @override
  String get goalsSavedSuccess => 'Goals saved successfully';

  @override
  String get goalsItemStars => '⭐ Stars per month';

  @override
  String get goalsItemStreak => '🔥 Consecutive days';

  @override
  String get goalsHintStars => 'Ex: 100';

  @override
  String get goalsUnitStars => 'stars';

  @override
  String get goalsUnitDays => 'days';

  @override
  String goalsCurrentStreak(Object count) {
    return 'Current streak: $count days';
  }

  @override
  String goalsProgressStars(Object current, Object target) {
    return '$current - $target stars';
  }

  @override
  String get moonNew => 'New Moon';

  @override
  String get moonWaxingCrescent => 'Waxing Crescent';

  @override
  String get moonFirstQuarter => 'First Quarter';

  @override
  String get moonWaxingGibbous => 'Waxing Gibbous';

  @override
  String get moonFull => 'Full Moon';

  @override
  String get moonWaningGibbous => 'Waning Gibbous';

  @override
  String get moonLastQuarter => 'Last Quarter';

  @override
  String get moonWaningCrescent => 'Waning Crescent';

  @override
  String get rankStardust => 'Stardust';

  @override
  String get rankFlicker => 'Wandering Flicker';

  @override
  String get rankObserver => 'Star Observer';

  @override
  String get rankGuardian => 'Void Guardian';

  @override
  String get rankHunter => 'Nebula Hunter';

  @override
  String get rankVoyager => 'Intergalactic Voyager';

  @override
  String get rankMaster => 'Constellation Master';

  @override
  String get rankArchitect => 'Cosmic Architect';

  @override
  String get missionTitle => 'Missions';

  @override
  String get missionDaily => 'Daily';

  @override
  String get missionWeekly => 'Weekly';

  @override
  String get missionMilestones => 'Milestones';

  @override
  String get missionFocus1 => 'First Focus';

  @override
  String get missionFocus1Desc =>
      'Complete 1 focus session of at least 20 minutes.';

  @override
  String get missionStars500 => 'Stellar Harvest';

  @override
  String get missionStars500Desc => 'Collect 500 stars in a single day.';
}
