// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Pictolog';

  @override
  String get myPictologs => 'My Pictologs';

  @override
  String get noPictologsMessage => 'No pictologs yet.\nCreate one with the ';

  @override
  String get settings => 'Settings';

  @override
  String get accountSettings => 'Account Settings';

  @override
  String get language => 'Language';

  @override
  String get selectLanguage => 'Select Language';

  @override
  String get newPictologEntry => 'New Pictolog Entry';

  @override
  String get title => 'Title';

  @override
  String get projectName => 'Project Name';

  @override
  String get description => 'Description';

  @override
  String get descriptionOptional => 'Description (Optional)';

  @override
  String get generalProjectDescription => 'General project description...';

  @override
  String get saveEntry => 'Save Entry';

  @override
  String get pages => 'Pages';

  @override
  String pagesCount(String count) {
    return '$count Pages';
  }

  @override
  String get takePicture => 'Take a Picture';

  @override
  String get noCameraFound => 'No camera found';

  @override
  String pictureTaken(String path) {
    return 'Picture taken: $path';
  }

  @override
  String get addDescription => 'Add Description';

  @override
  String get cancel => 'Cancel';

  @override
  String get save => 'Save';

  @override
  String errorAddingReport(String error) {
    return 'Error adding report: $error';
  }

  @override
  String get newPictologCreated => 'New Pictolog Created!';

  @override
  String errorSaving(String error) {
    return 'Error saving: $error';
  }

  @override
  String get createPdf => 'Create PDF';

  @override
  String get changeOrder => 'Change Order';

  @override
  String get addReport => 'Add Report';

  @override
  String get noReportsYet => 'No reports yet';

  @override
  String get editReport => 'Edit Report';

  @override
  String get editEntry => 'Edit Entry';

  @override
  String get projectTitle => 'Project Title';

  @override
  String get pageNotFound => 'Page not found!';

  @override
  String selectedItems(int count) {
    return '$count Selected';
  }

  @override
  String get pdfPreview => 'PDF Preview';

  @override
  String get report => 'Report';

  @override
  String get titlePage => 'Title Page';

  @override
  String get contentPage => 'Content Page';

  @override
  String get page => 'Page';

  @override
  String get button => ' Button!';

  @override
  String get noEntriesYet =>
      'No entries yet.\n\nAdd a new entry under\n\"Add Report\"';

  @override
  String get created => 'Created';

  @override
  String get edited => 'Edited';

  @override
  String get overview => 'Overview';
}
