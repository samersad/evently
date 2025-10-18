import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

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
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @arabic.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get arabic;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// No description provided for @light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @letsStart.
  ///
  /// In en, this message translates to:
  /// **'Let’s Start'**
  String get letsStart;

  /// No description provided for @firstTapText1.
  ///
  /// In en, this message translates to:
  /// **'Personalize Your Experience'**
  String get firstTapText1;

  /// No description provided for @firstTapText2.
  ///
  /// In en, this message translates to:
  /// **'Choose your preferred theme and language to get started with a comfortable, tailored experience that suits your style.'**
  String get firstTapText2;

  /// No description provided for @onBoarding1Text1.
  ///
  /// In en, this message translates to:
  /// **'Find Events That Inspire You'**
  String get onBoarding1Text1;

  /// No description provided for @onBoarding1Text2.
  ///
  /// In en, this message translates to:
  /// **'Dive into a world of events crafted to fit your unique interests. Whether you\'re into live music, art workshops, professional networking, or simply discovering new experiences, we have something for everyone. Our curated recommendations will help you explore, connect, and make the most of every opportunity around you.'**
  String get onBoarding1Text2;

  /// No description provided for @onBoarding2Text1.
  ///
  /// In en, this message translates to:
  /// **'Effortless Event Planning'**
  String get onBoarding2Text1;

  /// No description provided for @onBoarding2Text2.
  ///
  /// In en, this message translates to:
  /// **'Take the hassle out of organizing events with our all-in-one planning tools. From setting up invites and managing RSVPs to scheduling reminders and coordinating details, we’ve got you covered. Plan with ease and focus on what matters – creating an unforgettable experience for you and your guests..'**
  String get onBoarding2Text2;

  /// No description provided for @onBoarding3Text1.
  ///
  /// In en, this message translates to:
  /// **'Connect with Friends & Share Moments'**
  String get onBoarding3Text1;

  /// No description provided for @onBoarding3Text2.
  ///
  /// In en, this message translates to:
  /// **'Make every event memorable by sharing the experience with others. Our platform lets you invite friends, keep everyone in the loop, and celebrate moments together. Capture and share the excitement with your network, so you can relive the highlights and cherish the memories.'**
  String get onBoarding3Text2;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @map.
  ///
  /// In en, this message translates to:
  /// **'Map'**
  String get map;

  /// No description provided for @love.
  ///
  /// In en, this message translates to:
  /// **'Love'**
  String get love;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back ✨'**
  String get welcomeBack;

  /// No description provided for @johnSafwat.
  ///
  /// In en, this message translates to:
  /// **'John Safwat'**
  String get johnSafwat;

  /// No description provided for @cairo.
  ///
  /// In en, this message translates to:
  /// **'Cairo'**
  String get cairo;

  /// No description provided for @egypt.
  ///
  /// In en, this message translates to:
  /// **'Egypt'**
  String get egypt;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @sport.
  ///
  /// In en, this message translates to:
  /// **'Sport'**
  String get sport;

  /// No description provided for @birthday.
  ///
  /// In en, this message translates to:
  /// **'Birthday'**
  String get birthday;

  /// No description provided for @meeting.
  ///
  /// In en, this message translates to:
  /// **'Meeting'**
  String get meeting;

  /// No description provided for @gaming.
  ///
  /// In en, this message translates to:
  /// **'Gaming'**
  String get gaming;

  /// No description provided for @work_shop.
  ///
  /// In en, this message translates to:
  /// **'Work Shop'**
  String get work_shop;

  /// No description provided for @book_club.
  ///
  /// In en, this message translates to:
  /// **'Book Club'**
  String get book_club;

  /// No description provided for @exhibition.
  ///
  /// In en, this message translates to:
  /// **'Exhibition'**
  String get exhibition;

  /// No description provided for @holiday.
  ///
  /// In en, this message translates to:
  /// **'Holiday'**
  String get holiday;

  /// No description provided for @eating.
  ///
  /// In en, this message translates to:
  /// **'Eating'**
  String get eating;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @forget_password.
  ///
  /// In en, this message translates to:
  /// **'Forget Password'**
  String get forget_password;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @dont_have_account.
  ///
  /// In en, this message translates to:
  /// **'Don’t Have Account '**
  String get dont_have_account;

  /// No description provided for @create_account.
  ///
  /// In en, this message translates to:
  /// **' Create Account'**
  String get create_account;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'Or'**
  String get or;

  /// No description provided for @login_with_google.
  ///
  /// In en, this message translates to:
  /// **'Login With Google'**
  String get login_with_google;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @re_password.
  ///
  /// In en, this message translates to:
  /// **'Re Password'**
  String get re_password;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @already_have_account.
  ///
  /// In en, this message translates to:
  /// **'Already Have Account '**
  String get already_have_account;

  /// No description provided for @reset_password.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get reset_password;

  /// No description provided for @pleaseEnterEmail.
  ///
  /// In en, this message translates to:
  /// **'Please Enter an Email'**
  String get pleaseEnterEmail;

  /// No description provided for @pleaseEnterValidEmail.
  ///
  /// In en, this message translates to:
  /// **'Please Enter a Valid Email'**
  String get pleaseEnterValidEmail;

  /// No description provided for @pleaseEnterPassword.
  ///
  /// In en, this message translates to:
  /// **'Please Enter a Password'**
  String get pleaseEnterPassword;

  /// No description provided for @pleaseEnterAtLeast6Char.
  ///
  /// In en, this message translates to:
  /// **'Please Enter at Least 6 Characters'**
  String get pleaseEnterAtLeast6Char;

  /// No description provided for @pleaseEnterName.
  ///
  /// In en, this message translates to:
  /// **'Please Enter a Name'**
  String get pleaseEnterName;

  /// No description provided for @rePasswordMustMatch.
  ///
  /// In en, this message translates to:
  /// **'Re-entered Password Must Match'**
  String get rePasswordMustMatch;

  /// No description provided for @createEvent.
  ///
  /// In en, this message translates to:
  /// **'Create Event'**
  String get createEvent;

  /// No description provided for @searchForEvent.
  ///
  /// In en, this message translates to:
  /// **'Search for Event'**
  String get searchForEvent;

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get title;

  /// No description provided for @event_Title.
  ///
  /// In en, this message translates to:
  /// **'Event Title'**
  String get event_Title;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @eventDescription.
  ///
  /// In en, this message translates to:
  /// **'Event Description'**
  String get eventDescription;

  /// No description provided for @eventDate.
  ///
  /// In en, this message translates to:
  /// **'Event Date'**
  String get eventDate;

  /// No description provided for @chooseDate.
  ///
  /// In en, this message translates to:
  /// **'Choose Date'**
  String get chooseDate;

  /// No description provided for @eventTime.
  ///
  /// In en, this message translates to:
  /// **'Event Time'**
  String get eventTime;

  /// No description provided for @chooseTime.
  ///
  /// In en, this message translates to:
  /// **'Choose Time'**
  String get chooseTime;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @chooseEventLocation.
  ///
  /// In en, this message translates to:
  /// **'Choose Event Location'**
  String get chooseEventLocation;

  /// No description provided for @addEvent.
  ///
  /// In en, this message translates to:
  /// **'Add Event'**
  String get addEvent;

  /// No description provided for @pleaseEnterEventTitle.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Event Title'**
  String get pleaseEnterEventTitle;

  /// No description provided for @pleaseEnterEventDescription.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Event Description'**
  String get pleaseEnterEventDescription;

  /// No description provided for @pleaseChooseDate.
  ///
  /// In en, this message translates to:
  /// **'Please Choose Date'**
  String get pleaseChooseDate;

  /// No description provided for @pleaseChooseTime.
  ///
  /// In en, this message translates to:
  /// **'Please Choose Time'**
  String get pleaseChooseTime;

  /// No description provided for @eventDetails.
  ///
  /// In en, this message translates to:
  /// **'Event Details'**
  String get eventDetails;

  /// No description provided for @editEvent.
  ///
  /// In en, this message translates to:
  /// **'Edit Event'**
  String get editEvent;

  /// No description provided for @updateEvent.
  ///
  /// In en, this message translates to:
  /// **'Update Event'**
  String get updateEvent;

  /// No description provided for @no_favorite_events_founded.
  ///
  /// In en, this message translates to:
  /// **'No Favorite Events Founded '**
  String get no_favorite_events_founded;

  /// No description provided for @no_events_founded.
  ///
  /// In en, this message translates to:
  /// **'No Events Founded '**
  String get no_events_founded;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'loading....'**
  String get loading;

  /// No description provided for @register_successfully.
  ///
  /// In en, this message translates to:
  /// **'register Successfully'**
  String get register_successfully;

  /// No description provided for @login_successfully.
  ///
  /// In en, this message translates to:
  /// **'Login Successfully'**
  String get login_successfully;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'Ok'**
  String get ok;

  /// No description provided for @dismiss.
  ///
  /// In en, this message translates to:
  /// **'Dismiss'**
  String get dismiss;

  /// No description provided for @weak_password.
  ///
  /// In en, this message translates to:
  /// **'weak-password'**
  String get weak_password;

  /// No description provided for @email_already_in_use.
  ///
  /// In en, this message translates to:
  /// **'email-already-in-use'**
  String get email_already_in_use;

  /// No description provided for @no_user_found_for_that_email_or_wrong_password.
  ///
  /// In en, this message translates to:
  /// **'No user found for that email or wrong password'**
  String get no_user_found_for_that_email_or_wrong_password;

  /// No description provided for @google_sign_in_error.
  ///
  /// In en, this message translates to:
  /// **'Google Sign-In Error'**
  String get google_sign_in_error;

  /// No description provided for @please_choose_event_date.
  ///
  /// In en, this message translates to:
  /// **'please Choose Event Date'**
  String get please_choose_event_date;

  /// No description provided for @please_choose_event_time.
  ///
  /// In en, this message translates to:
  /// **'please Choose Event Time'**
  String get please_choose_event_time;

  /// No description provided for @event_added_successfully.
  ///
  /// In en, this message translates to:
  /// **'Event Added Successfully'**
  String get event_added_successfully;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;
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
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
