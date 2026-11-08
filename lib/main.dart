import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pictolog/src/features/projects/domain/project_model.dart';
import 'package:pictolog/src/features/reports/domain/report_model.dart';
import 'package:pictolog/src/pictolog_app.dart';

void main() async {
  // The bundled Istok Web font is licensed under the SIL Open Font License.
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('assets/fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['IstokWeb'], license);
  });

  await Hive.initFlutter();

  // Register adapters
  Hive.registerAdapter(ReportModelAdapter());
  Hive.registerAdapter(ProjectModelAdapter());

  // Open the box
  await Hive.openBox<ProjectModel>('pictologs');
  runApp(
    const MainApp(),
  );
}

class MainApp extends HookWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProviderScope(
      child: PictologApp(),
    );
  }
}
