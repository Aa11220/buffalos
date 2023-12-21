import 'dart:io';

import 'package:buffalos/Featuers/Products/Controller/Materialcontroller.dart';
import 'package:buffalos/Featuers/Products/Views/productspage.dart';
import 'package:buffalos/models/mm.dart';
import 'package:buffalos/providers/materialProvider.dart';
import 'package:buffalos/providers/mmprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../../../apis/PurchaseApi.dart';
import '../../../models/Material.dart' as ma;
import '../../../providers/fileProvider.dart';
import '../../../providers/purchdataprovider.dart';
import '../../../utility/commonwidget/appbar.dart';
import '../../../utility/commonwidget/drawer.dart';
import '../../../utility/lineargragr.dart';
import '../widgets/CustomCard.dart';

class AddRawMaterialScreen extends ConsumerStatefulWidget {
  const AddRawMaterialScreen({super.key});
  static const String path = "/Add_Raw_Material";

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddRawMaterialScreenState();
}

class _AddRawMaterialScreenState extends ConsumerState<AddRawMaterialScreen> {
  SuggestionsBoxController select = SuggestionsBoxController();
  double? a;
  List<mm> tosend = [];
  TextEditingController material = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void deactivate() {
    ref.invalidate(purchasedataProvider);
    ref.invalidate(mmProvider);
    ref.invalidate(itemsProvid);
    ref.invalidate(filenotifierProvider);
    super.deactivate();
  }

  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => select.close(),
        child: Container(
          decoration: BoxDecoration(gradient: linear),
          child: Scaffold(
            appBar: Customappbar(
              text: "Purchase Data",
              image: false,
            ),
            drawer: MyDrawer(context),
            body: Center(
              child: Column(children: [
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .8,
                  child: TypeAheadField(
                    textFieldConfiguration: TextFieldConfiguration(
                      onTap: () => material.clear(),
                      controller: material,
                      decoration: const InputDecoration(
                          hintText: "Select ...",
                          suffixIcon: Icon(Icons.keyboard_arrow_down)),
                    ),
                    suggestionsCallback: (A) async {
                      final _mylist =
                          await ref.read(MaterialcontrollerProvider).getall();
                      return _mylist.where((element) {
                        return element.materialName!
                            .toLowerCase()
                            .contains(A.toLowerCase());
                      });
                    },
                    suggestionsBoxController: select,
                    itemBuilder: (context, itemData) => SizedBox(
                        height: 50,
                        child: Center(child: Text(itemData.materialName!))),
                    onSuggestionSelected: (suggestion) {
                      material.text = suggestion.materialName!;
                      ref.read(itemsProvid).add(suggestion);
                      ref.read(mmProvider.notifier).add(suggestion.fkUnitId!);
                    },
                  ),
                ),
                Consumer(
                  builder: (context, ref, child) {
                    List<ma.Material> list = ref.watch(itemsProvid);

                    return list.isEmpty == true
                        ? Expanded(child: Text("Select to add Raw Materials"))
                        : Expanded(
                            child: ListView.builder(
                              itemBuilder: (context, index) {
                                return CustomCard(
                                  material: list[index],
                                  index: index,
                                );
                              },
                              itemCount: list.length,
                            ),
                          );
                  },
                ),
                Consumer(
                  builder: (context, ref, child) {
                    final c = ref.watch(mmProvider);
                    return Container(
                      color: Colors.white,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("Total is : " + ((c.total)).toString()),
                            isloading == true
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : ElevatedButton(
                                    onPressed: () async {
                                      setState(() {
                                        isloading = true;
                                      });
                                      ref
                                          .read(purchasedataProvider.notifier)
                                          .setData(
                                              totalPrice:
                                                  ref.read(mmProvider).total,
                                              buyMaterialDetails:
                                                  ref.read(mmProvider).mylist);
                                      final kk = await ref
                                          .read(PurchaseApiProvider)
                                          .sendPurchase(
                                              ref.read(purchasedataProvider));
                                      print(ref
                                          .read(purchasedataProvider)
                                          .toMap());
                                      if (ref.read(filenotifierProvider) !=
                                          null) {
                                        File file = ref
                                            .read(filenotifierProvider.notifier)
                                            .send();
                                        ref
                                            .read(PurchaseApiProvider)
                                            .addfile(file, kk.toString());
                                        print("done");
                                      }
                                      ref.invalidate(purchasedataProvider);
                                      ref.invalidate(mmProvider);
                                      ref.invalidate(itemsProvid);
                                      ref.invalidate(filenotifierProvider);
                                      setState(() {
                                        isloading = false;
                                      });
                                      Navigator.of(context).popUntil(
                                          ModalRoute.withName(
                                              productPage.path));
                                    },
                                    child: Text("Save"))
                          ]),
                    );
                  },
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
