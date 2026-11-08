// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get projects => 'Projekte';

  @override
  String get pictologs => 'Pictologs';

  @override
  String get settings => 'Einstellungen';

  @override
  String projectsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Projekte',
      one: '1 Projekt',
    );
    return '$_temp0';
  }

  @override
  String pagesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Seiten',
      one: '1 Seite',
    );
    return '$_temp0';
  }

  @override
  String get noProjectsYet => 'Noch keine Projekte';

  @override
  String get searchPictologs => 'Pictologs durchsuchen';

  @override
  String get noSearchResults => 'Keine Pictologs gefunden';

  @override
  String get recentlyEdited => 'Zuletzt bearbeitet';

  @override
  String get newestFirst => 'Neueste zuerst';

  @override
  String get oldestFirst => 'Älteste zuerst';

  @override
  String get newPictolog => 'Neuer Pictolog';

  @override
  String get selectPictologs => 'Pictologs auswählen';

  @override
  String get emptyTitle => 'Starte deinen ersten Pictolog';

  @override
  String get emptyMessage =>
      'Fotografiere, beschreibe und ordne Seiten – Pictolog macht daraus ein sauberes PDF.';

  @override
  String get createPictolog => 'Pictolog erstellen';

  @override
  String get emptyStepCreate => 'Projekt anlegen und benennen';

  @override
  String get emptyStepPhotos => 'Fotos als Seiten hinzufügen';

  @override
  String get emptyStepPdf => 'PDF erstellen und teilen';

  @override
  String selectedItems(int count) {
    return '$count ausgewählt';
  }

  @override
  String get selectAll => 'Alle';

  @override
  String get endSelection => 'Auswahl beenden';

  @override
  String pagesWillBeDeleted(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Seiten werden endgültig gelöscht.',
      one: '1 Seite wird endgültig gelöscht.',
    );
    return '$_temp0';
  }

  @override
  String deletePictologs(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Pictologs löschen',
      one: '1 Pictolog löschen',
    );
    return '$_temp0';
  }

  @override
  String get whatsItAbout => 'Worum geht\'s?';

  @override
  String get newPictologHint =>
      'Titel und Beschreibung erscheinen auf der Titelseite deines PDFs.';

  @override
  String get title => 'Titel';

  @override
  String get projectName => 'Name des Projekts';

  @override
  String get titleRequired => 'Bitte gib einen Titel ein.';

  @override
  String get description => 'Beschreibung';

  @override
  String get optional => 'Optional';

  @override
  String get generalProjectDescription =>
      'Allgemeine Beschreibung des Projekts …';

  @override
  String get newPictologTip =>
      'Nach dem Speichern fügst du direkt die ersten Fotos als Seiten hinzu.';

  @override
  String get editPictolog => 'Pictolog bearbeiten';

  @override
  String get save => 'Speichern';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get delete => 'Löschen';

  @override
  String get done => 'Fertig';

  @override
  String get close => 'Schließen';

  @override
  String get back => 'Zurück';

  @override
  String get moreActions => 'Weitere Aktionen';

  @override
  String createdOn(String date) {
    return 'Erstellt $date';
  }

  @override
  String editedOn(String date) {
    return 'Bearbeitet $date';
  }

  @override
  String get pages => 'Seiten';

  @override
  String get sort => 'Sortieren';

  @override
  String get noDescription => 'Keine Beschreibung';

  @override
  String get page => 'Seite';

  @override
  String get createPdf => 'PDF erstellen';

  @override
  String get noPagesYet => 'Noch keine Seiten';

  @override
  String get noPagesHint => 'Füge Fotos über „Seite“ als Seiten hinzu.';

  @override
  String get deletePictolog => 'Pictolog löschen';

  @override
  String get deletePictologConfirm =>
      'Dieser Pictolog und alle Seiten werden endgültig gelöscht.';

  @override
  String get changeOrder => 'Reihenfolge ändern';

  @override
  String get reorderHint =>
      'Ziehe eine Seite am Griff an die gewünschte Position.';

  @override
  String pageOf(int current, int total) {
    return 'Seite $current von $total';
  }

  @override
  String get editPage => 'Seite bearbeiten';

  @override
  String get replace => 'Ersetzen';

  @override
  String get rotateImage => 'Bild drehen';

  @override
  String get deletePage => 'Seite löschen';

  @override
  String get deletePageConfirm => 'Diese Seite wird endgültig gelöscht.';

  @override
  String get addPage => 'Seite hinzufügen';

  @override
  String get whereFromImage => 'Woher kommt das Bild?';

  @override
  String get camera => 'Kamera';

  @override
  String get takeNewPhoto => 'Neues Foto aufnehmen';

  @override
  String get gallery => 'Galerie';

  @override
  String get chooseExistingImage => 'Vorhandenes Bild wählen';

  @override
  String pageNumber(int number) {
    return 'Seite $number';
  }

  @override
  String get tapShutter => 'Tippe auf den Auslöser';

  @override
  String get takePicture => 'Foto aufnehmen';

  @override
  String get closeCamera => 'Kamera schließen';

  @override
  String get noCameraFound => 'Keine Kamera gefunden';

  @override
  String errorTakingPicture(String error) {
    return 'Fehler beim Aufnehmen: $error';
  }

  @override
  String errorAddingPage(String error) {
    return 'Fehler beim Hinzufügen der Seite: $error';
  }

  @override
  String errorSaving(String error) {
    return 'Fehler beim Speichern: $error';
  }

  @override
  String get pageNotFound => 'Seite nicht gefunden!';

  @override
  String get pdfPreview => 'PDF-Vorschau';

  @override
  String get share => 'Teilen';

  @override
  String get savePdf => 'PDF speichern';

  @override
  String get photoDocumentation => 'Fotodokumentation';

  @override
  String get created => 'Erstellt';

  @override
  String get edited => 'Bearbeitet';

  @override
  String get appearance => 'Darstellung';

  @override
  String get general => 'Allgemein';

  @override
  String get theme => 'Design';

  @override
  String get language => 'Sprache';

  @override
  String get selectLanguage => 'Sprache auswählen';

  @override
  String get lightMode => 'Hell';

  @override
  String get darkMode => 'Dunkel';

  @override
  String get systemMode => 'System';
}
