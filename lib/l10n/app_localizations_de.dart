// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Pictolog';

  @override
  String get myPictologs => 'Meine Pictologs';

  @override
  String get noPictologsMessage =>
      'Noch keine Pictologs.\nErstelle einen mit dem ';

  @override
  String get settings => 'Einstellungen';

  @override
  String get accountSettings => 'Einstellungen';

  @override
  String get language => 'Sprache';

  @override
  String get selectLanguage => 'Sprache auswählen';

  @override
  String get newPictologEntry => 'Neuer Pictolog Eintrag';

  @override
  String get title => 'Titel';

  @override
  String get projectName => 'Name des Projekts';

  @override
  String get description => 'Beschreibung';

  @override
  String get descriptionOptional => 'Beschreibung (Optional)';

  @override
  String get generalProjectDescription =>
      'Allgemeine Beschreibung des Projekts...';

  @override
  String get saveEntry => 'Eintrag speichern';

  @override
  String get pages => 'Seiten';

  @override
  String pagesCount(String count) {
    return '$count Seiten';
  }

  @override
  String get takePicture => 'Foto aufnehmen';

  @override
  String get noCameraFound => 'Keine Kamera gefunden';

  @override
  String pictureTaken(String path) {
    return 'Foto aufgenommen: $path';
  }

  @override
  String get addDescription => 'Beschreibung hinzufügen';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get save => 'Speichern';

  @override
  String errorAddingReport(String error) {
    return 'Fehler beim Hinzufügen des Berichts: $error';
  }

  @override
  String get newPictologCreated => 'Neuer Pictolog erstellt!';

  @override
  String errorSaving(String error) {
    return 'Fehler beim Speichern: $error';
  }

  @override
  String get createPdf => 'PDF Erstellen';

  @override
  String get changeOrder => 'Reihenfolge ändern';

  @override
  String get addReport => 'Bericht hinzufügen';

  @override
  String get noReportsYet => 'Noch keine Berichte';

  @override
  String get editReport => 'Bericht bearbeiten';

  @override
  String get editEntry => 'Eintrag bearbeiten';

  @override
  String get projectTitle => 'Projekttitel';

  @override
  String get pageNotFound => 'Seite nicht gefunden!';

  @override
  String selectedItems(int count) {
    return '$count Ausgewählt';
  }

  @override
  String get pdfPreview => 'PDF Vorschau';

  @override
  String get report => 'Bericht';

  @override
  String get titlePage => 'Titelseite';

  @override
  String get contentPage => 'Inhaltsseite';

  @override
  String get page => 'Seite';

  @override
  String get button => ' Button!';

  @override
  String get noEntriesYet =>
      'Keine Einträge bis jetzt.\n\nFüge einen neuen Eintrag hinzu unter\n\"Seiten hinzufügen\"';

  @override
  String get created => 'Erstellt';

  @override
  String get edited => 'Bearbeitet';

  @override
  String get overview => 'Übersicht';

  @override
  String get theme => 'Design';

  @override
  String get selectTheme => 'Design auswählen';

  @override
  String get lightMode => 'Hell';

  @override
  String get darkMode => 'Dunkel';

  @override
  String get systemMode => 'System';

  @override
  String get chooseImageSource => 'Bildquelle wählen';

  @override
  String get camera => 'Kamera';

  @override
  String get gallery => 'Galerie';
}
