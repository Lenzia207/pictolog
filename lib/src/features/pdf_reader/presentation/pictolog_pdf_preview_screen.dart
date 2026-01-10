import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:printing/printing.dart';
import 'package:pictolog/src/features/crud_pictolog/model/pictolog.dart';
import 'package:pictolog/src/features/pdf_reader/data/pdf_generator_repository.dart';

class PictologPdfPreviewScreen extends ConsumerWidget {
  static const String path = 'pdf_preview';
  static const String name = 'pictolog_pdf_preview';

  final Pictolog pictolog;

  const PictologPdfPreviewScreen({
    super.key,
    required this.pictolog,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'PDF Preview',
        ),
      ),
      body: Center(
        child: PdfPreview(
          build: (format) => ref
              .read(pdfGeneratorRepositoryProvider)
              .generatePdf(
                format,
                pictolog,
              ),
          canDebug: false,
        ),
      ),
    );
  }
}
