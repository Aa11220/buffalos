import 'package:buffalos/apis/Supplier/SupplierApi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/Supplier/SupplierModule.dart';
import '../../../utility/commonwidget/appbar.dart';
import '../../../utility/commonwidget/drawer.dart';
import '../../../utility/lineargragr.dart';
import '../widget/commoncolumn.dart';

class SupplierScreen extends ConsumerStatefulWidget {
  const SupplierScreen({super.key});
  static const path = "/SupplierScreen";
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SupplierState();
}

class _SupplierState extends ConsumerState<SupplierScreen> {
  GlobalKey<FormState> _key = GlobalKey();
  GlobalKey<FormFieldState> _keyname = GlobalKey();
  GlobalKey<FormFieldState> _keybalance = GlobalKey();
  GlobalKey<FormFieldState> _keyphone = GlobalKey();
  GlobalKey<FormFieldState> _keyaddress = GlobalKey();
  void onsave() {
    if (_key.currentState!.validate()) {
      try {
        final name = _keyname.currentState!.value;
        final balance = _keybalance.currentState!.value;
        final phone = _keyphone.currentState!.value;
        final address = _keyaddress.currentState!.value;
        final bal = double.tryParse(balance);
        final supp = SupllierModule(
            balance: bal,
            pkSupplierId: null,
            supplierAddress: address,
            supplierName: name,
            supplierTel: phone);
        ref.read(SupplierApiProvider).setsupplier(supp);
        _key.currentState?.reset();
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Done")));
      } on Exception catch (e) {
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
          appBar: Customappbar(text: "Supplier"),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: SingleChildScrollView(
              child: Form(
                key: _key,
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .4,
                          child: Commoncolumn(
                            lable: "Supplier Name",
                            keyy: _keyname,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .1,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .4,
                          child: Commoncolumn(
                            lable: "ballance",
                            keyy: _keybalance,
                            number: true,
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .4,
                          child: Commoncolumn(
                            lable: "Phone Number",
                            keyy: _keyphone,
                            number: true,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .1,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .4,
                          child: Commoncolumn(
                            lable: "Address",
                            keyy: _keyaddress,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .5,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          onsave();
                        },
                        child: Text("Save"))
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
