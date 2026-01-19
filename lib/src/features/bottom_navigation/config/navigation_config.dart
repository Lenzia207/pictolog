import 'package:flutter/material.dart';
import 'navigation_item.dart';

class NavigationConfig {
  static const List<NavigationItem> items = [
    NavigationItem(
      icon: Icons.home,
      label: 'Übersicht',
      index: 0,
    ),
    NavigationItem(
      icon: Icons.settings,
      label: 'Einstellungen',
      index: 1,
    ),
  ];

  static const int fabIndex = 2;
  static const IconData fabIcon = Icons.note_add_outlined;
}
