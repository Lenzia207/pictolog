import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pdf/pdf.dart';
import 'package:pictolog/l10n/localization_extension.dart';
import 'package:printing/printing.dart';
import 'package:pictolog/src/features/projects/domain/project_model.dart';
import 'package:pictolog/src/features/pdf_reader/domain/pdf_service.dart';

import '../../../constants/constants.dart';
import '../../../theme/theme.dart';
import '../../../widgets/bottom_action_bar.dart';
import '../../../widgets/circle_icon_button.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/screen_header.dart';
import '../../projects/presentation/widgets/pictolog_builder.dart';

class PictologPdfPreviewScreen extends StatelessWidget {
  static const String path = 'pdf_preview';
  static const String name = 'pictolog_pdf_preview';

  final int pictologKey;

  const PictologPdfPreviewScreen({
    super.key,
    required this.pictologKey,
  });

  @override
  Widget build(BuildContext context) {
    return PictologBuilder(
      pictologKey: pictologKey,
      builder: (context, pictolog) => _PdfPreview(pictolog: pictolog),
    );
  }
}

class _PdfPreview extends HookConsumerWidget {
  const _PdfPreview({required this.pictolog});

  final ProjectModel pictolog;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;
    final appLanguage = context.appLanguage;
    final fileName = '${pictolog.name}.pdf';
    final labels = PdfLabels(
      photoDocumentation: appLanguage.photoDocumentation,
      created: appLanguage.created,
      edited: appLanguage.edited,
      pages: appLanguage.pages,
      pageOf: appLanguage.pageOf,
    );

    // Generate the document once and reuse it for preview, share and save.
    final pdfBytes = useMemoized(
      () => ref.read(pdfGeneratorRepositoryProvider).generatePdf(
        pictolog,
        labels,
      ),
      [pictolog, appLanguage],
    );
    Future<Uint8List> buildPdf(PdfPageFormat _) => pdfBytes;

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            ScreenHeader(
              leading: CircleIconButton(
                icon: Icons.chevron_left,
                iconSize: 26,
                tooltip: appLanguage.back,
                onPressed: () => context.pop(),
              ),
              title: appLanguage.pdfPreview,
              // Cover page plus one page per photo.
              subtitle:
                  '${appLanguage.pagesCount(pictolog.reports.length + 1)} · A4',
            ),
            Space.h8,
            Expanded(
              child: PdfPreview(
                build: buildPdf,
                pdfFileName: fileName,
                useActions: false,
                canChangeOrientation: false,
                canChangePageFormat: false,
                canDebug: false,
                maxPageWidth: 320,
                scrollViewDecoration: BoxDecoration(color: colors.background),
                pdfPreviewPageDecoration: BoxDecoration(
                  color: AppColor.white,
                  boxShadow: [
                    BoxShadow(
                      color: AppColor.black.withValues(alpha: 0.10),
                      blurRadius: 32,
                      offset: const Offset(0, 12),
                    ),
                  ],
                ),
                loadingWidget: CircularProgressIndicator(
                  color: colors.primary,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomActionBar(
        child: Row(
          children: [
            Expanded(
              flex: 10,
              child: PrimaryButton(
                label: appLanguage.share,
                icon: Icons.ios_share,
                variant: PrimaryButtonVariant.secondary,
                onPressed: () async => Printing.sharePdf(
                  bytes: await pdfBytes,
                  filename: fileName,
                ),
              ),
            ),
            Space.w10,
            Expanded(
              flex: 14,
              child: PrimaryButton(
                label: appLanguage.savePdf,
                icon: Icons.download,
                onPressed: () => Printing.layoutPdf(
                  onLayout: buildPdf,
                  name: fileName,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
