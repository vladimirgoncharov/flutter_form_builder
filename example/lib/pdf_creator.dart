import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

void generatePDF(BuildContext mainContext, GlobalKey<State> key) async {
  await Printing.layoutPdf(onLayout: (PdfPageFormat format) async {
    final doc = pw.Document();

    final image = await wrapWidget(
      doc.document,
      key: key,
      pixelRatio: 2.0,
    );

    doc.addPage(pw.MultiPage(
        pageFormat: format,
        build: (context) => [
              pw.Center(
                child: pw.Expanded(
                  child: pw.Image(image),
                ),
              )
            ]));

    return doc.save();
  });
}
