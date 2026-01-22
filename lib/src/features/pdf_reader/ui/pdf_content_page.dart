import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pictolog/src/widgets/app_date_format.dart';

import '../../crud_pictolog/model/pictolog.dart';

class PdfContentPage extends pw.StatelessWidget {
  PdfContentPage({
    required this.pictolog,
  });
  final Pictolog pictolog;

  @override
  pw.Widget build(pw.Context context) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          pictolog.name,
          style: pw.TextStyle(
            fontSize: 24,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
        pw.SizedBox(
          height: 5,
        ),
        pw.Text(
          'Erstellt: ${pictolog.createdAt.toFormatDMY}',
          style: const pw.TextStyle(
            fontSize: 10,
            color: PdfColors.grey,
          ),
        ),
        pw.Divider(),
      ],
    );
  }
}
