import 'package:flutter/material.dart';

import '../../../../l10n/localization_extension.dart';
import '../../../constants/app_color.dart';
import '../../../constants/app_style.dart';
import '../../bottom_navigation/config/navigation_config.dart';

class NoPictologsMessage extends StatelessWidget {
  const NoPictologsMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.note_alt_outlined,
            size: 64,
            color: Colors.grey,
          ),
          Space.h16,
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: context.appLanguage.noPictologsMessage,
                ),
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Icon(
                    NavigationConfig.fabIcon,
                    size: 20,
                    color: context.colors.primary,
                  ),
                ),
                TextSpan(
                  text: context.appLanguage.button,
                ),
              ],
            ),
            textAlign: TextAlign.center,
            style:
                Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(
                  color: Colors.grey,
                ),
          ),
        ],
      ),
    );
  }
}
