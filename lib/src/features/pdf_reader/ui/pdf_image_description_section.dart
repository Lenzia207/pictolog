import 'package:pdf/widgets.dart' as pw;
import 'package:pictolog/src/features/crud_pictolog/model/pictolog.dart';

import '../../../constants/constants.dart';

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
          pw.Container(
            height: 500,
            child: pw.Image(
              image,
              fit: pw.BoxFit.contain,
            ),
          ),
          pw.SizedBox(
            height: p10,
          ),
          pw.Text(
            reportDescription,
            style: const pw.TextStyle(
              fontSize: p12,
            ),
            textAlign: pw.TextAlign.start,
          ),
        ],
      ),
    );
  }
}
