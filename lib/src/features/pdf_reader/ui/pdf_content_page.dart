import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../crud_pictolog/model/pictolog.dart';

class PdfHeaderPage extends pw.StatelessWidget {
  PdfHeaderPage({required this.pictolog});
  final Pictolog pictolog;

  @override
  pw.Widget build(pw.Context context) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          pictolog.name,
          style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
        ),
        pw.SizedBox(height: 5),
        pw.Text(
          'Created: ${pictolog.createdAt.toString().split(' ')[0]}',
          style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey),
        ),
        pw.Divider(),
      ],
    );
  }
}
