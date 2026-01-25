import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../projects/domain/project_model.dart';

class PdfFooter extends pw.StatelessWidget {
  PdfFooter({
    required this.pictolog,
  });

  final ProjectModel pictolog;

  @override
  pw.Widget build(pw.Context context) {
    return pw.Container(
      alignment: pw.Alignment.centerRight,
      padding: pw.EdgeInsets.only(
        top: 10,
      ),
      child: pw.Text(
        'Page ${context.pageNumber} of ${context.pagesCount}',
        style: pw.TextStyle(
          fontSize: 10,
          color: PdfColors.grey,
        ),
      ),
    );
  }
}
