import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pictolog/l10n/localization_extension.dart';
import 'package:printing/printing.dart';
import 'package:pictolog/src/features/projects/domain/project_model.dart';
import 'package:pictolog/src/features/pdf_reader/domain/pdf_service.dart';

import '../../../constants/constants.dart';
import '../../../theme/theme.dart';

class PictologPdfPreviewScreen extends ConsumerWidget {
  static const String path = 'pdf_preview';
  static const String name = 'pictolog_pdf_preview';

  final ProjectModel pictolog;

  const PictologPdfPreviewScreen({
    super.key,
    required this.pictolog,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.colors.surface.withAlpha(0),
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 2,
        centerTitle: true,
        title: Text(
          context.appLanguage.pdfPreview,
          style: AppTextStyle.headlineLarge,
        ),
      ),
      body: Center(
        child: PdfPreview(
          dpi: 300,
          actionBarTheme: PdfActionBarTheme(
            backgroundColor: context.colors.primary,
            iconColor: context.colors.surface,
            textStyle: AppTextStyle.bodyMedium,
          ),
          build: (format) => ref
              .read(pdfGeneratorRepositoryProvider)
              .generatePdf(
                format,
                pictolog,
                context.appLanguage.created,
              ),
          canDebug: false,
        ),
      ),
    );
  }
}
