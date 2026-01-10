import 'package:pdf/widgets.dart' as pw;
import 'package:pictolog/src/features/crud_pictolog/model/pictolog.dart';

class PdfImageDescriptionSection extends pw.StatelessWidget {
  PdfImageDescriptionSection({
    required this.pictolog,
    required this.image,
    required this.reportDescription,
  });

  final Pictolog pictolog;
  final pw.MemoryImage image;
  final String reportDescription;

  @override
  pw.Widget build(pw.Context context) {
    return pw.Container(
      width: 400,
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.center,
        children: [
          pw.AspectRatio(
            aspectRatio: 3 / 4,
            child: pw.Image(
              image,
              fit: pw.BoxFit.cover,
            ),
          ),
          pw.SizedBox(
            height: 10,
          ),
          pw.Text(
            reportDescription,
            style: const pw.TextStyle(
              fontSize: 12,
            ),
            textAlign: pw.TextAlign.start,
          ),
        ],
      ),
    );
  }
}
