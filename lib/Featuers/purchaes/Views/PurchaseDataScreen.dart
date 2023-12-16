import 'dart:io';

import 'package:buffalos/utility/commonwidget/appbar.dart';
import 'package:buffalos/utility/commonwidget/drawer.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as p;
import '../../../utility/lineargragr.dart';
import 'AddRawMaterialScreen.dart';

class PurchaseDataScreen extends ConsumerStatefulWidget {
  const PurchaseDataScreen({super.key});
  static const path = "/PurchaseScreen";
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PurchaseDataScreenState();
}

class _PurchaseDataScreenState extends ConsumerState<PurchaseDataScreen> {
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
                      TypeAheadFormField(
                        textFieldConfiguration: TextFieldConfiguration(
                          decoration: const InputDecoration(
                              hintText: "Select ...",
                              suffixIcon: Icon(Icons.keyboard_arrow_down)),
                        ),
                        itemBuilder: (context, itemData) => Text("data"),
                        suggestionsCallback: (pattern) => ["aa"],
                        onSuggestionSelected: (suggestion) {},
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text("Invoice Number"),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
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
                        textFieldConfiguration: TextFieldConfiguration(
                          decoration: const InputDecoration(
                              hintText: "Select ...",
                              suffixIcon: Icon(Icons.keyboard_arrow_down)),
                        ),
                        itemBuilder: (context, itemData) => Text("data"),
                        suggestionsCallback: (pattern) => ["aa"],
                        onSuggestionSelected: (suggestion) {},
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
                        textFieldConfiguration: TextFieldConfiguration(
                          decoration: const InputDecoration(
                              hintText: "Select ...",
                              suffixIcon: Icon(Icons.keyboard_arrow_down)),
                        ),
                        itemBuilder: (context, itemData) => Text("data"),
                        suggestionsCallback: (pattern) => ["aa"],
                        onSuggestionSelected: (suggestion) {},
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text("Safe"),
                      SizedBox(
                        height: 15,
                      ),
                      TypeAheadFormField(
                        textFieldConfiguration: TextFieldConfiguration(
                          decoration: const InputDecoration(
                              hintText: "Select ...",
                              suffixIcon: Icon(Icons.keyboard_arrow_down)),
                        ),
                        itemBuilder: (context, itemData) => Text("data"),
                        suggestionsCallback: (pattern) => ["aa"],
                        onSuggestionSelected: (suggestion) {},
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
    );
  }
}
