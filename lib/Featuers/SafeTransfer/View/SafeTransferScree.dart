import 'dart:io';

import 'package:path/path.dart' as p;

import 'package:buffalos/utility/commonwidget/appbar.dart';
import 'package:buffalos/utility/commonwidget/drawer.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
          appBar: Customappbar(text: "Safe Transfer"),
          drawer: MyDrawer(context),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        height: 100,
                        width: MediaQuery.of(context).size.width * .4,
                        child: FristRow(
                          lable: "Supplier Name",
                          text: true,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .1,
                      ),
                      SizedBox(
                        height: 100,
                        width: MediaQuery.of(context).size.width * .4,
                        child: FristRow(
                          lable: "ballance",
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
                          lable: "Supplier Name",
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .1,
                      ),
                      SizedBox(
                        height: 100,
                        width: MediaQuery.of(context).size.width * .4,
                        child: SecondRow(
                          lable: "ballance",
                        ),
                      )
                    ],
                  ),
                  Text("Note :"),
                  SizedBox(height: 8),
                  TextField(
                    minLines: 2,
                    maxLines: 10,
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
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .1,
                  ),
                  Center(
                      child: ElevatedButton(
                          onPressed: () {}, child: Text("Transfer")))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
