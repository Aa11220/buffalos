import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .4,
                        child: Commoncolumn(
                          lable: "Supplier Name",
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .1,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .4,
                        child: Commoncolumn(
                          lable: "ballance",
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
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .1,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .4,
                        child: Commoncolumn(
                          lable: "Address",
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .5,
                  ),
                  ElevatedButton(onPressed: () {}, child: Text("Save"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
