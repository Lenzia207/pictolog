import 'package:flutter/material.dart';

import '../../../../constants/app_color.dart';

/// Settings section widget for grouping related settings
class SettingsSection extends StatelessWidget {
  const SettingsSection({
    super.key,
    required this.children,
  });

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.zero,
      color: context.colors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: children,
      ),
    );
  }
}
