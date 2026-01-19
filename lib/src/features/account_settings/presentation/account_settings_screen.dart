import 'package:flutter/material.dart';

/// TODO: Implement the Account Settings Screen
/// - Language Selection
/// - Archive Projects
/// - Dark/Light Mode Toggle
class AccountSettingsScreen extends StatelessWidget {
  const AccountSettingsScreen({super.key});

  static const String path = "/account_settings";
  static const String name = "account_settings";

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Account Settings Screen - To be implemented"),
      ),
    );
  }
}
