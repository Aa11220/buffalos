import 'dart:developer';
import 'dart:io';

import 'package:buffalos/utility/pdf/Pdf_api.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'package:buffalos/Featuers/EndShift/Widget/Common_Row.dart';
import 'package:buffalos/Featuers/EndShift/view/Manager_Aproval.dart';

import 'package:buffalos/models/EmpDataModule.dart';
import 'package:buffalos/models/EmpEndShift.dart';
import 'package:buffalos/utility/commonwidget/appbar.dart';
import 'package:buffalos/utility/commonwidget/drawer.dart';
import 'package:buffalos/utility/lineargragr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../Controller/EmpDataApi.dart';
import '../Controller/EmpShiftController.dart';

class EndShift extends ConsumerStatefulWidget {
  const EndShift({super.key});
  static const endpath = "/EndShift";

  @override
  ConsumerState<EndShift> createState() => _EndShiftState();
}

int? id;
String? name;

EmpData? data;

class _EndShiftState extends ConsumerState<EndShift> {
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  final Employeetextcontroller = TextEditingController();
  @override
  void deactivate() {
    data = null;
    super.deactivate();
  }

  @override
  void dispose() {
    data = null;
    Employeetextcontroller.dispose();
    super.dispose();
  }

  void onsavepdf() async {
    if (_key.currentState!.validate()) {
      _key.currentState!.save();

      // final pdffile = await PDFUtils.generatepdf(
      //   id: (id ?? "").toString(),
      //   Starttime: data!.StartTime ?? "",
      //   name: name ?? "",
      //   Discount: (data!.TotalAfterDiscount ?? "").toString(),
      //   NetOrder: (data!.NetCash ?? "").toString(),
      //   Rcount: (data!.returncount ?? "").toString(),
      //   order: (data!.ordercount ?? "").toString(),
      //   Total: data!.
      // );
      // PDFUtils.openFile(pdffile);
    }
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          gradient: linear,
        ),
        child: Scaffold(
          appBar: Customappbar(
            text: "End Shift",
          ),
          drawer: MyDrawer(context),
          body: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 5,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Form(
                    key: _key,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * .4,
                      child: TypeAheadFormField<EmpEndShift>(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Chosse Frist";
                            }
                            return null;
                          },
                          textFieldConfiguration: TextFieldConfiguration(
                            onTap: () {
                              Employeetextcontroller.clear();
                            },
                            controller: Employeetextcontroller,
                            decoration: InputDecoration(
                                hintText: "Employee",
                                suffixIcon: Icon(Icons.keyboard_arrow_down)),
                          ),
                          suggestionsCallback: (A) async {
                            final mylist = await ref
                                .watch(EndShiftControllerProvider)
                                .getAllCashiers(context);
                            return mylist.where((element) {
                              return element.EmpName.toLowerCase()
                                  .contains(A.toLowerCase());
                            });
                          },
                          itemBuilder: (context, itemData) =>
                              Text(itemData.EmpName),
                          onSuggestionSelected: (suggestion) async {
                            Employeetextcontroller.text = suggestion.EmpName;
                            id = suggestion.PK_Shift_ID;
                            name = suggestion.EmpName;

                            data = await ref
                                .read(EmpDataControllerProvider)
                                .getdata(id.toString());
                            log(data.toString());
                            setState(() {});

                            print(data);
                          }),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .7,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          CommonRow(
                              lable1: "Total Orders",
                              lable2: "Total Orders After Discount",
                              Value1: data == null
                                  ? ""
                                  : (data!.price ?? "").toString(),
                              value2: data == null
                                  ? ""
                                  : (data!.TotalAfterDiscount ?? "")
                                      .toString()),
                          CommonRow(
                              lable1: "Total Cash",
                              lable2: "Total Visa",
                              Value1: data == null
                                  ? ""
                                  : (data!.Cashprice ?? "").toString(),
                              value2: data == null
                                  ? ""
                                  : (data!.Visaprice ?? "").toString()),
                          CommonRow(
                              lable1: "Total Compaine",
                              lable2: "Total Host",
                              Value1: data == null
                                  ? ""
                                  : (data!.Componyprice ?? "").toString(),
                              value2: data == null
                                  ? ""
                                  : (data!.Hordercount ?? "").toString()),
                          CommonRow(
                              lable1: "Orders Count",
                              lable2: "Returns Count",
                              Value1: data == null
                                  ? ""
                                  : (data!.ordercount ?? "").toString(),
                              value2: data == null
                                  ? ""
                                  : (data!.returncount ?? "").toString()),
                          CommonRow(
                              lable1: "Total Returns Value",
                              lable2: "Expenseses Count",
                              Value1: data == null
                                  ? ""
                                  : (data!.returnedvalue ?? "").toString(),
                              value2: data == null
                                  ? ""
                                  : (data!.expensecount ?? "").toString()),
                          CommonRow(
                              lable1: "Total Expenses",
                              lable2: "Total Unpaid Delivery Orders",
                              Value1: data == null
                                  ? ""
                                  : (data!.expprice ?? "").toString(),
                              value2: data == null
                                  ? ""
                                  : (data!.NotPaidDelivery ?? "").toString()),
                          CommonRow(
                              lable1: "Total Unpaid Table Orders",
                              lable2: "Value Carried Over Form",
                              Value1: data == null
                                  ? ""
                                  : (data!.NotPaidTables ?? "").toString(),
                              value2: data == null
                                  ? ""
                                  : (data!.TransferedFrom ?? "").toString()),
                          CommonRow(
                              lable1: "Value Carried Over To",
                              lable2: "Net Cash",
                              Value1: data == null
                                  ? ""
                                  : (data!.TransferedTo ?? "").toString(),
                              value2: data == null
                                  ? ""
                                  : (data!.NetCash ?? "").toString()),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Flexible(
                          fit: FlexFit.tight,
                          flex: 2,
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed(MangerAproval.path);
                              },
                              child: Text("Manager Aproval"))),
                      Flexible(
                          fit: FlexFit.tight,
                          flex: 1,
                          child: ElevatedButton(
                              onPressed: () {
                                onsavepdf();
                              },
                              child: Text("PDF"))),
                      Flexible(
                          fit: FlexFit.tight,
                          flex: 2,
                          child: ElevatedButton(
                              onPressed: () {}, child: Text("Send PDF"))),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
