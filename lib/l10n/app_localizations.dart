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
  /// **'It\'s time to see the stars'**
  String get homeReminderTitle;

  /// No description provided for @homeReminderBody.
  ///
  /// In en, this message translates to:
  /// **'Focus while you work, and generate a bright sky'**
  String get homeReminderBody;

  /// No description provided for @homeReminderSet.
  ///
  /// In en, this message translates to:
  /// **'Daily reminder set at {time}'**
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
