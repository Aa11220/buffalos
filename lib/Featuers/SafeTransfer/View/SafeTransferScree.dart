import 'dart:io';
import 'package:intl/intl.dart';

import 'package:buffalos/apis/userapi.dart';
import 'package:path/path.dart' as p;

import 'package:buffalos/utility/commonwidget/appbar.dart';
import 'package:buffalos/utility/commonwidget/drawer.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../apis/SafeData/SafeTransferApi.dart';
import '../../../providers/SafeTransferProvieder.dart';
import '../../../utility/lineargragr.dart';
import '../Widget/FtistRow.dart';
import '../Widget/SecondRow.dart';

class SafeTransferScreen extends ConsumerStatefulWidget {
  const SafeTransferScreen({super.key});
  static const path = "/SafeTransfer";

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SafeTransferScreenState();
}

class _SafeTransferScreenState extends ConsumerState<SafeTransferScreen> {
  String? notetext;
  File? _selectedFile;
  GlobalKey<FormState> _mykey = GlobalKey<FormState>();
  GlobalKey<FormFieldState> _mykey1 = GlobalKey();
  GlobalKey<FormFieldState> _mykey2 = GlobalKey();
  GlobalKey<FormFieldState> _mykey3 = GlobalKey();
  GlobalKey<FormFieldState> _mykey4 = GlobalKey();
  TextEditingController note = TextEditingController(text: "");

  void pickfile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      _selectedFile = File(result.files.single.path!);

      setState(() {});
    } else {}
  }

  void _onsave() async {
    if (_mykey.currentState!.validate()) {
      _mykey.currentState?.save();

      try {
        final _idfrom = ref.read(authprovider).logedin.pkEmpId;
        final _value = double.tryParse(_mykey3.currentState!.value);
        final _now = DateFormat("yyyy-MM-dd").format(DateTime.now());

        final payno = _mykey4.currentState!.value;
        ref.read(SafeTransferProvider.notifier).getvalue(
            value: _value,
            fkEmpFrom: _idfrom,
            transDate: _now.toString(),
            notes: notetext,
            payNo: payno);
        print(ref.read(SafeTransferProvider));
        final _purid = await ref
            .read(SafeTransferApiProvider)
            .setsupplier(ref.read(SafeTransferProvider));
        if (_selectedFile != null) {
          ref
              .read(SafeTransferApiProvider)
              .addfile(_selectedFile!, _purid.toString());
        }
        _mykey.currentState!.reset();
        note.clear();
        setState(() {
          _mykey3.currentState?.reset();
        });

        if (_selectedFile != null) {
          setState(() {
            _selectedFile = null;
          });
        }
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Item Saved")));
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
          appBar: Customappbar(text: "Safe Transfer"),
          drawer: MyDrawer(context),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Form(
                key: _mykey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          height: 100,
                          width: MediaQuery.of(context).size.width * .4,
                          child: FristRow(
                            ref.read(SafeTransferProvider.notifier).getvalue,
                            lable: "From ",
                            text: true,
                            mykey: _mykey1,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .1,
                        ),
                        SizedBox(
                          height: 100,
                          width: MediaQuery.of(context).size.width * .4,
                          child: FristRow(
                            ref.read(SafeTransferProvider.notifier).getvalue,
                            lable: "To",
                            mykey: _mykey2,
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          height: 100,
                          width: MediaQuery.of(context).size.width * .4,
                          child: SecondRow(
                            lable: "Value : ",
                            mykey: _mykey3,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .1,
                        ),
                        SizedBox(
                          height: 100,
                          width: MediaQuery.of(context).size.width * .4,
                          child: SecondRow(
                            lable: "payNo : ",
                            mykey: _mykey4,
                          ),
                        )
                      ],
                    ),
                    Text("Note :"),
                    SizedBox(height: 8),
                    TextFormField(
                      controller: note,
                      minLines: 2,
                      maxLines: 10,
                      onSaved: (newValue) {
                        notetext = newValue;
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .05,
                    ),
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
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .1,
                    ),
                    Center(
                        child: ElevatedButton(
                            onPressed: () {
                              _onsave();
                            },
                            child: Text("Transfer")))
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
