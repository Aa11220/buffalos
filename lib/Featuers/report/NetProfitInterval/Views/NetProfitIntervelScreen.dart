import 'package:buffalos/utility/commonwidget/appbar.dart';
import 'package:buffalos/utility/commonwidget/drawer.dart';
import 'package:buffalos/utility/lineargragr.dart';
import 'package:buffalos/utility/pdf/Pdf_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../apis/Emails/SendEmail.dart';
import '../../../../apis/NetProfit/NetProfitApi.dart';
import '../../../../models/IntervalBenifits.dart';
import '../../../EndShift/Controller/EmailDataController.dart';

class NetProfitIntervelScreen extends ConsumerStatefulWidget {
  const NetProfitIntervelScreen({super.key});
  static const path = "/NetProfitIntervelScreen";
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NetProfitIntervelScreenState();
}

class _NetProfitIntervelScreenState
    extends ConsumerState<NetProfitIntervelScreen> {
  var isloading = false;
  DateTime? _selectedDate;
  DateTime? _SecondselectedDate;
  Future<void> _selectDate(bool Start) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
    );
    if (pickedDate != null &&
        (pickedDate != _selectedDate || pickedDate != _SecondselectedDate)) {
      if (Start) {
        setState(() {
          _selectedDate = pickedDate;
        });
      }
      if (!Start) {
        setState(() {
          _SecondselectedDate = pickedDate;
        });
      }
    }
  }

  void _onsave(bool send) async {
    if (_selectedDate != null && _SecondselectedDate != null) {
      final me = await PDFUtils.generatepdfNetProffit(
          Starttime: DateFormat("yyyy-MM-dd").format(_selectedDate!).toString(),
          Endtime:
              DateFormat("yyyy-MM-dd").format(_SecondselectedDate!).toString(),
          data: data!);

      if (send == true) {
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

  IntervalBenfitsModule? data;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(gradient: linear),
        child: Scaffold(
          appBar: Customappbar(text: "Net Profit report for period"),
          drawer: MyDrawer(context),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Text("From date:" +
                        (_selectedDate == null
                            ? ""
                            : DateFormat("yyyy-MM-dd")
                                .format(_selectedDate!)
                                .toString())),
                    IconButton(
                        onPressed: () async {
                          await _selectDate(true);
                          if (_selectedDate != null &&
                              _SecondselectedDate != null) {
                            data = await ref
                                .read(NetProfitForPeriodApiProvider)
                                .GetData(
                                    DateFormat("yyyy-MM-dd")
                                        .format(_selectedDate!)
                                        .toString(),
                                    DateFormat("yyyy-MM-dd")
                                        .format(_SecondselectedDate!)
                                        .toString());
                            setState(() {});
                          }
                        },
                        icon: Icon(Icons.date_range))
                  ],
                ),
                Row(
                  children: [
                    Text("To date:" +
                        (_SecondselectedDate == null
                            ? ""
                            : DateFormat("yyyy-MM-dd")
                                .format(_SecondselectedDate!)
                                .toString())),
                    IconButton(
                        onPressed: () async {
                          await _selectDate(false);
                          if (_selectedDate != null &&
                              _SecondselectedDate != null) {
                            data = await ref
                                .read(NetProfitForPeriodApiProvider)
                                .GetData(
                                    DateFormat("yyyy-MM-dd")
                                        .format(_selectedDate!)
                                        .toString(),
                                    DateFormat("yyyy-MM-dd")
                                        .format(_SecondselectedDate!)
                                        .toString());
                            setState(() {});
                          }
                        },
                        icon: Icon(Icons.date_range))
                  ],
                ),
                Consumer(
                  builder: (context, ref, child) {
                    return Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              Text("Total Sales : "),
                              if (data != null) Text("${data?.sum_sell}")
                            ],
                          ),
                          Row(
                            children: [
                              Text("Total returns : "),
                              if (data != null) Text("${data?.sum_return}")
                            ],
                          ),
                          Row(
                            children: [
                              Text("Total Cost : "),
                              if (data != null) Text("${data?.sum_payments}")
                            ],
                          ),
                          Row(
                            children: [
                              Text("Total expenses return : "),
                              if (data != null) Text("${data?.sum_payments}")
                            ],
                          ),
                          Row(
                            children: [
                              Text("Net profit : "),
                              if (data != null) Text("${data?.profit}")
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          _onsave(false);
                        },
                        child: Text("PDF")),
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      child: isloading == true
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : ElevatedButton(
                              onPressed: () {
                                _onsave(true);
                              },
                              child: Text("Send PDF")),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
