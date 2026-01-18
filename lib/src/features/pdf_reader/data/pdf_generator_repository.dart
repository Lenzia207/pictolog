import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pictolog/src/features/crud_pictolog/model/pictolog.dart';
import 'package:pictolog/src/features/pdf_reader/ui/pdf_footer.dart';
import 'package:pictolog/src/features/pdf_reader/ui/pdf_image_description_section.dart';
import '../ui/pdf_content_page.dart';
import '../ui/pdf_title_page.dart';

final pdfGeneratorRepositoryProvider = Provider<PdfGeneratorRepository>((ref) {
  return PdfGeneratorRepository();
});

class PdfGeneratorRepository {
  Future<Uint8List> generatePdf(
    PdfPageFormat format,
    Pictolog pictolog,
  ) async {
    final pdf = pw.Document();

    // Generate report widgets
    final reportWidgets = await Future.wait(
      pictolog.reports.map(
        (report) async {
          final file = File(report.imagePath);
          if (!await file.exists()) return null;

          final bytes = await file.readAsBytes();
          final image = pw.MemoryImage(bytes);

          return PdfImageDescriptionSection(
            pictolog: pictolog,
            image: image,
            reportDescription: report.description ?? '',
          );
        },
      ),
    );

    // Filter out any null widgets (in case some images were missing)
    final validReports = reportWidgets.whereType<pw.Widget>().toList();

    // Add Title Page
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) => PdfTitlePage(
          pictolog: pictolog,
        ),
      ),
    );

    // Add Content Pages if there are valid reports
    if (validReports.isNotEmpty) {
      pdf.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          crossAxisAlignment: pw.CrossAxisAlignment.center,
          header: (pw.Context context) => PdfHeaderPage(
            pictolog: pictolog,
          ),
          footer: (pw.Context context) => PdfFooter(
            pictolog: pictolog,
          ),
          build: (pw.Context context) {
            return [
              pw.SizedBox(
                height: 10,
              ),
              ...validReports,
            ];
          },
        ),
      );
    }

    return pdf.save();
  }
}
