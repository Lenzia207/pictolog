import 'package:pdf/widgets.dart' as pw;
import 'package:pictolog/src/features/crud_pictolog/model/pictolog.dart';
import 'package:pictolog/src/widgets/app_date_format.dart';

class PdfTitlePage extends pw.StatelessWidget {
  PdfTitlePage({required this.pictolog});
  final Pictolog pictolog;

  @override
  pw.Widget build(pw.Context context) {
    return pw.Center(
      child: pw.Column(
        mainAxisAlignment: pw.MainAxisAlignment.center,
        children: [
          pw.Text(
            pictolog.name,
            style: pw.TextStyle(
              fontSize: 28,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.SizedBox(height: 20),
          pw.Text(
            pictolog.createdAt.toFormatDMY,
            style: const pw.TextStyle(
              fontSize: 12,
            ),
          ),
          pw.SizedBox(
            height: 100,
          ),
          pw.Text(
            pictolog.overviewDescription,
            style: const pw.TextStyle(
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
