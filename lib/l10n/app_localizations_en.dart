// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get projects => 'Projects';

  @override
  String get pictologs => 'Pictologs';

  @override
  String get settings => 'Settings';

  @override
  String projectsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count projects',
      one: '1 project',
    );
    return '$_temp0';
  }

  @override
  String pagesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count pages',
      one: '1 page',
    );
    return '$_temp0';
  }

  @override
  String get noProjectsYet => 'No projects yet';

  @override
  String get searchPictologs => 'Search pictologs';

  @override
  String get noSearchResults => 'No pictologs found';

  @override
  String get recentlyEdited => 'Recently edited';

  @override
  String get newestFirst => 'Newest first';

  @override
  String get oldestFirst => 'Oldest first';

  @override
  String get newPictolog => 'New Pictolog';

  @override
  String get selectPictologs => 'Select pictologs';

  @override
  String get emptyTitle => 'Start your first Pictolog';

  @override
  String get emptyMessage =>
      'Take photos, describe and arrange pages – Pictolog turns them into a clean PDF.';

  @override
  String get createPictolog => 'Create Pictolog';

  @override
  String get emptyStepCreate => 'Create and name a project';

  @override
  String get emptyStepPhotos => 'Add photos as pages';

  @override
  String get emptyStepPdf => 'Create and share the PDF';

  @override
  String selectedItems(int count) {
    return '$count selected';
  }

  @override
  String get selectAll => 'All';

  @override
  String get endSelection => 'End selection';

  @override
  String pagesWillBeDeleted(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count pages will be permanently deleted.',
      one: '1 page will be permanently deleted.',
    );
    return '$_temp0';
  }

  @override
  String deletePictologs(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Delete $count Pictologs',
      one: 'Delete 1 Pictolog',
    );
    return '$_temp0';
  }

  @override
  String get whatsItAbout => 'What\'s it about?';

  @override
  String get newPictologHint =>
      'Title and description appear on the cover page of your PDF.';

  @override
  String get title => 'Title';

  @override
  String get projectName => 'Name of the project';

  @override
  String get titleRequired => 'Please enter a title.';

  @override
  String get description => 'Description';

  @override
  String get optional => 'Optional';

  @override
  String get generalProjectDescription =>
      'General description of the project …';

  @override
  String get newPictologTip =>
      'After saving, you add the first photos as pages right away.';

  @override
  String get editPictolog => 'Edit Pictolog';

  @override
  String get save => 'Save';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get done => 'Done';

  @override
  String get close => 'Close';

  @override
  String get back => 'Back';

  @override
  String get moreActions => 'More actions';

  @override
  String createdOn(String date) {
    return 'Created $date';
  }

  @override
  String editedOn(String date) {
    return 'Edited $date';
  }

  @override
  String get pages => 'Pages';

  @override
  String get sort => 'Sort';

  @override
  String get noDescription => 'No description';

  @override
  String get page => 'Page';

  @override
  String get createPdf => 'Create PDF';

  @override
  String get noPagesYet => 'No pages yet';

  @override
  String get noPagesHint => 'Add photos as pages with the \"Page\" button.';

  @override
  String get deletePictolog => 'Delete Pictolog';

  @override
  String get deletePictologConfirm =>
      'This pictolog and all its pages will be permanently deleted.';

  @override
  String get changeOrder => 'Change order';

  @override
  String get reorderHint =>
      'Drag a page by its handle to the desired position.';

  @override
  String pageOf(int current, int total) {
    return 'Page $current of $total';
  }

  @override
  String get editPage => 'Edit page';

  @override
  String get replace => 'Replace';

  @override
  String get rotateImage => 'Rotate image';

  @override
  String get deletePage => 'Delete page';

  @override
  String get deletePageConfirm => 'This page will be permanently deleted.';

  @override
  String get addPage => 'Add page';

  @override
  String get whereFromImage => 'Where does the image come from?';

  @override
  String get camera => 'Camera';

  @override
  String get takeNewPhoto => 'Take a new photo';

  @override
  String get gallery => 'Gallery';

  @override
  String get chooseExistingImage => 'Choose an existing image';

  @override
  String pageNumber(int number) {
    return 'Page $number';
  }

  @override
  String get tapShutter => 'Tap the shutter';

  @override
  String get takePicture => 'Take picture';

  @override
  String get closeCamera => 'Close camera';

  @override
  String get noCameraFound => 'No camera found';

  @override
  String errorTakingPicture(String error) {
    return 'Error taking picture: $error';
  }

  @override
  String errorAddingPage(String error) {
    return 'Error adding page: $error';
  }

  @override
  String errorSaving(String error) {
    return 'Error saving: $error';
  }

  @override
  String get pageNotFound => 'Page not found!';

  @override
  String get pdfPreview => 'PDF preview';

  @override
  String get share => 'Share';

  @override
  String get savePdf => 'Save PDF';

  @override
  String get photoDocumentation => 'Photo documentation';

  @override
  String get created => 'Created';

  @override
  String get edited => 'Edited';

  @override
  String get appearance => 'Appearance';

  @override
  String get general => 'General';

  @override
  String get theme => 'Theme';

  @override
  String get language => 'Language';

  @override
  String get selectLanguage => 'Select language';

  @override
  String get lightMode => 'Light';

  @override
  String get darkMode => 'Dark';

  @override
  String get systemMode => 'System';
}
