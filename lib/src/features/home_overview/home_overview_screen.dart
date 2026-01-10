import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// The Overview screen for the home feature.
/// Shows List of created pictologs.
class HomeOverviewScreen extends HookWidget {
  const HomeOverviewScreen({super.key});
  static const String path = "/";
  static const String name = "home_overview";

  // final List<String> pictologs;

  @override
  Widget build(BuildContext context) {
    final List<String> pictologs = ["Pictolog 1", "Pictolog 2", "Pictolog 3"];
    if (pictologs.isEmpty) {
      return const Center(child: Text('No pictologs yet. Create one!'));
    }
    return ListView.builder(
      itemCount: pictologs.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: const Icon(Icons.image),
          title: Text(pictologs[index]),
        );
      },
    );
  }
}
