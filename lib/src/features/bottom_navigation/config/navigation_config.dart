import 'package:flutter/material.dart';

import '../../../../l10n/localization_extension.dart';

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
        labelBuilder: (context) => context.appLanguage.myPictologs,
        index: 0,
      ),
      NavigationItem(
        icon: Icons.settings,
        labelBuilder: (context) => context.appLanguage.settings,
        index: 1,
      ),
    ];
  }

  static const int fabIndex = 2;
  static const IconData fabIcon = Icons.note_add_outlined;
}
