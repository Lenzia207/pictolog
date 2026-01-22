import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';

class NavigationItem {
  final IconData icon;
  final String Function(BuildContext) labelBuilder;
  final int index;

  const NavigationItem({
    required this.icon,
    required this.labelBuilder,
    required this.index,
  });

  String getLabel(BuildContext context) => labelBuilder(context);
}

class NavigationConfig {
  static List<NavigationItem> items(BuildContext context) {
    return [
      NavigationItem(
        icon: Icons.home,
        labelBuilder: (context) => AppLocalizations.of(context)!.myPictologs,
        index: 0,
      ),
      NavigationItem(
        icon: Icons.settings,
        labelBuilder: (context) => AppLocalizations.of(context)!.settings,
        index: 1,
      ),
    ];
  }

  static const int fabIndex = 2;
  static const IconData fabIcon = Icons.note_add_outlined;
}
