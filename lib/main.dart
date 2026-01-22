import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pictolog/src/features/crud_pictolog/model/pictolog.dart';
import 'package:pictolog/src/features/crud_pictolog/model/report.dart';
import 'package:pictolog/src/pictolog_app.dart';

void main() async {
  await Hive.initFlutter();

  // Register adapters
  Hive.registerAdapter(ReportAdapter());
  Hive.registerAdapter(PictologAdapter());

  // Open the box
  await Hive.openBox<Pictolog>('pictologs');
  await Hive.openBox<Report>('reports');
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
