import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../l10n/localization_extension.dart';
import '../../../../router/not_found_screen.dart';
import '../../domain/project_model.dart';
import '../controllers/project_controller.dart';

/// Looks up a Pictolog by its key and rebuilds whenever it changes.
class PictologBuilder extends ConsumerWidget {
  const PictologBuilder({
    super.key,
    required this.pictologKey,
    required this.builder,
  });

  final int pictologKey;
  final Widget Function(BuildContext context, ProjectModel pictolog) builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repository = ref.watch(projectRepositoryProvider);

    return ValueListenableBuilder(
      valueListenable: repository.box.listenable(keys: [pictologKey]),
      builder: (context, box, _) {
        final pictolog = box.get(pictologKey);

        if (pictolog == null) {
          return NotFoundScreen(
            errorMessage: context.appLanguage.pageNotFound,
          );
        }
        return builder(context, pictolog);
      },
    );
  }
}
