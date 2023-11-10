
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class Printer {
  static Future<void> printDoc(String Name, String Date, String bill_total,
      List<Map<String, Object?>>? elements) async {
    final doc = pw.Document();
    doc.addPage(pw.Page(
        pageFormat: PdfPageFormat.a6,
        build: (pw.Context context) {
          return pw.Container(
              child: pw.Column(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  children: [
                pw.Row(children: [
                  pw.Expanded(
                      child: pw.Text(
                    "Owner : " + Name,
                    textAlign: pw.TextAlign.center,
                  )),
                  pw.Expanded(
                      child: pw.Text("Date :" + Date,
                          textAlign: pw.TextAlign.center))
                ]),
                pw.Expanded(
                    child: pw.ListView.builder(
                  itemCount: elements!.length,
                  itemBuilder: (context,index){
                    Map f=elements[index];
                    return pw.Row(
                      children: [
                        pw.Expanded(child: pw.Text(f["Product_Name"],textAlign: pw.TextAlign.center)),
                        pw.Expanded(child: pw.Text(f["Element_amount"].toString(),textAlign: pw.TextAlign.center)),
                        pw.Expanded(child: pw.Text(f["Bill_Element_Price"].toString(),textAlign: pw.TextAlign.center)),

                      ]
                    );
                  },
                )),
                    pw.Expanded(child: pw.Text( "Total : "+bill_total,style: pw.TextStyle(fontSize: 18),textAlign: pw.TextAlign.center,)),
                  ]));
        }));
    await Printing.layoutPdf(
      format: PdfPageFormat.a6,
        onLayout: (PdfPageFormat format) async => doc.save());
  }
}
