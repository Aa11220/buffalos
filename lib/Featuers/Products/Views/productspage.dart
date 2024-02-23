import 'dart:developer';

import '../../../providers/igrediantsprovider.dart';

import '../Controller/itemscontroller.dart';
import 'addandsave.dart';
import '../../../apis/categoriesapi.dart';

import '../../../models/Category.dart';
import '../../../models/item.dart';
import '../../../utility/Common%20funcation/disconnceted.dart';
import '../../../utility/commonwidget/drawer.dart';
import '../../../utility/lineargragr.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../../../providers/noteprovider.dart';

class productPage extends ConsumerStatefulWidget {
  const productPage({super.key});
  static const path = "/product";

  @override
  ConsumerState<productPage> createState() => _productPageState();
}

class _productPageState extends ConsumerState<productPage> {
  List<Category> catlist = [];
  List<item> _listitem = [];
  var isloading = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController category = TextEditingController();
  TextEditingController items = TextEditingController();
  SuggestionsBoxController enditcategory = SuggestionsBoxController();
  SuggestionsBoxController endititems = SuggestionsBoxController();
  String itemname = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  void deactivate() {
    category.text = "";
    items.text = "";
    super.deactivate();
  }

  @override
  void dispose() {
    category.text = "";
    items.text = "";
    category.dispose();
    items.dispose();
    super.dispose();
  }

  String _Categorykey = "";
  String _itemkey = "";
  void onsave() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      mylist1 = [];
      mylist = [];
      setState(() {
        isloading = true;
      });

      await ref.read(Itemcontrollerprovider).getItem(_itemkey, context);

      setState(() {
        isloading = false;
      });
    }
  }

  List<Category> mylist1 = [];
  List<item> mylist = [];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          gradient: linear,
        ),
        child: GestureDetector(
          onTap: () {
            enditcategory.close();
            endititems.close();
          },
          child: Scaffold(
            drawer: MyDrawer(context),
            appBar: AppBar(title: const Text("Products"), actions: [
              Image.asset("assets/img/image005.png"),
            ]),
            body: isloading == true
                ? const Center(
                    child: CircularProgressIndicator.adaptive(),
                  )
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(
                        20,
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Category",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF90391E)),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                              width: 250,
                              height: 70,
                              child: TypeAheadFormField<Category?>(
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      value.trim().isEmpty ||
                                      !mylist1.any((element) =>
                                          element.categoryName == value)) {
                                    return "Please Select valid item";
                                  } else {
                                    return null;
                                  }
                                },
                                onSaved: (newValue) {},
                                suggestionsBoxController: enditcategory,
                                suggestionsBoxVerticalOffset: 0,
                                textFieldConfiguration: TextFieldConfiguration(
                                  decoration: const InputDecoration(
                                      hintText: "Select..",
                                      filled: true,
                                      fillColor: Colors.white,
                                      suffixIcon: Icon(
                                          Icons.keyboard_double_arrow_down)),
                                  controller: category,
                                ),
                                suggestionsBoxDecoration:
                                    const SuggestionsBoxDecoration(),
                                suggestionsCallback: (A) async {
                                  mylist1 = await ref
                                      .watch(CategoriesApiprovider)
                                      .fetchCategories();
                                  return mylist1.where((element) {
                                    return element.categoryName
                                        .toLowerCase()
                                        .contains(A.toLowerCase());
                                  });
                                },
                                itemBuilder: (context, Category? itemData) {
                                  return ListTile(
                                      title: Text(itemData!.categoryName));
                                },
                                onSuggestionSelected: (suggestion) async {
                                  // loadlists();
                                  items.text = "";
                                  category.text = suggestion!.categoryName;
                                  _Categorykey =
                                      suggestion.pkCategory.toString();
                                  _listitem = await ref
                                      .read(Itemcontrollerprovider)
                                      .getItems(_Categorykey);
                                  print(suggestion);
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              "Items",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF90391E)),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                              width: 250,
                              height: 70,
                              child: TypeAheadFormField<item?>(
                                onSaved: (newValue) {},
                                suggestionsBoxVerticalOffset: 0,
                                textFieldConfiguration: TextFieldConfiguration(
                                  decoration: const InputDecoration(
                                      hintText: "Select..",
                                      filled: true,
                                      fillColor: Colors.white,
                                      suffixIcon: Icon(
                                          Icons.keyboard_double_arrow_down)),
                                  controller: items,
                                ),
                                suggestionsBoxDecoration:
                                    const SuggestionsBoxDecoration(),
                                suggestionsCallback: (A) async {
                                  if (category.text.isNotEmpty) {
                                    mylist = await ref
                                        .watch(Itemcontrollerprovider)
                                        .getItems(_Categorykey);
                                    return mylist.where((element) {
                                      return element.itemName!
                                          .toLowerCase()
                                          .contains(A.toLowerCase());
                                    });
                                  } else {
                                    // items.text = "";
                                    return [];
                                  }
                                },
                                itemBuilder: (context, item? itemData) {
                                  return ListTile(
                                      title: Text(itemData!.itemName!));
                                },
                                onSuggestionSelected: (suggestion) {
                                  items.text = suggestion!.itemName!;

                                  _itemkey = suggestion.pkItemId!.toString();
                                },
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      value.trim().isEmpty ||
                                      !mylist.any((element) =>
                                          element.itemName == value)) {
                                    return "Please Select valid item";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Center(
                              child: Container(
                                width: 150,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: const Color(0xFF90391E),
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    disconnected(() {
                                      ref.invalidate(ingredianlistProvider);
                                      ref
                                          .watch(notelistProvider.notifier)
                                          .deletall();
                                      onsave();
                                      category.text = "";
                                      items.text = "";
                                    }, context);
                                  },
                                  child: const Center(
                                      child: Text(
                                    "Search item",
                                    style: TextStyle(color: Colors.white),
                                  )),
                                ),
                              ),
                            ),
                            Center(
                              child: Container(
                                margin: const EdgeInsets.all(20),
                                width: 150,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: const Color(0xFF90391E),
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    disconnected(() {
                                      ref.invalidate(ingredianlistProvider);
                                      ref
                                          .watch(notelistProvider.notifier)
                                          .deletall();
                                      print('connected');
                                      Navigator.of(context).pushNamed(
                                          addandsave.path,
                                          arguments: {
                                            "Search": false,
                                          }).then((_) => setState(() {}));
                                    }, context);
                                    category.text = "";
                                    items.text = "";
                                  },
                                  child: const Center(
                                      child: Text(
                                    "Add new item",
                                    style: TextStyle(color: Colors.white),
                                  )),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
