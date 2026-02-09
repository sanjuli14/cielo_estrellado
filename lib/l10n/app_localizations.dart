import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Focus Night'**
  String get appTitle;

  /// No description provided for @splashEveryMinute.
  ///
  /// In en, this message translates to:
  /// **'Every Minute Matters'**
  String get splashEveryMinute;

  /// No description provided for @splashEveryStar.
  ///
  /// In en, this message translates to:
  /// **'Every Star Counts'**
  String get splashEveryStar;

  /// No description provided for @homeActivateFocus.
  ///
  /// In en, this message translates to:
  /// **'Activate your Focus'**
  String get homeActivateFocus;

  /// No description provided for @homeLastSession.
  ///
  /// In en, this message translates to:
  /// **'Last session: {duration} min — {stars} stars'**
  String homeLastSession(Object duration, Object stars);

  /// No description provided for @homeSessionCompleted.
  ///
  /// In en, this message translates to:
  /// **'Session completed!'**
  String get homeSessionCompleted;

  /// No description provided for @homeMinutesFocus.
  ///
  /// In en, this message translates to:
  /// **'{minutes} minutes of focus'**
  String homeMinutesFocus(Object minutes);

  /// No description provided for @homeStarsGenerated.
  ///
  /// In en, this message translates to:
  /// **'{stars} stars generated'**
  String homeStarsGenerated(Object stars);

  /// No description provided for @homeShareText.
  ///
  /// In en, this message translates to:
  /// **'Today\'s sky is complete. Share it with friends'**
  String get homeShareText;

  /// No description provided for @homeSwipeUpStats.
  ///
  /// In en, this message translates to:
  /// **'Swipe up to see statistics'**
  String get homeSwipeUpStats;

  /// No description provided for @homeMuteTooltip.
  ///
  /// In en, this message translates to:
  /// **'Mute music'**
  String get homeMuteTooltip;

  /// No description provided for @homeUnmuteTooltip.
  ///
  /// In en, this message translates to:
  /// **'Unmute music'**
  String get homeUnmuteTooltip;

  /// No description provided for @homeReminderTooltip.
  ///
  /// In en, this message translates to:
  /// **'Set daily reminder'**
  String get homeReminderTooltip;

  /// No description provided for @homeReminderTitle.
  ///
  /// In en, this message translates to:
  /// **'Keep your star streak!'**
  String get homeReminderTitle;

  /// No description provided for @homeReminderBody.
  ///
  /// In en, this message translates to:
  /// **'Come in today so you don\'t lose your consecutive focus days.'**
  String get homeReminderBody;

  /// No description provided for @homeReminderSet.
  ///
  /// In en, this message translates to:
  /// **'Streak reminder set at {time}'**
  String homeReminderSet(Object time);

  /// No description provided for @homeReminderDenied.
  ///
  /// In en, this message translates to:
  /// **'Notification permissions denied'**
  String get homeReminderDenied;

  /// No description provided for @statsTitle.
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get statsTitle;

  /// No description provided for @statsDailyHours.
  ///
  /// In en, this message translates to:
  /// **'Daily hours (last 7 days)'**
  String get statsDailyHours;

  /// No description provided for @statsMonthlyStars.
  ///
  /// In en, this message translates to:
  /// **'Monthly stars'**
  String get statsMonthlyStars;

  /// No description provided for @statsNoData.
  ///
  /// In en, this message translates to:
  /// **'No data available'**
  String get statsNoData;

  /// No description provided for @statsError.
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String statsError(Object error);

  /// No description provided for @statsUnitMin.
  ///
  /// In en, this message translates to:
  /// **'min'**
  String get statsUnitMin;

  /// No description provided for @statsUnitStars.
  ///
  /// In en, this message translates to:
  /// **'stars'**
  String get statsUnitStars;

  /// No description provided for @constellationUnlocked.
  ///
  /// In en, this message translates to:
  /// **'Unlocked at {stars} stars'**
  String constellationUnlocked(Object stars);

  /// No description provided for @notifChannelName.
  ///
  /// In en, this message translates to:
  /// **'Daily Reminders'**
  String get notifChannelName;

  /// No description provided for @notifChannelDesc.
  ///
  /// In en, this message translates to:
  /// **'Channel for application usage reminders'**
  String get notifChannelDesc;

  /// No description provided for @onboardingWelcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Focus Night'**
  String get onboardingWelcomeTitle;

  /// No description provided for @onboardingWelcomeDesc.
  ///
  /// In en, this message translates to:
  /// **'Turn your focus time into a beautiful starry sky full of constellations'**
  String get onboardingWelcomeDesc;

  /// No description provided for @onboardingStarsTitle.
  ///
  /// In en, this message translates to:
  /// **'Generate Stars'**
  String get onboardingStarsTitle;

  /// No description provided for @onboardingStarsDesc.
  ///
  /// In en, this message translates to:
  /// **'Every second of focus generates 3 stars. Work focused and fill your night sky'**
  String get onboardingStarsDesc;

  /// No description provided for @onboardingConstellationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Unlock Constellations'**
  String get onboardingConstellationsTitle;

  /// No description provided for @onboardingConstellationsDesc.
  ///
  /// In en, this message translates to:
  /// **'Accumulate stars to discover 13 beautiful constellations. From Corona Borealis to Ursa Major'**
  String get onboardingConstellationsDesc;

  /// No description provided for @onboardingGoalsTitle.
  ///
  /// In en, this message translates to:
  /// **'Set Your Goals'**
  String get onboardingGoalsTitle;

  /// No description provided for @onboardingGoalsDesc.
  ///
  /// In en, this message translates to:
  /// **'Set monthly star goals and maintain streaks of consecutive working days'**
  String get onboardingGoalsDesc;

  /// No description provided for @onboardingDistractionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Eliminate Distractions'**
  String get onboardingDistractionsTitle;

  /// No description provided for @onboardingDistractionsDesc.
  ///
  /// In en, this message translates to:
  /// **'Block apps that distract you during your deep focus sessions'**
  String get onboardingDistractionsDesc;

  /// No description provided for @onboardingProgressTitle.
  ///
  /// In en, this message translates to:
  /// **'Analyze Your Progress'**
  String get onboardingProgressTitle;

  /// No description provided for @onboardingProgressDesc.
  ///
  /// In en, this message translates to:
  /// **'Review detailed charts of your weekly and monthly productivity. Improve continuously'**
  String get onboardingProgressDesc;

  /// No description provided for @onboardingSkip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get onboardingSkip;

  /// No description provided for @onboardingNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get onboardingNext;

  /// No description provided for @onboardingStart.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get onboardingStart;

  /// No description provided for @splashCopyright.
  ///
  /// In en, this message translates to:
  /// **'Copyright (c) 2026. All rights reserved'**
  String get splashCopyright;

  /// No description provided for @blockerTitle.
  ///
  /// In en, this message translates to:
  /// **'App Blocker'**
  String get blockerTitle;

  /// No description provided for @blockerUsageTitle.
  ///
  /// In en, this message translates to:
  /// **'1. Usage Access'**
  String get blockerUsageTitle;

  /// No description provided for @blockerUsageDesc.
  ///
  /// In en, this message translates to:
  /// **'We need to know which app you are currently using.\n\nFind \"Cielo Estrellado\" in the list and enable \"Allow usage access\".'**
  String get blockerUsageDesc;

  /// No description provided for @blockerUsageBtn.
  ///
  /// In en, this message translates to:
  /// **'Go to Usage Access'**
  String get blockerUsageBtn;

  /// No description provided for @blockerOverlayTitle.
  ///
  /// In en, this message translates to:
  /// **'2. Appear on Top'**
  String get blockerOverlayTitle;

  /// No description provided for @blockerOverlayDesc.
  ///
  /// In en, this message translates to:
  /// **'We need to block the screen when you open a restricted app.\n\nFind \"Cielo Estrellado\" and enable \"Allow display over other apps\".'**
  String get blockerOverlayDesc;

  /// No description provided for @blockerOverlayBtn.
  ///
  /// In en, this message translates to:
  /// **'Go to Overlay Permission'**
  String get blockerOverlayBtn;

  /// No description provided for @constName_corona_borealis.
  ///
  /// In en, this message translates to:
  /// **'Corona Borealis'**
  String get constName_corona_borealis;

  /// No description provided for @constDesc_corona_borealis.
  ///
  /// In en, this message translates to:
  /// **'A small and beautiful crown of stars.'**
  String get constDesc_corona_borealis;

  /// No description provided for @constName_aries.
  ///
  /// In en, this message translates to:
  /// **'Aries'**
  String get constName_aries;

  /// No description provided for @constDesc_aries.
  ///
  /// In en, this message translates to:
  /// **'The Ram. A small but brave constellation.'**
  String get constDesc_aries;

  /// No description provided for @constName_crux.
  ///
  /// In en, this message translates to:
  /// **'Crux'**
  String get constName_crux;

  /// No description provided for @constDesc_crux.
  ///
  /// In en, this message translates to:
  /// **'Emblematic constellation of the southern hemisphere.'**
  String get constDesc_crux;

  /// No description provided for @constName_scorpius.
  ///
  /// In en, this message translates to:
  /// **'Scorpius'**
  String get constName_scorpius;

  /// No description provided for @constDesc_scorpius.
  ///
  /// In en, this message translates to:
  /// **'Constellation with a hook shape.'**
  String get constDesc_scorpius;

  /// No description provided for @constName_cygnus.
  ///
  /// In en, this message translates to:
  /// **'Cygnus'**
  String get constName_cygnus;

  /// No description provided for @constDesc_cygnus.
  ///
  /// In en, this message translates to:
  /// **'Also known as the Northern Cross.'**
  String get constDesc_cygnus;

  /// No description provided for @constName_draco.
  ///
  /// In en, this message translates to:
  /// **'Draco'**
  String get constName_draco;

  /// No description provided for @constDesc_draco.
  ///
  /// In en, this message translates to:
  /// **'The Dragon that winds between the bears.'**
  String get constDesc_draco;

  /// No description provided for @constName_lyra.
  ///
  /// In en, this message translates to:
  /// **'Lyra'**
  String get constName_lyra;

  /// No description provided for @constDesc_lyra.
  ///
  /// In en, this message translates to:
  /// **'Contains Vega, one of the brightest stars.'**
  String get constDesc_lyra;

  /// No description provided for @constName_pegasus.
  ///
  /// In en, this message translates to:
  /// **'Pegasus'**
  String get constName_pegasus;

  /// No description provided for @constDesc_pegasus.
  ///
  /// In en, this message translates to:
  /// **'The Great Square of the winged horse.'**
  String get constDesc_pegasus;

  /// No description provided for @constName_leo.
  ///
  /// In en, this message translates to:
  /// **'Leo'**
  String get constName_leo;

  /// No description provided for @constDesc_leo.
  ///
  /// In en, this message translates to:
  /// **'One of the oldest constellations of the zodiac.'**
  String get constDesc_leo;

  /// No description provided for @constName_andromeda.
  ///
  /// In en, this message translates to:
  /// **'Andromeda'**
  String get constName_andromeda;

  /// No description provided for @constDesc_andromeda.
  ///
  /// In en, this message translates to:
  /// **'Chained to Pegasus, it contains the neighboring galaxy.'**
  String get constDesc_andromeda;

  /// No description provided for @constName_orion.
  ///
  /// In en, this message translates to:
  /// **'Orion'**
  String get constName_orion;

  /// No description provided for @constDesc_orion.
  ///
  /// In en, this message translates to:
  /// **'The Hunter. One of the most recognizable constellations.'**
  String get constDesc_orion;

  /// No description provided for @constName_cassiopeia.
  ///
  /// In en, this message translates to:
  /// **'Cassiopeia'**
  String get constName_cassiopeia;

  /// No description provided for @constDesc_cassiopeia.
  ///
  /// In en, this message translates to:
  /// **'The Queen. W shape.'**
  String get constDesc_cassiopeia;

  /// No description provided for @constName_centaurus.
  ///
  /// In en, this message translates to:
  /// **'Centaurus'**
  String get constName_centaurus;

  /// No description provided for @constDesc_centaurus.
  ///
  /// In en, this message translates to:
  /// **'One of the largest and brightest constellations.'**
  String get constDesc_centaurus;

  /// No description provided for @constName_ursa_major.
  ///
  /// In en, this message translates to:
  /// **'Ursa Major'**
  String get constName_ursa_major;

  /// No description provided for @constDesc_ursa_major.
  ///
  /// In en, this message translates to:
  /// **'The Great Bear.'**
  String get constDesc_ursa_major;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @settingsSound.
  ///
  /// In en, this message translates to:
  /// **'Sound'**
  String get settingsSound;

  /// No description provided for @settingsMuted.
  ///
  /// In en, this message translates to:
  /// **'Muted'**
  String get settingsMuted;

  /// No description provided for @settingsActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get settingsActive;

  /// No description provided for @settingsStats.
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get settingsStats;

  /// No description provided for @settingsStatsDesc.
  ///
  /// In en, this message translates to:
  /// **'Monthly Statistics'**
  String get settingsStatsDesc;

  /// No description provided for @settingsNotifs.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get settingsNotifs;

  /// No description provided for @settingsNotifsDesc.
  ///
  /// In en, this message translates to:
  /// **'Set daily reminders'**
  String get settingsNotifsDesc;

  /// No description provided for @settingsGoals.
  ///
  /// In en, this message translates to:
  /// **'Personal Goals'**
  String get settingsGoals;

  /// No description provided for @settingsGoalsDesc.
  ///
  /// In en, this message translates to:
  /// **'Configure your objectives'**
  String get settingsGoalsDesc;

  /// No description provided for @settingsBlocker.
  ///
  /// In en, this message translates to:
  /// **'App Blocker'**
  String get settingsBlocker;

  /// No description provided for @settingsBlockerDesc.
  ///
  /// In en, this message translates to:
  /// **'Select apps to block'**
  String get settingsBlockerDesc;

  /// No description provided for @statsCatalog.
  ///
  /// In en, this message translates to:
  /// **'Constellations Catalog'**
  String get statsCatalog;

  /// No description provided for @statsUnlocked.
  ///
  /// In en, this message translates to:
  /// **'Unlocked!'**
  String get statsUnlocked;

  /// No description provided for @statsStarsRequired.
  ///
  /// In en, this message translates to:
  /// **'Requires {count} stars'**
  String statsStarsRequired(Object count);

  /// No description provided for @goalsTitle.
  ///
  /// In en, this message translates to:
  /// **'Personal Goals'**
  String get goalsTitle;

  /// No description provided for @goalsYourProgress.
  ///
  /// In en, this message translates to:
  /// **'Your Progress'**
  String get goalsYourProgress;

  /// No description provided for @goalsDefineObjectives.
  ///
  /// In en, this message translates to:
  /// **'Define your productivity objectives'**
  String get goalsDefineObjectives;

  /// No description provided for @goalsSaveBtn.
  ///
  /// In en, this message translates to:
  /// **'Save Goals'**
  String get goalsSaveBtn;

  /// No description provided for @goalsSavedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Goals saved successfully'**
  String get goalsSavedSuccess;

  /// No description provided for @goalsItemStars.
  ///
  /// In en, this message translates to:
  /// **'⭐ Stars per month'**
  String get goalsItemStars;

  /// No description provided for @goalsItemStreak.
  ///
  /// In en, this message translates to:
  /// **'🔥 Consecutive days'**
  String get goalsItemStreak;

  /// No description provided for @goalsHintStars.
  ///
  /// In en, this message translates to:
  /// **'Ex: 100'**
  String get goalsHintStars;

  /// No description provided for @goalsUnitStars.
  ///
  /// In en, this message translates to:
  /// **'stars'**
  String get goalsUnitStars;

  /// No description provided for @goalsUnitDays.
  ///
  /// In en, this message translates to:
  /// **'days'**
  String get goalsUnitDays;

  /// No description provided for @goalsCurrentStreak.
  ///
  /// In en, this message translates to:
  /// **'Current streak: {count} days'**
  String goalsCurrentStreak(Object count);

  /// No description provided for @goalsProgressStars.
  ///
  /// In en, this message translates to:
  /// **'{current} - {target} stars'**
  String goalsProgressStars(Object current, Object target);

  /// No description provided for @moonNew.
  ///
  /// In en, this message translates to:
  /// **'New Moon'**
  String get moonNew;

  /// No description provided for @moonWaxingCrescent.
  ///
  /// In en, this message translates to:
  /// **'Waxing Crescent'**
  String get moonWaxingCrescent;

  /// No description provided for @moonFirstQuarter.
  ///
  /// In en, this message translates to:
  /// **'First Quarter'**
  String get moonFirstQuarter;

  /// No description provided for @moonWaxingGibbous.
  ///
  /// In en, this message translates to:
  /// **'Waxing Gibbous'**
  String get moonWaxingGibbous;

  /// No description provided for @moonFull.
  ///
  /// In en, this message translates to:
  /// **'Full Moon'**
  String get moonFull;

  /// No description provided for @moonWaningGibbous.
  ///
  /// In en, this message translates to:
  /// **'Waning Gibbous'**
  String get moonWaningGibbous;

  /// No description provided for @moonLastQuarter.
  ///
  /// In en, this message translates to:
  /// **'Last Quarter'**
  String get moonLastQuarter;

  /// No description provided for @moonWaningCrescent.
  ///
  /// In en, this message translates to:
  /// **'Waning Crescent'**
  String get moonWaningCrescent;

  /// No description provided for @rankStardust.
  ///
  /// In en, this message translates to:
  /// **'Stardust'**
  String get rankStardust;

  /// No description provided for @rankFlicker.
  ///
  /// In en, this message translates to:
  /// **'Wandering Flicker'**
  String get rankFlicker;

  /// No description provided for @rankObserver.
  ///
  /// In en, this message translates to:
  /// **'Star Observer'**
  String get rankObserver;

  /// No description provided for @rankGuardian.
  ///
  /// In en, this message translates to:
  /// **'Void Guardian'**
  String get rankGuardian;

  /// No description provided for @rankHunter.
  ///
  /// In en, this message translates to:
  /// **'Nebula Hunter'**
  String get rankHunter;

  /// No description provided for @rankVoyager.
  ///
  /// In en, this message translates to:
  /// **'Intergalactic Voyager'**
  String get rankVoyager;

  /// No description provided for @rankMaster.
  ///
  /// In en, this message translates to:
  /// **'Constellation Master'**
  String get rankMaster;

  /// No description provided for @rankArchitect.
  ///
  /// In en, this message translates to:
  /// **'Cosmic Architect'**
  String get rankArchitect;

  /// No description provided for @missionTitle.
  ///
  /// In en, this message translates to:
  /// **'Missions'**
  String get missionTitle;

  /// No description provided for @missionDaily.
  ///
  /// In en, this message translates to:
  /// **'Daily'**
  String get missionDaily;

  /// No description provided for @missionWeekly.
  ///
  /// In en, this message translates to:
  /// **'Weekly'**
  String get missionWeekly;

  /// No description provided for @missionMilestones.
  ///
  /// In en, this message translates to:
  /// **'Milestones'**
  String get missionMilestones;

  /// No description provided for @missionFocus1.
  ///
  /// In en, this message translates to:
  /// **'First Focus'**
  String get missionFocus1;

  /// No description provided for @missionFocus1Desc.
  ///
  /// In en, this message translates to:
  /// **'Complete 1 focus session of at least 20 minutes.'**
  String get missionFocus1Desc;

  /// No description provided for @missionStars500.
  ///
  /// In en, this message translates to:
  /// **'Stellar Harvest'**
  String get missionStars500;

  /// No description provided for @missionStars500Desc.
  ///
  /// In en, this message translates to:
  /// **'Collect 500 stars in a single day.'**
  String get missionStars500Desc;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
