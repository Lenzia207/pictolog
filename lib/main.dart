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
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProviderScope(
        child: PictologApp(),
      ),
    );
  }
}

// class HomePage extends HookWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Pictolog Overview')),
//       body: const Center(child: Text('Hello World!')),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.of(
//             context,
//           ).push(MaterialPageRoute(builder: (context) => const CameraScreen()));
//         },
//         child: const Icon(Icons.camera_alt),
//       ),
//     );
//   }
// }
