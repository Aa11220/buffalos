import 'dart:developer';
import 'dart:io';

import 'package:buffalos/models/EmpDataModule.dart';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';

import '../../models/IntervalBenifits.dart';
import '../../models/ItemReportModule.dart';
import '../../models/MonthlyProfitItem.dart';

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
        pw.Text('Start Time : $Starttime',
            style: const pw.TextStyle(fontSize: 25)),
        pw.Text('Employee Name : $name',
            style: const pw.TextStyle(fontSize: 25)),
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

  static Future<File> generatepdfEndShift(
      {required String id,
      required String Total_host,
      required String Starttime,
      required String name,
      required EmpData data}) async {
    final pdf = pw.Document();
    final image =
        (await rootBundle.load("assets/img/image005.png")).buffer.asUint8List();
    pdf.addPage(pw.MultiPage(
      build: (context) => <pw.Widget>[
        pw.Image(pw.MemoryImage(image), width: 150),
        pw.Text('Shift iD : $id', style: const pw.TextStyle(fontSize: 25)),
        pw.Text('Start Time : ${data.StartTime}',
            style: const pw.TextStyle(fontSize: 25)),
        pw.Text('Employee Name : $name',
            style: const pw.TextStyle(fontSize: 25)),
        pw.SizedBox(height: 20),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text('Order', style: const pw.TextStyle(fontSize: 25)),
            pw.Text((data.ordercount ?? 0).toString(),
                style: const pw.TextStyle(fontSize: 25)),
          ],
        ),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text('Total Order', style: const pw.TextStyle(fontSize: 25)),
            pw.Text((data.price ?? "").toString(),
                style: const pw.TextStyle(fontSize: 25)),
          ],
        ),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text('Discount', style: const pw.TextStyle(fontSize: 25)),
            pw.Text((data.Discount ?? "").toString(),
                style: const pw.TextStyle(fontSize: 25)),
          ],
        ),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text('Total order after discount',
                style: const pw.TextStyle(fontSize: 25)),
            pw.Text((data.TotalAfterDiscount ?? "").toString(),
                style: const pw.TextStyle(fontSize: 25)),
          ],
        ),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text('Return count', style: const pw.TextStyle(fontSize: 25)),
            pw.Text((data.returncount ?? "").toString(),
                style: const pw.TextStyle(fontSize: 25)),
          ],
        ),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text('Total Return', style: const pw.TextStyle(fontSize: 25)),
            pw.Text((data.returnedvalue ?? "").toString(),
                style: const pw.TextStyle(fontSize: 25)),
          ],
        ),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text('Total host', style: const pw.TextStyle(fontSize: 25)),
            pw.Text((data.Hordercount ?? "").toString(),
                style: const pw.TextStyle(fontSize: 25)),
          ],
        ),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text('Expenseses Count',
                style: const pw.TextStyle(fontSize: 25)),
            pw.Text((data.expensecount ?? "").toString(),
                style: const pw.TextStyle(fontSize: 25)),
          ],
        ),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text('Total Expenses Value',
                style: const pw.TextStyle(fontSize: 25)),
            pw.Text((data.expprice ?? "").toString(),
                style: const pw.TextStyle(fontSize: 25)),
          ],
        ),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text('Total unpaid delivery orders',
                style: const pw.TextStyle(fontSize: 25)),
            pw.Text((data.NotPaidDelivery ?? "").toString(),
                style: const pw.TextStyle(fontSize: 25)),
          ],
        ),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text('Total unpaid table orders',
                style: const pw.TextStyle(fontSize: 25)),
            pw.Text((data.NotPaidTables ?? "").toString(),
                style: const pw.TextStyle(fontSize: 25)),
          ],
        ),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text('Value carried over from',
                style: const pw.TextStyle(fontSize: 25)),
            pw.Text((data.TransferedFrom ?? "").toString(),
                style: const pw.TextStyle(fontSize: 25)),
          ],
        ),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text('Value carried over to',
                style: const pw.TextStyle(fontSize: 25)),
            pw.Text((data.TransferedTo ?? "").toString(),
                style: const pw.TextStyle(fontSize: 25)),
          ],
        ),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text('Net order', style: const pw.TextStyle(fontSize: 25)),
            pw.Text((data.NetCash ?? "").toString(),
                style: const pw.TextStyle(fontSize: 25)),
          ],
        ),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text('Total cash', style: const pw.TextStyle(fontSize: 25)),
            pw.Text((data.Cashprice ?? "").toString(),
                style: const pw.TextStyle(fontSize: 25)),
          ],
        ),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text('Total Card', style: const pw.TextStyle(fontSize: 25)),
            pw.Text((data.Visaprice ?? "").toString(),
                style: const pw.TextStyle(fontSize: 25)),
          ],
        ),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text('Total Companies', style: const pw.TextStyle(fontSize: 25)),
            pw.Text((data.Total().toString()).toString(),
                style: const pw.TextStyle(fontSize: 25)),
          ],
        ),
        pw.Divider(),
        ...?data.companyes
            ?.map((e) => pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(e["CompanyName"],
                        style: const pw.TextStyle(fontSize: 25)),
                    pw.Text((e["CompOrderValue"]).toString(),
                        style: const pw.TextStyle(fontSize: 25)),
                  ],
                ))
            .toList(),
        pw.Divider(),
      ],
    ));
    return saveDocument(name: "End_Shift.pdf", pdf: pdf);
  }

  static Future<File> generatepdfNetProffit(
      {required String Starttime,
      required String Endtime,
      required IntervalBenfitsModule data}) async {
    final pdf = pw.Document();
    final image =
        (await rootBundle.load("assets/img/image005.png")).buffer.asUint8List();
    pdf.addPage(pw.MultiPage(
      build: (context) => <pw.Widget>[
        pw.Image(pw.MemoryImage(image), width: 150),
        pw.Text("Start time : $Starttime",
            style: const pw.TextStyle(fontSize: 25)),
        pw.Text("End Time   : $Endtime",
            style: const pw.TextStyle(fontSize: 25)),
        pw.SizedBox(height: 30),
        pw.Center(
          child: pw.Header(
            child: pw.Text("Net profit report for the period",
                style: const pw.TextStyle(fontSize: 25)),
          ),
        ),
        pw.SizedBox(height: 20),
        pw.Text("Total sales:" + " " + "${data.sum_sell} ",
            style: const pw.TextStyle(fontSize: 25)),
        pw.Text("Total returns" + " " + "${data.sum_return} ",
            style: const pw.TextStyle(fontSize: 25)),
        pw.Text("Total Cost:" + " " + "${data.sum_payments} ",
            style: const pw.TextStyle(fontSize: 25)),
        pw.Text("Total Expenses return:" + " " + "${data.sum_payreturn} ",
            style: const pw.TextStyle(fontSize: 25)),
        pw.Text("Net profit:" + " " + "${data.profit} ",
            style: const pw.TextStyle(fontSize: 25)),
      ],
    ));
    return saveDocument(name: "End_Shift.pdf", pdf: pdf);
  }

  static Future<File> generatepdfMonthlyReport(
      {required String Starttime,
      required String Endtime,
      required MonthlyProfitItem data}) async {
    final pdf = pw.Document();
    final image =
        (await rootBundle.load("assets/img/image005.png")).buffer.asUint8List();
    pdf.addPage(pw.MultiPage(
      build: (context) => <pw.Widget>[
        pw.Image(pw.MemoryImage(image), width: 150),
        pw.Text("Month : $Starttime", style: const pw.TextStyle(fontSize: 25)),
        pw.Text("Year: $Endtime", style: const pw.TextStyle(fontSize: 25)),
        pw.SizedBox(height: 30),
        pw.Center(
          child: pw.Header(
            child: pw.Text("Monthly Total Cash movement report",
                style: const pw.TextStyle(fontSize: 25)),
          ),
        ),
        pw.SizedBox(height: 20),
        pw.Text("sales:" + " " + (data.Sales ?? "").toString(),
            style: const pw.TextStyle(fontSize: 25)),
        pw.Text("Spending" + " " + (data.Spendings ?? "").toString(),
            style: const pw.TextStyle(fontSize: 25)),
        pw.Text(
            "Purchase invoices:" +
                " " +
                (data.Main_safe_Purchase_invoices ?? "").toString(),
            style: const pw.TextStyle(fontSize: 25)),
        pw.Text(
            "Main safe expenses:" +
                " " +
                (data.Main_safe_expenses ?? "").toString(),
            style: const pw.TextStyle(fontSize: 25)),
        pw.Text(
            "Main safe purchase invoices:" +
                " " +
                (data.Main_safe_Purchase_invoices ?? "").toString(),
            style: const pw.TextStyle(fontSize: 25)),
        pw.Text("Bank deposit:" + " " + (data.Bank_deposit ?? "").toString(),
            style: const pw.TextStyle(fontSize: 25)),
        // pw.Text("Bank with drawl:" + " " + "${data.} ",
        //     style: const pw.TextStyle(fontSize: 25)),
        pw.Text(
            "Net cash main safe:" +
                " " +
                ((data.Sales ?? 0) +
                        (data.Main_safe_Purchase_invoices ?? 0) +
                        (data.Spendings ?? 0) +
                        (data.Withdrawals ?? 0))
                    .toString(),
            style: const pw.TextStyle(fontSize: 25)),
      ],
    ));
    return saveDocument(name: "End_Shift.pdf", pdf: pdf);
  }

  static Future<File> generatepdfItemSales({
    required String SortedBy,
    required String LimitOfView,
    required String StartTime,
    required String EndTime,
    required String Category,
    required String ItemName,
    List<ItemReportModule>? itemData,
  }) async {
    final pdf = pw.Document();
    final image =
        (await rootBundle.load("assets/img/image005.png")).buffer.asUint8List();
    pdf.addPage(pw.MultiPage(
        build: (context) => <pw.Widget>[
              pw.Image(pw.MemoryImage(image), width: 150),
              pw.Text("From date : $StartTime",
                  style: const pw.TextStyle(fontSize: 25)),
              pw.Text("To Data: $EndTime",
                  style: const pw.TextStyle(fontSize: 25)),
              pw.Text("Sorted by: $SortedBy",
                  style: const pw.TextStyle(fontSize: 25)),
              pw.Text("List of view: $LimitOfView",
                  style: const pw.TextStyle(fontSize: 25)),
              pw.Text("Category: $Category",
                  style: const pw.TextStyle(fontSize: 25)),
              pw.Text("Item name: $ItemName",
                  style: const pw.TextStyle(fontSize: 25)),
              pw.SizedBox(height: 30),
              pw.Center(
                child: pw.Header(
                  child: pw.Text("Item Sales Report",
                      style: const pw.TextStyle(fontSize: 25)),
                ),
              ),
              pw.SizedBox(height: 20),
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                  children: [
                    pw.Text("Name", style: const pw.TextStyle(fontSize: 25)),
                    pw.Text("Category",
                        style: const pw.TextStyle(fontSize: 25)),
                    pw.Text("Price", style: const pw.TextStyle(fontSize: 25)),
                    pw.Text("Qty", style: const pw.TextStyle(fontSize: 25)),
                    pw.Text("Total", style: const pw.TextStyle(fontSize: 25)),
                  ]),
              ...(itemData ?? []).map(
                  (e) => pw.Table(tableWidth: pw.TableWidth.max, children: [
                        pw.TableRow(children: [
                          pw.Expanded(
                              child: pw.Center(
                            child: pw.Text(e.ItemName ?? "",
                                style: const pw.TextStyle(fontSize: 25)),
                          )),
                          pw.SizedBox(width: 10),
                          pw.Expanded(
                              child: pw.Center(
                            child: pw.Text(e.CategoryName ?? "",
                                style: const pw.TextStyle(fontSize: 25)),
                          )),
                          pw.SizedBox(width: 10),
                          pw.Expanded(
                              child: pw.Center(
                            child: pw.Text((e.Price ?? "").toString(),
                                style: const pw.TextStyle(fontSize: 25)),
                          )),
                          pw.SizedBox(width: 10),
                          pw.Expanded(
                              child: pw.Center(
                            child: pw.Text((e.totalQty ?? "").toString(),
                                style: const pw.TextStyle(fontSize: 25)),
                          )),
                          pw.SizedBox(width: 10),
                          pw.Expanded(
                              child: pw.Center(
                            child: pw.Text((e.TotalSales ?? "").toString(),
                                style: const pw.TextStyle(fontSize: 25)),
                          )),
                          pw.SizedBox(height: 150)
                        ]),
                      ])),
            ]));
    return saveDocument(name: "End_Shift.pdf", pdf: pdf);
  }
}
