import 'package:buffalos/models/MonthlyProfitItem.dart';
import 'package:buffalos/utility/commonwidget/appbar.dart';
import 'package:buffalos/utility/commonwidget/drawer.dart';
import 'package:buffalos/utility/lineargragr.dart';
import 'package:buffalos/utility/pdf/Pdf_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../apis/Emails/SendEmail.dart';
import '../../../../apis/MonthlyReportApi.dart';
import '../../../EndShift/Controller/EmailDataController.dart';

class MonthlyReportScreen extends ConsumerStatefulWidget {
  const MonthlyReportScreen({super.key});
  static const path = "Monthly Report";
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MonthlyReportScreenState();
}

bool isloading = false;

class _MonthlyReportScreenState extends ConsumerState<MonthlyReportScreen> {
  MonthlyProfitItem? data;
  DateTime now = DateTime.now();
  final TextEditingController _year = TextEditingController();
  final TextEditingController _Month = TextEditingController();
  DateTime? value;
  int? Mvalue;
  final Map Month = const {
    "January": 1,
    "February": 2,
    "March": 3,
    "April": 4,
    "May": 5,
    "June": 6,
    "July": 7,
    "August": 8,
    "September": 9,
    "October": 10,
    "November": 11,
    "December": 12
  };
  void _onsafe(bool send) async {
    if (value != null && Mvalue != null) {
      var key =
          Month.keys.firstWhere((k) => Month[k] == Mvalue, orElse: () => null);
      final me = await PDFUtils.generatepdfMonthlyReport(
          Starttime: key.toString(),
          Endtime: value!.toIso8601String().split("-")[0],
          data: data!);
      if (send) {
        try {
          setState(() {
            isloading = true;
          });
          final list =
              await ref.read(EmailToControllerProvider).getall(context);
          await ref.read(SendEmailApiProvider).addfile(me, "welcom", list);
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Done")));
        } catch (e) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Error Happen")));
        }
        setState(() {
          isloading = false;
        });
      } else {
        PDFUtils.openFile(me);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Enter data First"),
      ));
    }
  }

// Create a list of length 8 (from 0 to 7)
  List<DateTime>? dates;
  @override
  void initState() {
    dates = List.generate(8, (index) {
      // Subtract index years from the current date
      return DateTime(now.year - index);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      decoration: BoxDecoration(gradient: linear),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: Customappbar(text: "Monthly Report"),
        drawer: MyDrawer(context),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    const Text("Year"),
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      width: MediaQuery.of(context).size.width * .30,
                      child: DropdownButton(
                        isExpanded: true,
                        value: value,
                        items: dates
                            ?.map(
                              (e) => DropdownMenuItem(
                                value: e,
                                child: Text(e.toIso8601String().split("-")[0]),
                              ),
                            )
                            .toList(),
                        onChanged: (val) async {
                          setState(() {
                            value = val;
                          });
                          if (Mvalue != null && value != null) {
                            data = await ref
                                .read(MonthlyReportApiProvider)
                                .GetData(Mvalue!.toString(),
                                    value!.toIso8601String().split("-")[0]);
                          }
                        },
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    const Text("Month"),
                    Container(
                        width: MediaQuery.of(context).size.width * .30,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        child: DropdownButton(
                            isExpanded: true,
                            value: Mvalue,
                            items: Month.map((description, value) {
                              return MapEntry(
                                  description,
                                  DropdownMenuItem(
                                    value: value,
                                    child: Text(description),
                                  ));
                            }).values.toList(),
                            onChanged: (val) async {
                              Mvalue = val as int;

                              if (Mvalue != null && value != null) {
                                data = await ref
                                    .read(MonthlyReportApiProvider)
                                    .GetData(Mvalue!.toString(),
                                        value!.toIso8601String().split("-")[0]);
                              }
                              setState(() {});
                            }))
                  ],
                )
              ],
            ),
            Expanded(
                // height: MediaQuery.of(context).size.height * .7,
                child: Card(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(child: Text("Monthly Report")),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Sales"),
                          if (data != null)
                            Text((data?.Sales ?? "").toString()),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Spending"),
                          if (data != null)
                            Text((data?.Spendings ?? "").toString()),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Main safe epenses"),
                          if (data != null)
                            Text((data?.Main_safe_expenses ?? "").toString()),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Main safe purchase invoices"),
                          if (data != null)
                            Text((data?.Main_safe_Purchase_invoices ?? "")
                                .toString()),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Bank deposit"),
                          if (data != null)
                            Text((data?.Bank_deposit ?? "").toString()),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Bank wirhdrawals"),
                          if (data != null)
                            Text((data?.Bank_deposit ?? "").toString()),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Net cash"),
                          if (data != null)
                            Text((data?.Withdrawals ?? "").toString()),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Net Cash main safe"),
                          if (data != null)
                            Text((data?.Sales ?? "").toString()),
                          if (data != null)
                            Text(((data?.Sales ?? 0) +
                                    (data?.Main_safe_Purchase_invoices ?? 0) +
                                    (data?.Spendings ?? 0) +
                                    (data?.Withdrawals ?? 0))
                                .toString()),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                    ]),
              ),
            )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      _onsafe(false);
                    },
                    child: const Text("PDF")),
                SizedBox(
                  child: isloading == true
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : ElevatedButton(
                          onPressed: () {
                            _onsafe(true);
                          },
                          child: const Text("Send PDF")),
                )
              ],
            )
          ],
        ),
      ),
    ));
  }
}
