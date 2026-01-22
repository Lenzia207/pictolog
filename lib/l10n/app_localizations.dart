import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
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
    Locale('de'),
    Locale('en'),
  ];

  /// The application title
  ///
  /// In en, this message translates to:
  /// **'Pictolog'**
  String get appTitle;

  /// Navigation label for overview screen
  ///
  /// In en, this message translates to:
  /// **'My Pictologs'**
  String get myPictologs;

  /// Message shown when there are no pictologs
  ///
  /// In en, this message translates to:
  /// **'No pictologs yet.\nCreate one with the '**
  String get noPictologsMessage;

  /// Navigation label for settings screen
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// Account settings screen title
  ///
  /// In en, this message translates to:
  /// **'Account Settings'**
  String get accountSettings;

  /// Language selection label
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// Language selection dialog title
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguage;

  /// Title for new pictolog entry screen
  ///
  /// In en, this message translates to:
  /// **'New Pictolog Entry'**
  String get newPictologEntry;

  /// Generic title label
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get title;

  /// Label for project name field
  ///
  /// In en, this message translates to:
  /// **'Project Name'**
  String get projectName;

  /// Generic description label
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// Optional description label
  ///
  /// In en, this message translates to:
  /// **'Description (Optional)'**
  String get descriptionOptional;

  /// Placeholder for project description field
  ///
  /// In en, this message translates to:
  /// **'General project description...'**
  String get generalProjectDescription;

  /// Button label to save entry
  ///
  /// In en, this message translates to:
  /// **'Save Entry'**
  String get saveEntry;

  /// Label for number of pages
  ///
  /// In en, this message translates to:
  /// **'Pages'**
  String get pages;

  /// Shows the number of pages
  ///
  /// In en, this message translates to:
  /// **'{count} Pages'**
  String pagesCount(String count);

  /// Title for camera screen
  ///
  /// In en, this message translates to:
  /// **'Take a Picture'**
  String get takePicture;

  /// Error message when no camera is available
  ///
  /// In en, this message translates to:
  /// **'No camera found'**
  String get noCameraFound;

  /// Success message after taking picture
  ///
  /// In en, this message translates to:
  /// **'Picture taken: {path}'**
  String pictureTaken(String path);

  /// Dialog title to add description
  ///
  /// In en, this message translates to:
  /// **'Add Description'**
  String get addDescription;

  /// Cancel button label
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Save button label
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// Error message when adding report fails
  ///
  /// In en, this message translates to:
  /// **'Error adding report: {error}'**
  String errorAddingReport(String error);

  /// Success message when pictolog is created
  ///
  /// In en, this message translates to:
  /// **'New Pictolog Created!'**
  String get newPictologCreated;

  /// Error message when saving fails
  ///
  /// In en, this message translates to:
  /// **'Error saving: {error}'**
  String errorSaving(String error);

  /// Button label to create PDF
  ///
  /// In en, this message translates to:
  /// **'Create PDF'**
  String get createPdf;

  /// Button label to change order
  ///
  /// In en, this message translates to:
  /// **'Change Order'**
  String get changeOrder;

  /// Button label to add report
  ///
  /// In en, this message translates to:
  /// **'Add Report'**
  String get addReport;

  /// Message when there are no reports
  ///
  /// In en, this message translates to:
  /// **'No reports yet'**
  String get noReportsYet;

  /// Dialog title to edit report
  ///
  /// In en, this message translates to:
  /// **'Edit Report'**
  String get editReport;

  /// Dialog title to edit entry
  ///
  /// In en, this message translates to:
  /// **'Edit Entry'**
  String get editEntry;

  /// Label for project title field
  ///
  /// In en, this message translates to:
  /// **'Project Title'**
  String get projectTitle;

  /// Error message for 404 page
  ///
  /// In en, this message translates to:
  /// **'Page not found!'**
  String get pageNotFound;

  /// Shows count of selected items
  ///
  /// In en, this message translates to:
  /// **'{count} Selected'**
  String selectedItems(int count);

  /// Title for PDF preview screen
  ///
  /// In en, this message translates to:
  /// **'PDF Preview'**
  String get pdfPreview;

  /// Generic report label
  ///
  /// In en, this message translates to:
  /// **'Report'**
  String get report;

  /// PDF title page label
  ///
  /// In en, this message translates to:
  /// **'Title Page'**
  String get titlePage;

  /// PDF content page label
  ///
  /// In en, this message translates to:
  /// **'Content Page'**
  String get contentPage;

  /// Generic page label
  ///
  /// In en, this message translates to:
  /// **'Page'**
  String get page;

  /// Button text after icon in no pictologs message
  ///
  /// In en, this message translates to:
  /// **' Button!'**
  String get button;

  /// Message when there are no report entries
  ///
  /// In en, this message translates to:
  /// **'No entries yet.\n\nAdd a new entry under\n\"Add Report\"'**
  String get noEntriesYet;

  /// Created date label
  ///
  /// In en, this message translates to:
  /// **'Created'**
  String get created;

  /// Edited/Modified date label
  ///
  /// In en, this message translates to:
  /// **'Edited'**
  String get edited;

  /// Overview label
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get overview;

  /// Theme selection label
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// Theme selection dialog title
  ///
  /// In en, this message translates to:
  /// **'Select Theme'**
  String get selectTheme;

  /// Light theme mode label
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get lightMode;

  /// Dark theme mode label
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get darkMode;

  /// System theme mode label (follows device setting)
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get systemMode;

  /// Dialog title for choosing between camera or gallery
  ///
  /// In en, this message translates to:
  /// **'Choose Image Source'**
  String get chooseImageSource;

  /// Camera option label
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get camera;

  /// Gallery option label
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get gallery;
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
      <String>['de', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
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
