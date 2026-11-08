import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pictolog/src/features/projects/presentation/ui/new_entry_pictolog_ui.dart';

import '../../../../l10n/localization_extension.dart';
import 'controllers/project_controller.dart';
import '../domain/project_model.dart';
import 'project_detail_screen.dart';

/// Creates a new Pictolog, or edits title and description of an existing
/// one when [pictologKey] is given.
class NewEntryPictologScreen extends HookConsumerWidget {
  const NewEntryPictologScreen({
    super.key,
    this.pictologKey,
  });

  static const String path = 'new_entry';
  static const String name = 'NewEntryPictolog';
  static const String editPath = 'edit';
  static const String editName = 'EditPictolog';

  final int? pictologKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Repository
    final repository = ref.watch(projectRepositoryProvider);
    final pictolog = pictologKey == null
        ? null
        : repository.box.get(pictologKey);

    // Form State
    final nameController = useTextEditingController(text: pictolog?.name);
    final overviewController = useTextEditingController(
      text: pictolog?.overviewDescription,
    );
    final isLoading = useState(false);
    final showTitleError = useState(false);

    Future<void> savePictolog() async {
      final name = nameController.text.trim();
      if (name.isEmpty) {
        showTitleError.value = true;
        return;
      }

      isLoading.value = true;

      try {
        if (pictolog != null) {
          await repository.updatePictolog(
            pictolog,
            name: name,
            overviewDescription: overviewController.text.trim(),
          );
          if (context.mounted) context.pop();
          return;
        }

        final key = await repository.addPictolog(
          ProjectModel(
            name: name,
            overviewDescription: overviewController.text.trim(),
            reports: [],
            createdAt: DateTime.now(),
          ),
        );

        if (context.mounted) {
          context.goNamed(
            PictologDetailsScreen.name,
            pathParameters: {
              PictologDetailsScreen.paramId: key.toString(),
            },
          );
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(context.appLanguage.errorSaving(e.toString())),
            ),
          );
        }
      } finally {
        if (context.mounted) isLoading.value = false;
      }
    }

    return NewEntryPictologUi(
      isEditing: pictolog != null,
      isLoading: isLoading.value,
      nameController: nameController,
      overviewController: overviewController,
      titleError: showTitleError.value
          ? context.appLanguage.titleRequired
          : null,
      onNameChanged: (_) => showTitleError.value = false,
      savePictolog: savePictolog,
    );
  }
}
