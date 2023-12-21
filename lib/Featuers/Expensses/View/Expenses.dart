import 'dart:io';

import 'package:buffalos/apis/Expenssesapi/Expensesapi.dart';
import 'package:buffalos/apis/userapi.dart';
import 'package:buffalos/utility/commonwidget/appbar.dart';
import 'package:buffalos/utility/commonwidget/drawer.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:path/path.dart' as p;

import '../../../apis/SafeData/SafeEpress.dart';
import '../../../utility/lineargragr.dart';

class EpensesScreen extends ConsumerStatefulWidget {
  const EpensesScreen({super.key});
  static const String path = "/EpensesScreen";

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EpensesScreenState();
}

class _EpensesScreenState extends ConsumerState<EpensesScreen> {
  TextEditingController safe = TextEditingController();
  GlobalKey<FormState> _key = GlobalKey();
  bool mysafe = true;
  File? _selectedFile;
  String? name;
  int? value;
  String? note;
  int? safeid;

  void pickfile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      _selectedFile = File(result.files.single.path!);

      setState(() {});
    }
  }

  void onsave() async {
    if (_key.currentState!.validate()) {
      try {
        _key.currentState!.save();
        final oo = ref.read(authprovider).logedin.fkSafeId;
        final op = ref.read(authprovider).logedin.shiftID;
        final int? _expid;
        if (mysafe) {
          _expid = await ref.read(ExpensesApiProvider).SendExpensess(
              value: value!,
              fK_Safe_ID: oo,
              fK_Shift_ID: op,
              payName: name!,
              description: note);
        } else {
          _expid = await ref.read(ExpensesApiProvider).SendExpensess(
              value: value!,
              fK_Safe_ID: safeid!,
              fK_Shift_ID: op,
              payName: name!,
              description: note);
        }
        if (_selectedFile != null) {
          ref
              .read(ExpensesApiProvider)
              .addfile(_selectedFile!, _expid.toString());
          if (_selectedFile != null) {
            setState(() {
              _selectedFile = null;
            });
          }
        }
        _key.currentState?.reset();
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Error happen")));
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Error happen")));
      }
    }
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
              child: Form(
                key: _key,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Name:"),
                    SizedBox(height: 8),
                    TextFormField(
                      initialValue: "",
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.trim().isEmpty) {
                          return "Enter value";
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        name = newValue;
                      },
                    ),
                    SizedBox(height: 8),
                    Text("Value:"),
                    SizedBox(height: 8),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      initialValue: "",
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.trim().isEmpty) {
                          return "Enter value";
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        value = int.tryParse(newValue!);
                      },
                    ),
                    SizedBox(height: 8),
                    Text("Note:"),
                    SizedBox(height: 8),
                    TextFormField(
                      initialValue: "",
                      minLines: 2,
                      maxLines: 10,
                      onSaved: (newValue) {
                        note = newValue;
                      },
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
                        direction: AxisDirection.up,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.trim().isEmpty) {
                            return "Enter value";
                          }
                          return null;
                        },
                        onReset: () => safe.clear(),
                        textFieldConfiguration: TextFieldConfiguration(
                          onTap: () => safe.clear(),
                          controller: safe,
                          decoration: const InputDecoration(
                              hintText: "Select ...",
                              suffixIcon: Icon(Icons.keyboard_arrow_down)),
                        ),
                        itemBuilder: (context, itemData) =>
                            Text(itemData.safeName!),
                        suggestionsCallback: (pattern) async {
                          final _list = await ref
                              .read(SafeDataExpressApiProvider)
                              .getsafeData();
                          final _lisst = _list.where((element) =>
                              element.safe_type == "visa" ||
                              element.safe_type == "company");
                          return _lisst.where((element) {
                            return element.safeName!
                                .toLowerCase()
                                .contains(pattern.toLowerCase());
                          });
                        },
                        onSuggestionSelected: (suggestion) {
                          safe.text = suggestion.safeName!;
                          safeid = suggestion.pkSafeId;
                        },
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
                        child: ElevatedButton(
                            onPressed: () {
                              onsave();
                            },
                            child: Text("Save")))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
