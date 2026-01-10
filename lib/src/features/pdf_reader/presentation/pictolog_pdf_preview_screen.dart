import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pdf_document;
import 'package:printing/printing.dart';
import 'package:pictolog/src/features/crud_pictolog/model/pictolog.dart';

class PictologPdfPreviewScreen extends StatelessWidget {
  static const String path = 'pdf_preview';
  static const String name = 'pictolog_pdf_preview';

  final Pictolog pictolog;

  const PictologPdfPreviewScreen({super.key, required this.pictolog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PDF Preview')),
      body: Center(
        child: PdfPreview(
          build: (format) => _generatePdf(format, pictolog),
          canDebug: false,
        ),
      ),
    );
  }

  Future<Uint8List> _generatePdf(
    PdfPageFormat format,
    Pictolog pictolog,
  ) async {
    final pdf = pdf_document.Document();

    final reportWidgets = await Future.wait(
      pictolog.reports.map((report) async {
        final file = File(report.imagePath);
        if (!await file.exists()) return null;

        final bytes = await file.readAsBytes();
        final image = pdf_document.MemoryImage(bytes);

        return pdf_document.Center(
          child: pdf_document.Container(
            width: 400,
            margin: const pdf_document.EdgeInsets.only(bottom: 30),
            child: pdf_document.Column(
              crossAxisAlignment: pdf_document.CrossAxisAlignment.center,
              children: [
                pdf_document.AspectRatio(
                  aspectRatio: 3 / 4,
                  child: pdf_document.Image(
                    image,
                    fit: pdf_document.BoxFit.cover,
                  ),
                ),
                pdf_document.SizedBox(height: 10),
                pdf_document.Text(
                  report.description,
                  style: const pdf_document.TextStyle(fontSize: 12),
                  textAlign: pdf_document.TextAlign.start,
                ),
              ],
            ),
          ),
        );
      }),
    );

    final validReports = reportWidgets
        .whereType<pdf_document.Widget>()
        .toList();
    pdf.addPage(
      pdf_document.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return pdf_document.Center(
            child: pdf_document.Column(
              mainAxisAlignment: pdf_document.MainAxisAlignment.center,
              children: [
                pdf_document.Text(
                  pictolog.name,
                  style: pdf_document.TextStyle(
                    fontSize: 28,
                    fontWeight: pdf_document.FontWeight.bold,
                  ),
                ),
                pdf_document.SizedBox(height: 20),

                pdf_document.Text(
                  pictolog.createdAt.toString().split(' ')[0],
                  style: const pdf_document.TextStyle(fontSize: 12),
                ),
                pdf_document.SizedBox(height: 100),
                pdf_document.Text(
                  pictolog.overviewDescription,
                  style: const pdf_document.TextStyle(fontSize: 12),
                ),
              ],
            ),
          );
        },
      ),
    );
    if (validReports.isNotEmpty) {
      pdf.addPage(
        pdf_document.MultiPage(
          pageFormat: PdfPageFormat.a4,
          crossAxisAlignment: pdf_document.CrossAxisAlignment.center,
          header: (pdf_document.Context context) {
            return pdf_document.Column(
              crossAxisAlignment: pdf_document.CrossAxisAlignment.start,
              children: [
                pdf_document.Text(
                  pictolog.name,
                  style: pdf_document.TextStyle(
                    fontSize: 24,
                    fontWeight: pdf_document.FontWeight.bold,
                  ),
                ),

                pdf_document.SizedBox(height: 5),
                pdf_document.Text(
                  'Created: ${pictolog.createdAt.toString().split(' ')[0]}',
                  style: const pdf_document.TextStyle(
                    fontSize: 10,
                    color: PdfColors.grey,
                  ),
                ),
                pdf_document.Divider(),
              ],
            );
          },
          footer: (pdf_document.Context context) {
            return pdf_document.Container(
              alignment: pdf_document.Alignment.centerRight,
              padding: const pdf_document.EdgeInsets.only(top: 10),
              child: pdf_document.Text(
                'Page ${context.pageNumber} of ${context.pagesCount}',
                style: const pdf_document.TextStyle(
                  fontSize: 10,
                  color: PdfColors.grey,
                ),
              ),
            );
          },
          build: (pdf_document.Context context) {
            return [
              pdf_document.SizedBox(height: 10),
              pdf_document.Column(children: validReports),
            ];
          },
        ),
      );
    }

    return pdf.save();
  }
}
