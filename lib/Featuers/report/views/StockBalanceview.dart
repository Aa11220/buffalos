import '../../../models/Stock_Material.dart';
import '../../../models/Stores.dart';
import '../../../models/stock_store.dart';
import '../../../utility/commonwidget/drawer.dart';
import '../../../utility/lineargragr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../../../models/Material.dart' as ma;
import '../../../utility/commonwidget/appbar.dart';
import '../controller/Stock_Material_Cntroller.dart';
import '../controller/Stock_Store_controller.dart';
import '../controller/Storess_Controller.dart';
import '../controller/materialcontroller.dart';

class StockBalance extends ConsumerStatefulWidget {
  const StockBalance({super.key});
  static const path = '/StockBalance';
  @override
  ConsumerState<StockBalance> createState() => _StockBalanceState();
}

int? id;

class _StockBalanceState extends ConsumerState<StockBalance> {
  TextEditingController material = TextEditingController();
  TextEditingController store = TextEditingController();

  bool _stock = false;
  bool _Material = false;
  bool _selected = false;
  String name = "";
  List<StockMaterial> materials = [];
  List<StockStore> listStores = [];
  void setmaterial() async {
    materials =
        await ref.watch(StockMaterialControllerProvider).getStockStore(id);
    setState(() {});
  }

  void setstores() async {
    listStores =
        await ref.watch(StockStoreControllerProvider).getStockStore(id);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          gradient: linear,
        ),
        child: Scaffold(
          appBar: Customappbar(
            text: "Stock Balance",
          ),
          drawer: MyDrawer(
            context,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Theme(
                    data: Theme.of(context).copyWith(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                    ),
                    child: CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      onChanged: (a) {
                        setState(() {
                          materials = [];
                          material.clear();
                          store.clear();
                          _selected = false;
                          name = "";
                          _Material = _stock;
                          _stock = !_stock;
                        });
                      },
                      value: _stock,
                      title: const Text(
                        "Filtter by Material",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                  CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    onChanged: (a) {
                      setState(() {
                        materials = [];
                        store.clear();
                        material.clear();
                        _selected = false;
                        name = "";
                        _stock = _Material;
                        _Material = !_Material;
                      });
                    },
                    value: _Material,
                    title: const Text("Filtter by stock",
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                  ),
                  if (_Material)
                    Container(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(left: 20),
                                width: MediaQuery.of(context).size.width * .3,
                                child: GestureDetector(
                                  onTap: () => store.clear(),
                                  child: TypeAheadField<Stores>(
                                    // suggestionsBoxController: enditcategory,
                                    suggestionsBoxVerticalOffset: 0,
                                    textFieldConfiguration:
                                        TextFieldConfiguration(
                                      onTap: () => store.clear(),
                                      decoration: const InputDecoration(
                                          hintText: "Stock",
                                          filled: true,
                                          fillColor: Colors.white,
                                          suffixIcon: Icon(Icons
                                              .keyboard_double_arrow_down)),
                                      controller: store,
                                    ),

                                    suggestionsBoxDecoration:
                                        const SuggestionsBoxDecoration(),
                                    suggestionsCallback: (A) async {
                                      final mylist1 = await ref
                                          .watch(StoressControllerProvider)
                                          .getall(context);
                                      return mylist1.where((element) {
                                        return element.storeName!
                                            .toLowerCase()
                                            .contains(A.toLowerCase());
                                      });
                                    },
                                    itemBuilder: (context, Stores? itemData) {
                                      return ListTile(
                                          title: Text(itemData!.storeName!));
                                    },
                                    onSuggestionSelected: (suggestion) async {
                                      materials = [];
                                      name = suggestion.storeName!;
                                      store.text = suggestion.storeName!;

                                      id = suggestion.pkStoreId;

                                      setmaterial();
                                      setState(() {
                                        _selected = true;
                                      });

                                      print(materials);
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(name)
                            ],
                          ),
                          if (_selected)
                            Container(
                              margin: const EdgeInsets.only(top: 12),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Expanded(
                                            child: Text(
                                              "Name",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              "Type",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                            ),
                                          ),
                                          Expanded(
                                              child: Text(
                                            "Unit",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          )),
                                          Expanded(
                                              child: Text(
                                            "Balance",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          )),
                                        ]),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .5,
                                      child: Builder(builder: (context) {
                                        return ListView.builder(
                                          itemBuilder: (context, index) {
                                            return Container(
                                              color: Colors.white,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 2),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                      child: Text(
                                                          materials[index]
                                                              .MaterialName)),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Expanded(
                                                      child: Text(
                                                          materials[index]
                                                              .MatType)),
                                                  Expanded(
                                                      child: Text(
                                                          materials[index]
                                                              .unit)),
                                                  Expanded(
                                                      child: Text(
                                                          materials[index]
                                                              .qty
                                                              .toString())),
                                                ],
                                              ),
                                            );
                                          },
                                          itemCount: materials.length,
                                        );
                                      }),
                                    )
                                  ]),
                            )
                        ],
                      ),
                    ),
                  if (_stock)
                    Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 20),
                              width: MediaQuery.of(context).size.width * .3,
                              child: TypeAheadField<ma.Material>(
                                // suggestionsBoxController: enditcategory,
                                suggestionsBoxVerticalOffset: 0,
                                textFieldConfiguration: TextFieldConfiguration(
                                  decoration: const InputDecoration(
                                      hintText: "Material",
                                      filled: true,
                                      fillColor: Colors.white,
                                      suffixIcon: Icon(
                                          Icons.keyboard_double_arrow_down)),
                                  controller: material,
                                ),
                                suggestionsBoxDecoration:
                                    const SuggestionsBoxDecoration(),
                                suggestionsCallback: (A) async {
                                  final mylist1 = await ref
                                      .watch(MaterialreportcontrollerProvider)
                                      .getall();
                                  return mylist1.where((element) {
                                    return element.materialName!
                                        .toLowerCase()
                                        .contains(A.toLowerCase());
                                  });
                                },
                                itemBuilder: (context, ma.Material? itemData) {
                                  return ListTile(
                                      title: Text(itemData!.materialName!));
                                },
                                onSuggestionSelected: (suggestion) async {
                                  listStores = [];
                                  name = suggestion.materialName!;
                                  material.text = suggestion.materialName!;
                                  id = suggestion.pkMaterialId;
                                  setstores();
                                  setState(() {
                                    _selected = true;
                                  });
                                  // items.text = "";
                                  // category.text = suggestion!.categoryName;
                                  // _Categorykey =
                                  //     suggestion.pkCategory.toString();
                                  // _listitem = await ref
                                  //     .read(Itemcontrollerprovider)
                                  //     .getItems(_Categorykey);
                                  // print(suggestion);
                                },
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(name)
                          ],
                        ),
                        if (_selected)
                          Container(
                            margin: const EdgeInsets.only(top: 12),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Expanded(
                                          child: Text(
                                            "Name",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            "Type",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                        ),
                                      ]),
                                  SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height * 5,
                                    child: ListView.builder(
                                      itemBuilder: (context, index) {
                                        return Container(
                                          color: Colors.white,
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 2),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 2),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                  child: Text(listStores[index]
                                                      .MaterialName)),
                                              Expanded(
                                                  child: Text(listStores[index]
                                                      .TotalQty
                                                      .toString())),
                                            ],
                                          ),
                                        );
                                      },
                                      itemCount: listStores.length,
                                    ),
                                  )
                                ]),
                          )
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
