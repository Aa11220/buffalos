import 'dart:io';

import 'package:buffalos/utility/commonwidget/appbar.dart';
import 'package:buffalos/utility/commonwidget/drawer.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:path/path.dart' as p;

import '../../../utility/lineargragr.dart';

class EpensesScreen extends ConsumerStatefulWidget {
  const EpensesScreen({super.key});
  static const String path = "/EpensesScreen";

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EpensesScreenState();
}

class _EpensesScreenState extends ConsumerState<EpensesScreen> {
  bool mysafe = true;
  File? _selectedFile;

  void pickfile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      _selectedFile = File(result.files.single.path!);

      setState(() {});
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(gradient: linear),
        child: Scaffold(
          drawer: MyDrawer(context),
          appBar: Customappbar(text: "Expenses"),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Name:"),
                  SizedBox(height: 8),
                  TextField(),
                  SizedBox(height: 8),
                  Text("Name:"),
                  SizedBox(height: 8),
                  TextField(),
                  SizedBox(height: 8),
                  Text("Name:"),
                  SizedBox(height: 8),
                  TextField(
                    minLines: 2,
                    maxLines: 10,
                  ),
                  SizedBox(height: 8),
                  Text("Safe : "),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: RadioListTile(
                            title: Text("cash"),
                            value: true,
                            groupValue: mysafe,
                            onChanged: (value) {
                              setState(() {
                                mysafe = value!;
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: RadioListTile(
                            title: Text("other Safe"),
                            value: false,
                            groupValue: mysafe,
                            onChanged: (value) {
                              setState(() {
                                mysafe = value!;
                              });
                            },
                          ),
                        )
                      ]),
                  if (!mysafe)
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
                  SizedBox(height: 8),
                  _selectedFile != null
                      ? Container(
                          width: MediaQuery.of(context).size.width * .5,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.white, width: 1)),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(p.basename(_selectedFile!.path)),
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
                              backgroundColor: MaterialStateProperty.all<Color>(
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
                                  style: TextStyle(color: Color(0xFF923D22)),
                                ),
                                Icon(
                                  Icons.attachment,
                                  color: Color(0xFF923D22),
                                  size: 24.0,
                                ),
                              ]),
                        ),
                  SizedBox(height: 8),
                  Center(
                      child:
                          ElevatedButton(onPressed: () {}, child: Text("Save")))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
