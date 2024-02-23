import 'dart:io';
import '../../Products/Views/productspage.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';

import '../../../apis/SafeData/SafeEpress.dart';
import '../../../apis/userapi.dart';
import '../../../models/Supplier/SupplierModule.dart';
import '../../../providers/fileProvider.dart';
import '../../../providers/purchdataprovider.dart';
import '../../../utility/commonwidget/appbar.dart';
import '../../../utility/commonwidget/drawer.dart';
import '../../../utility/lineargragr.dart';
import '../Controller/SupplierController/SupplierController.dart';
import '../Controller/storeController.dart';
import 'AddRawMaterialScreen.dart';

// import 'package:buffalos/Featuers/purchaes/Controller/SupplierController/SupplierController.dart';
// import 'package:buffalos/apis/userapi.dart';
// import 'package:buffalos/utility/commonwidget/appbar.dart';
// import 'package:buffalos/utility/commonwidget/drawer.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_typeahead/flutter_typeahead.dart';
// import 'package:intl/intl.dart';
import 'package:path/path.dart' as p;
// import '../../../apis/SafeData/SafeEpress.dart';
// import '../../../models/Supplier/SupplierModule.dart';
// import '../../../providers/fileProvider.dart';
// import '../../../providers/purchdataprovider.dart';
// import '../../../utility/lineargragr.dart';
// import '../Controller/storeController.dart';
// import 'AddRawMaterialScreen.dart';

class MPurchaseDataScreenM extends ConsumerStatefulWidget {
  const MPurchaseDataScreenM({super.key});
  static const path = "/MPurchaseScreenM";
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PurchaseDataScreenState();
}

class _PurchaseDataScreenState extends ConsumerState<MPurchaseDataScreenM> {
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
  DateTime myDate = DateTime.now();
  void _selectDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(myDate.year+1)
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  int? fkSupplierId;
  String? billNo;
  int? fkStoreId;
  String? pay;
  int? safeid;

  void pickfile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      _selectedFile = File(result.files.single.path!);
      ref.read(filenotifierProvider.notifier).setfile(_selectedFile!);
      ;
      setState(() {});
    } else {}
  }

  void onsave() {
    if (_key.currentState!.validate()) {
      _key.currentState!.save();
      if (_selectedDate != null) {
        final shiftid = ref.read(authprovider).logedin.shiftID;
        final pkBuyingId = 0;

//fkSupplierId
// billNo
        final date = DateFormat("yyyy-MM-dd").format(_selectedDate!);
        final bool payment = (pay) == "Cash" ? false : true;

        ref.read(purchasedataProvider.notifier).setData(
            fK_Shift_ID: shiftid,
            pkBuyingId: pkBuyingId,
            fkSupplierId: fkSupplierId,
            billNo: billNo,
            date: date,
            payment: payment,
            fkStoreId: fkStoreId,
            fkSafeId: safeid);
        print(ref.read(purchasedataProvider).toMap());
        Navigator.of(context).pushNamed(MAddMaterialM.path);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Select date")));
      }
    }
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
          child: PopScope(
            canPop: false,
            onPopInvoked: (didPop) {
              if (didPop) {
                return;
              }
              Navigator.of(context)
                  .popUntil(ModalRoute.withName(productPage.path));
            },
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
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Enter something";
                              }
                              return null;
                            },
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
                              fkSupplierId = suggestion.pkSupplierId;
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
                            onSaved: (newValue) => billNo = newValue,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Enter something";
                              }
                              return null;
                            },
                            controller: Number,
                            decoration: InputDecoration(
                                hintText: "Enter Invoice Number..."),
                            // keyboardType: TextInputType.number,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text("Store Nmae"),
                          SizedBox(
                            height: 15,
                          ),
                          TypeAheadFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Enter something";
                              }
                              return null;
                            },
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
                              fkStoreId = suggestion.pkStoreId;
                              print(fkStoreId);
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
                                        child: Text(
                                            p.basename(_selectedFile!.path)),
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
                                          style: TextStyle(
                                              color: Color(0xFF923D22)),
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
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Enter something";
                              }
                              return null;
                            },
                            onSaved: (newValue) {
                              pay = newValue;
                            },
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
                                height: 50,
                                child: Center(child: Text(itemData))),
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
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Enter something";
                              }
                              return null;
                            },
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
                                child: Center(child: Text(itemData.safeName!))),
                            suggestionsCallback: (pattern) async {
                              final _list = await ref
                                  .read(SafeDataExpressApiProvider)
                                  .getsafeData();

                              return _list.where((element) {
                                return element.safeName!
                                    .toLowerCase()
                                    .contains(pattern.toLowerCase());
                              });
                            },
                            onSuggestionSelected: (suggestion) {
                              safeid = suggestion.fkSafeId;
                              safe.text = suggestion.safeName!;
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                onsave();
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
      ),
    );
  }
}
