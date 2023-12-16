import 'dart:developer';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';

class PDFUtils {
  static Future<File> generatepdf(
      {required String id,
      required String Starttime,
      required String name,
      required String order,
      required String Totalorder,
      required String Discount,
      required String orderdDiscounted,
      required String Rcount,
      required String Total,
      required String NetOrder,
      required String tottalcash,
      required String Total_Card,
      required String Total_Companies}) async {
    final pdf = pw.Document();
    final image =
        (await rootBundle.load("assets/img/image005.png")).buffer.asUint8List();
    pdf.addPage(pw.MultiPage(
      build: (context) => <pw.Widget>[
        pw.Image(pw.MemoryImage(image), width: 150),
        pw.Text('Shift iD : $id', style: const pw.TextStyle(fontSize: 25)),
        pw.Text('Start Time : $Starttime', style: const pw.TextStyle(fontSize: 25)),
        pw.Text('Employee Name : $name', style: const pw.TextStyle(fontSize: 25)),
        pw.SizedBox(height: 20),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text('Order', style: const pw.TextStyle(fontSize: 25)),
            pw.Text(order, style: const pw.TextStyle(fontSize: 25)),
          ],
        ),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text('Total Order', style: const pw.TextStyle(fontSize: 25)),
            pw.Text(Totalorder, style: const pw.TextStyle(fontSize: 25)),
          ],
        ),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text('Discount', style: const pw.TextStyle(fontSize: 25)),
            pw.Text(Discount, style: const pw.TextStyle(fontSize: 25)),
          ],
        ),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text('Total order after discount',
                style: const pw.TextStyle(fontSize: 25)),
            pw.Text(orderdDiscounted, style: const pw.TextStyle(fontSize: 25)),
          ],
        ),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text('Return count', style: const pw.TextStyle(fontSize: 25)),
            pw.Text(Rcount, style: const pw.TextStyle(fontSize: 25)),
          ],
        ),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text('Total Return', style: const pw.TextStyle(fontSize: 25)),
            pw.Text(Total, style: const pw.TextStyle(fontSize: 25)),
          ],
        ),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text('Net order', style: const pw.TextStyle(fontSize: 25)),
            pw.Text(NetOrder, style: const pw.TextStyle(fontSize: 25)),
          ],
        ),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text('Total cash', style: const pw.TextStyle(fontSize: 25)),
            pw.Text(tottalcash, style: const pw.TextStyle(fontSize: 25)),
          ],
        ),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text('Total Card', style: const pw.TextStyle(fontSize: 25)),
            pw.Text(Total_Card, style: const pw.TextStyle(fontSize: 25)),
          ],
        ),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text('Total Companies', style: const pw.TextStyle(fontSize: 25)),
            pw.Text(Total_Companies, style: const pw.TextStyle(fontSize: 25)),
          ],
        )
      ],
    ));
    return saveDocument(name: "End_Shift.pdf", pdf: pdf);
  }

  static Future<File> saveDocument(
      {required String name, required pw.Document pdf}) async {
    final bytes = await pdf.save();

    final dir = await getExternalStorageDirectory();
    ();
    final file = File("${dir!.path}/$name");
    await file.writeAsBytes(bytes);
    return file;
  }

  static Future openFile(File file) async {
    final url = file.path;
    if (await Permission.storage.request().isGranted) {
      log(url);
      await OpenFile.open(url);
    } else {
      print("object");
    }
  }
}
