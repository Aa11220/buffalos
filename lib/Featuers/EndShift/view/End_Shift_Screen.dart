import 'dart:developer';

import '../../../utility/pdf/Pdf_api.dart';

import '../Widget/Common_Row.dart';
import 'Manager_Aproval.dart';

import '../../../models/EmpDataModule.dart';
import '../../../models/EmpEndShift.dart';
import '../../../utility/commonwidget/appbar.dart';
import '../../../utility/commonwidget/drawer.dart';
import '../../../utility/lineargragr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../../../apis/Emails/SendEmail.dart';
import '../Controller/EmailDataController.dart';
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
int? emp_id;

EmpData? data;

class _EndShiftState extends ConsumerState<EndShift> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
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

  void onsavepdf(bool send) async {
    if (_key.currentState!.validate()) {
      _key.currentState!.save();

      final pdffile = await PDFUtils.generatepdf(
          id: (id ?? "").toString(),
          Starttime: data!.StartTime ?? "",
          name: name ?? "",
          Discount: (data!.Discount ?? "").toString(),
          NetOrder: (data!.NetCash ?? "").toString(),
          Rcount: (data!.returncount ?? "").toString(),
          order: (data!.ordercount ?? "").toString(),
          Total: (data!.returnedvalue ?? "").toString(),
          Totalorder: (data!.price ?? "").toString(),
          orderdDiscounted: (data!.price ?? "").toString(),
          tottalcash: (data!.Cashprice ?? "").toString(),
          Total_Card: (data!.Visaprice ?? "").toString(),
          Total_Companies: (data!.Componyprice ?? "").toString());

      if (send == true) {
        final list = await ref.read(EmailToControllerProvider).getall(context);
        await ref.read(SendEmailApiProvider).addfile(pdffile, "welcom", list);
        print("object");
      } else {
        PDFUtils.openFile(pdffile);
      }
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
          appBar:  Customappbar(
            text: "End Shift",
          ),
          drawer: MyDrawer(context),
          body: Padding(
            padding: const EdgeInsets.symmetric(
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
                      height: 45,
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
                            decoration: const InputDecoration(
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
                            emp_id = suggestion.FK_EmpID;

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
                                if (_key.currentState!.validate()) {
                                  _key.currentState!.save();
                                  Navigator.of(context).pushNamed(
                                      MangerAproval.path,
                                      arguments: emp_id);
                                }
                              },
                              child: const Text("Manager Aproval"))),
                      Flexible(
                          fit: FlexFit.tight,
                          flex: 1,
                          child: ElevatedButton(
                              onPressed: () {
                                onsavepdf(false);
                              },
                              child: const Text("PDF"))),
                      Flexible(
                          fit: FlexFit.tight,
                          flex: 2,
                          child: ElevatedButton(
                              onPressed: () {
                                onsavepdf(true);
                              },
                              child: const Text("Send PDF"))),
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
