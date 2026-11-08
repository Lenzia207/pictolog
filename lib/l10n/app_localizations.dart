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

  /// Navigation label for the projects overview
  ///
  /// In en, this message translates to:
  /// **'Projects'**
  String get projects;

  /// Title of the home screen
  ///
  /// In en, this message translates to:
  /// **'Pictologs'**
  String get pictologs;

  /// Navigation label and title of the settings screen
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// Number of projects
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 project} other{{count} projects}}'**
  String projectsCount(int count);

  /// Number of pages
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 page} other{{count} pages}}'**
  String pagesCount(int count);

  /// Subtitle on the home screen when there are no pictologs
  ///
  /// In en, this message translates to:
  /// **'No projects yet'**
  String get noProjectsYet;

  /// Placeholder of the search field
  ///
  /// In en, this message translates to:
  /// **'Search pictologs'**
  String get searchPictologs;

  /// Shown when the search has no results
  ///
  /// In en, this message translates to:
  /// **'No pictologs found'**
  String get noSearchResults;

  /// Section label above the pictolog list
  ///
  /// In en, this message translates to:
  /// **'Recently edited'**
  String get recentlyEdited;

  /// Sort option
  ///
  /// In en, this message translates to:
  /// **'Newest first'**
  String get newestFirst;

  /// Sort option
  ///
  /// In en, this message translates to:
  /// **'Oldest first'**
  String get oldestFirst;

  /// Button and screen title to create a pictolog
  ///
  /// In en, this message translates to:
  /// **'New Pictolog'**
  String get newPictolog;

  /// Accessibility label of the select button
  ///
  /// In en, this message translates to:
  /// **'Select pictologs'**
  String get selectPictologs;

  /// Title of the empty state
  ///
  /// In en, this message translates to:
  /// **'Start your first Pictolog'**
  String get emptyTitle;

  /// Message of the empty state
  ///
  /// In en, this message translates to:
  /// **'Take photos, describe and arrange pages – Pictolog turns them into a clean PDF.'**
  String get emptyMessage;

  /// Button label to create a pictolog
  ///
  /// In en, this message translates to:
  /// **'Create Pictolog'**
  String get createPictolog;

  /// First step in the empty state
  ///
  /// In en, this message translates to:
  /// **'Create and name a project'**
  String get emptyStepCreate;

  /// Second step in the empty state
  ///
  /// In en, this message translates to:
  /// **'Add photos as pages'**
  String get emptyStepPhotos;

  /// Third step in the empty state
  ///
  /// In en, this message translates to:
  /// **'Create and share the PDF'**
  String get emptyStepPdf;

  /// Shows count of selected items
  ///
  /// In en, this message translates to:
  /// **'{count} selected'**
  String selectedItems(int count);

  /// Button to select all items
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get selectAll;

  /// Accessibility label of the button that leaves selection mode
  ///
  /// In en, this message translates to:
  /// **'End selection'**
  String get endSelection;

  /// Warning above the delete button
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 page will be permanently deleted.} other{{count} pages will be permanently deleted.}}'**
  String pagesWillBeDeleted(int count);

  /// Button to delete the selected pictologs
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Delete 1 Pictolog} other{Delete {count} Pictologs}}'**
  String deletePictologs(int count);

  /// Heading of the new pictolog form
  ///
  /// In en, this message translates to:
  /// **'What\'s it about?'**
  String get whatsItAbout;

  /// Hint below the heading of the new pictolog form
  ///
  /// In en, this message translates to:
  /// **'Title and description appear on the cover page of your PDF.'**
  String get newPictologHint;

  /// Generic title label
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get title;

  /// Placeholder for the project name field
  ///
  /// In en, this message translates to:
  /// **'Name of the project'**
  String get projectName;

  /// Validation error for an empty title
  ///
  /// In en, this message translates to:
  /// **'Please enter a title.'**
  String get titleRequired;

  /// Generic description label
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// Marks a field as optional
  ///
  /// In en, this message translates to:
  /// **'Optional'**
  String get optional;

  /// Placeholder for project description field
  ///
  /// In en, this message translates to:
  /// **'General description of the project …'**
  String get generalProjectDescription;

  /// Tip at the bottom of the new pictolog form
  ///
  /// In en, this message translates to:
  /// **'After saving, you add the first photos as pages right away.'**
  String get newPictologTip;

  /// Title of the edit pictolog screen
  ///
  /// In en, this message translates to:
  /// **'Edit Pictolog'**
  String get editPictolog;

  /// Save button label
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// Cancel button label
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Delete button label
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// Done button label
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// Accessibility label of close buttons
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// Accessibility label of back buttons
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// Accessibility label of the more button
  ///
  /// In en, this message translates to:
  /// **'More actions'**
  String get moreActions;

  /// Creation date chip
  ///
  /// In en, this message translates to:
  /// **'Created {date}'**
  String createdOn(String date);

  /// Last edited date chip
  ///
  /// In en, this message translates to:
  /// **'Edited {date}'**
  String editedOn(String date);

  /// Heading of the page grid
  ///
  /// In en, this message translates to:
  /// **'Pages'**
  String get pages;

  /// Button to change the page order
  ///
  /// In en, this message translates to:
  /// **'Sort'**
  String get sort;

  /// Shown on pages without a description
  ///
  /// In en, this message translates to:
  /// **'No description'**
  String get noDescription;

  /// Button to add a page
  ///
  /// In en, this message translates to:
  /// **'Page'**
  String get page;

  /// Button label to create PDF
  ///
  /// In en, this message translates to:
  /// **'Create PDF'**
  String get createPdf;

  /// Title when a pictolog has no pages
  ///
  /// In en, this message translates to:
  /// **'No pages yet'**
  String get noPagesYet;

  /// Hint when a pictolog has no pages
  ///
  /// In en, this message translates to:
  /// **'Add photos as pages with the \"Page\" button.'**
  String get noPagesHint;

  /// Action to delete a pictolog
  ///
  /// In en, this message translates to:
  /// **'Delete Pictolog'**
  String get deletePictolog;

  /// Confirmation message to delete a pictolog
  ///
  /// In en, this message translates to:
  /// **'This pictolog and all its pages will be permanently deleted.'**
  String get deletePictologConfirm;

  /// Title of the reorder screen
  ///
  /// In en, this message translates to:
  /// **'Change order'**
  String get changeOrder;

  /// Hint on the reorder screen
  ///
  /// In en, this message translates to:
  /// **'Drag a page by its handle to the desired position.'**
  String get reorderHint;

  /// Position of a page
  ///
  /// In en, this message translates to:
  /// **'Page {current} of {total}'**
  String pageOf(int current, int total);

  /// Title of the edit page sheet
  ///
  /// In en, this message translates to:
  /// **'Edit page'**
  String get editPage;

  /// Button to replace the image of a page
  ///
  /// In en, this message translates to:
  /// **'Replace'**
  String get replace;

  /// Accessibility label of the rotate button
  ///
  /// In en, this message translates to:
  /// **'Rotate image'**
  String get rotateImage;

  /// Action to delete a page
  ///
  /// In en, this message translates to:
  /// **'Delete page'**
  String get deletePage;

  /// Confirmation message to delete a page
  ///
  /// In en, this message translates to:
  /// **'This page will be permanently deleted.'**
  String get deletePageConfirm;

  /// Title of the image source sheet
  ///
  /// In en, this message translates to:
  /// **'Add page'**
  String get addPage;

  /// Subtitle of the image source sheet
  ///
  /// In en, this message translates to:
  /// **'Where does the image come from?'**
  String get whereFromImage;

  /// Camera option label
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get camera;

  /// Camera option description
  ///
  /// In en, this message translates to:
  /// **'Take a new photo'**
  String get takeNewPhoto;

  /// Gallery option label
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get gallery;

  /// Gallery option description
  ///
  /// In en, this message translates to:
  /// **'Choose an existing image'**
  String get chooseExistingImage;

  /// Number of the page being captured
  ///
  /// In en, this message translates to:
  /// **'Page {number}'**
  String pageNumber(int number);

  /// Hint on the camera screen
  ///
  /// In en, this message translates to:
  /// **'Tap the shutter'**
  String get tapShutter;

  /// Accessibility label of the shutter button
  ///
  /// In en, this message translates to:
  /// **'Take picture'**
  String get takePicture;

  /// Accessibility label of the camera close button
  ///
  /// In en, this message translates to:
  /// **'Close camera'**
  String get closeCamera;

  /// Error message when no camera is available
  ///
  /// In en, this message translates to:
  /// **'No camera found'**
  String get noCameraFound;

  /// Error message when taking a picture fails
  ///
  /// In en, this message translates to:
  /// **'Error taking picture: {error}'**
  String errorTakingPicture(String error);

  /// Error message when adding a page fails
  ///
  /// In en, this message translates to:
  /// **'Error adding page: {error}'**
  String errorAddingPage(String error);

  /// Error message when saving fails
  ///
  /// In en, this message translates to:
  /// **'Error saving: {error}'**
  String errorSaving(String error);

  /// Error message for 404 page
  ///
  /// In en, this message translates to:
  /// **'Page not found!'**
  String get pageNotFound;

  /// Title for PDF preview screen
  ///
  /// In en, this message translates to:
  /// **'PDF preview'**
  String get pdfPreview;

  /// Button to share the PDF
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// Button to save the PDF
  ///
  /// In en, this message translates to:
  /// **'Save PDF'**
  String get savePdf;

  /// Overline on the PDF cover page
  ///
  /// In en, this message translates to:
  /// **'Photo documentation'**
  String get photoDocumentation;

  /// Created date label
  ///
  /// In en, this message translates to:
  /// **'Created'**
  String get created;

  /// Edited date label
  ///
  /// In en, this message translates to:
  /// **'Edited'**
  String get edited;

  /// Settings section label
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// Settings section label
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get general;

  /// Theme selection label
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// Language selection label
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// Title of the language sheet
  ///
  /// In en, this message translates to:
  /// **'Select language'**
  String get selectLanguage;

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
