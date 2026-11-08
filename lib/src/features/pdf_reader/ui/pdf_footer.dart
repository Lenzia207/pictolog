import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfFooter extends pw.StatelessWidget {
  PdfFooter({
    required this.pageOf,
  });

  final String Function(int current, int total) pageOf;

  @override
  pw.Widget build(pw.Context context) {
    return pw.Container(
      alignment: pw.Alignment.centerRight,
      padding: pw.EdgeInsets.only(
        top: 10,
      ),
      child: pw.Text(
        pageOf(context.pageNumber, context.pagesCount),
        style: pw.TextStyle(
          fontSize: 10,
          color: PdfColors.grey,
        ),
      ),
    );
  }
}
