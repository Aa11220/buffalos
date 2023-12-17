import 'dart:io';

import 'package:buffalos/Featuers/purchaes/Controller/SupplierController/SupplierController.dart';
import 'package:buffalos/utility/commonwidget/appbar.dart';
import 'package:buffalos/utility/commonwidget/drawer.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as p;
import '../../../models/Supplier/SupplierModule.dart';
import '../../../utility/lineargragr.dart';
import '../Controller/safeController.dart';
import '../Controller/storeController.dart';
import 'AddRawMaterialScreen.dart';

class PurchaseDataScreen extends ConsumerStatefulWidget {
  const PurchaseDataScreen({super.key});
  static const path = "/PurchaseScreen";
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PurchaseDataScreenState();
}

class _PurchaseDataScreenState extends ConsumerState<PurchaseDataScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController Number = TextEditingController();
  TextEditingController Shopsname = TextEditingController();
  TextEditingController payment = TextEditingController();
  TextEditingController safe = TextEditingController();
  SuggestionsBoxController namebox = SuggestionsBoxController();
  SuggestionsBoxController shopname = SuggestionsBoxController();
  SuggestionsBoxController prebbox = SuggestionsBoxController();
  SuggestionsBoxController paymentbox = SuggestionsBoxController();
  SuggestionsBoxController safebox = SuggestionsBoxController();
  @override
  void dispose() {
    // TODO: implement dispose
    name.dispose();
    Number.dispose();
    Shopsname.dispose();
    payment.dispose();
    safe.dispose();
    super.dispose();
  }

  DateTime? _selectedDate;
  File? _selectedFile;

  void _selectDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void pickfile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      _selectedFile = File(result.files.single.path!);

      setState(() {});
    } else {}
  }

  var _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          namebox.close();
          shopname.close();
          prebbox.close();
          paymentbox.close();
          safebox.close();
        },
        child: Container(
          decoration: BoxDecoration(gradient: linear),
          child: Scaffold(
              appBar: Customappbar(
                text: "Purchase Data",
              ),
              drawer: MyDrawer(context),
              body: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 18, horizontal: 10),
                  child: Form(
                    key: _key,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Supplier Nmae"),
                        SizedBox(
                          height: 15,
                        ),
                        TypeAheadFormField<SupllierModule>(
                          suggestionsBoxController: namebox,
                          textFieldConfiguration: TextFieldConfiguration(
                            onTap: () => name.clear(),
                            controller: name,
                            decoration: const InputDecoration(
                                hintText: "Select ...",
                                suffixIcon: Icon(Icons.keyboard_arrow_down)),
                          ),
                          itemBuilder: (context, itemData) => SizedBox(
                              height: 50,
                              child: Center(
                                child: Text(
                                  itemData.supplierName!,
                                ),
                              )),
                          suggestionsCallback: (pattern) async {
                            final _list = await ref
                                .read(SupplierControllerProvider)
                                .getall();
                            return _list.where((element) {
                              return element.supplierName!
                                  .toLowerCase()
                                  .contains(pattern.toLowerCase());
                            });
                          },
                          onSuggestionSelected: (suggestion) {
                            name.text = suggestion.supplierName!;
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text("Invoice Number"),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: Number,
                          decoration: InputDecoration(
                              hintText: "Enter Invoice Number..."),
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text("Store Nmae"),
                        SizedBox(
                          height: 15,
                        ),
                        TypeAheadFormField(
                          suggestionsBoxController: shopname,
                          textFieldConfiguration: TextFieldConfiguration(
                            onTap: () => Shopsname.clear(),
                            controller: Shopsname,
                            decoration: const InputDecoration(
                              hintText: "Select ...",
                              suffixIcon: Icon(Icons.keyboard_arrow_down),
                            ),
                          ),
                          itemBuilder: (context, itemData) => SizedBox(
                              height: 50,
                              child: Center(
                                child: Text(itemData.storeName!),
                              )),
                          suggestionsCallback: (pattern) async {
                            final _list = await ref
                                .read(storeControllerProvider)
                                .getall(context);
                            return _list.where((element) {
                              return element.storeName!
                                  .toLowerCase()
                                  .contains(pattern.toLowerCase());
                            });
                          },
                          onSuggestionSelected: (suggestion) {
                            Shopsname.text = suggestion.storeName!;
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Text(
                              _selectedDate == null
                                  ? "* Please Select Date :  "
                                  : DateFormat("yyyy-MM-dd")
                                      .format(_selectedDate!),
                              style: TextStyle(color: Colors.white),
                            ),
                            IconButton(
                              onPressed: _selectDate,
                              icon: Icon(
                                Icons.date_range,
                                color: Color(0xFF90391E),
                              ),
                            ),
                          ],
                        ),
                        _selectedFile != null
                            ? Container(
                                width: MediaQuery.of(context).size.width * .5,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.white, width: 1)),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child:
                                          Text(p.basename(_selectedFile!.path)),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          _selectedFile = null;
                                          setState(() {});
                                        },
                                        icon: Icon(Icons.close))
                                  ],
                                ),
                              )
                            : ElevatedButton(
                                onPressed: () {
                                  pickfile();
                                },
                                style: ButtonStyle(
                                    splashFactory: NoSplash.splashFactory,
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            const Color(0xFFFFFFFF)),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            8.0), // radius you want
                                      ),
                                    )),
                                child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Attatch File',
                                        style:
                                            TextStyle(color: Color(0xFF923D22)),
                                      ),
                                      Icon(
                                        Icons.attachment,
                                        color: Color(0xFF923D22),
                                        size: 24.0,
                                      ),
                                    ]),
                              ),
                        SizedBox(
                          height: 15,
                        ),
                        Text("Payment Methods"),
                        SizedBox(
                          height: 15,
                        ),
                        TypeAheadFormField(
                          direction: AxisDirection.up,
                          suggestionsBoxController: paymentbox,
                          textFieldConfiguration: TextFieldConfiguration(
                            onTap: () => payment.clear(),
                            controller: payment,
                            decoration: const InputDecoration(
                                hintText: "Select ...",
                                suffixIcon: Icon(Icons.keyboard_arrow_down)),
                          ),
                          itemBuilder: (context, itemData) => SizedBox(
                              height: 50, child: Center(child: Text(itemData))),
                          suggestionsCallback: (pattern) => ["Cash", "Agel"],
                          onSuggestionSelected: (suggestion) {
                            payment.text = suggestion;
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text("Safe"),
                        SizedBox(
                          height: 15,
                        ),
                        TypeAheadFormField(
                          suggestionsBoxController: safebox,
                          textFieldConfiguration: TextFieldConfiguration(
                            onTap: () => safe.clear(),
                            controller: safe,
                            decoration: const InputDecoration(
                                hintText: "Select ...",
                                suffixIcon: Icon(Icons.keyboard_arrow_down)),
                          ),
                          direction: AxisDirection.up,
                          itemBuilder: (context, itemData) => SizedBox(
                              height: 50,
                              child: Center(child: Text(itemData.SafeName!))),
                          suggestionsCallback: (pattern) async {
                            final _list =
                                await ref.read(SafeControllerProvider).getall();
                            return _list.where((element) {
                              return element.SafeName!
                                  .toLowerCase()
                                  .contains(pattern.toLowerCase());
                            });
                          },
                          onSuggestionSelected: (suggestion) {
                            safe.text = suggestion.SafeName!;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(AddRawMaterialScreen.path);
                            },
                            child: Text("Next"),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
