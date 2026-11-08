import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pictolog/src/features/projects/domain/project_model.dart';
import 'package:pictolog/src/widgets/app_date_format.dart';

import '../../../theme/theme.dart';
import '../domain/pdf_service.dart';

/// Cover page: overline, accent bar, title, description and a meta row.
class PdfTitlePage extends pw.StatelessWidget {
  PdfTitlePage({
    required this.pictolog,
    required this.labels,
  });

  final ProjectModel pictolog;
  final PdfLabels labels;

  static final _secondary = PdfColor.fromInt(
    AppColor.textSecondaryLight.toARGB32(),
  );

  @override
  pw.Widget build(pw.Context context) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          labels.photoDocumentation.toUpperCase(),
          style: pw.TextStyle(
            fontSize: 11,
            fontWeight: pw.FontWeight.bold,
            letterSpacing: 1.5,
            color: _secondary,
          ),
        ),
        pw.SizedBox(height: 120),
        pw.Container(
          width: 56,
          height: 8,
          color: PdfColor.fromInt(AppColor.accentGreen.toARGB32()),
        ),
        pw.SizedBox(height: 24),
        pw.Text(
          pictolog.name,
          style: pw.TextStyle(
            fontSize: 40,
            fontWeight: pw.FontWeight.bold,
            lineSpacing: 4,
          ),
        ),
        if (pictolog.overviewDescription.isNotEmpty) ...[
          pw.SizedBox(height: 20),
          pw.Text(
            pictolog.overviewDescription,
            style: pw.TextStyle(
              fontSize: 16,
              lineSpacing: 6,
              color: PdfColor.fromInt(AppColor.textBodyLight.toARGB32()),
            ),
          ),
        ],
        pw.Spacer(),
        pw.Container(
          padding: const pw.EdgeInsets.only(top: 20),
          decoration: const pw.BoxDecoration(
            border: pw.Border(top: pw.BorderSide(width: 1)),
          ),
          child: pw.Row(
            children: [
              _meta(labels.created, pictolog.createdAt.toFormatDMY),
              _meta(labels.edited, pictolog.updatedAt?.toFormatDMY ?? '–'),
              _meta(labels.pages, '${pictolog.reports.length}'),
            ],
          ),
        ),
      ],
    );
  }

  pw.Widget _meta(String label, String value) {
    return pw.Expanded(
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            label.toUpperCase(),
            style: pw.TextStyle(
              fontSize: 9,
              letterSpacing: 1,
              color: _secondary,
            ),
          ),
          pw.SizedBox(height: 4),
          pw.Text(
            value,
            style: pw.TextStyle(
              fontSize: 14,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
