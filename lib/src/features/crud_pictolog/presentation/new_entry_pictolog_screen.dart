import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pictolog/src/features/crud_pictolog/presentation/ui/new_entry_pictolog_ui.dart';

import '../../../../l10n/localization_extension.dart';
import '../data/pictolog_repository.dart';
import '../model/pictolog.dart';
import '../model/report.dart';

class NewEntryPictologScreen extends HookConsumerWidget {
  const NewEntryPictologScreen({
    super.key,
  });

  static const String path = 'new_entry';
  static const String name = 'NewEntryPictolog';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Repository
    final repository = ref.watch(pictologRepositoryProvider);

    // Form State
    final nameController = useTextEditingController();
    final overviewController = useTextEditingController();
    final isLoading = useState(false);

    Future<void> savePictolog() async {
      if (nameController.text.isEmpty) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(
          SnackBar(
            content: Text(
              context.appLanguage.projectName,
            ),
          ),
        );
        return;
      }

      isLoading.value = true;

      try {
        final List<Report> reports = [];

        final newPictolog = Pictolog(
          name: nameController.text,
          overviewDescription: overviewController.text,
          reports: reports,
          createdAt: DateTime.now(),
        );

        await repository.addPictolog(newPictolog);

        if (context.mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(
            SnackBar(
              content: Text(context.appLanguage.newPictologCreated),
            ),
          );
          context.pop();
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(
            SnackBar(
              content: Text(context.appLanguage.errorSaving(e.toString())),
            ),
          );
        }
      } finally {
        isLoading.value = false;
      }
    }

    return NewEntryPictologUi(
      icon: isLoading.value
          ? const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              ),
            )
          : const Icon(Icons.check),
      nameController: nameController,
      overviewController: overviewController,
      savePictolog: isLoading.value ? () {} : savePictolog,
    );
  }
}
